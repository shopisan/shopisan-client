import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/blocs/authentication/authentication_bloc.dart';
import 'package:shopisan/blocs/post_creation/post_creation_bloc.dart';
import 'package:shopisan/components/Feed/post_media_form.dart';
import 'package:shopisan/components/Form/select_input.dart';
import 'package:shopisan/components/Utils/confirm.dart';
import 'package:shopisan/model/Post.dart';
import 'package:shopisan/model/PostMedia.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/common.dart';
import 'package:shopisan/utils/validators.dart';

class PostCreation extends StatefulWidget {
  PostCreation() : super();

  @override
  _PostCreationState createState() => _PostCreationState();
}

class _PostCreationState extends State<PostCreation> {
  List<PostMedia> postMedias = [];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Post? post =
        context.select((PostCreationBloc bloc) => bloc.state.post);
    AuthenticationAuthenticated authState =
        context.select((AuthenticationBloc bloc) => bloc.state as AuthenticationAuthenticated);

    final List<Store> stores = authState.user.profile!.ownedStores;
    final state = context.select((PostCreationBloc bloc) => bloc.state);

    if (state is RedirectPostCreationState) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
    }

    if ((state is DonePostCreationState) && state.success) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.postSaved),
            backgroundColor: CustomColors.success,
          ),
        );
      });
    }

    if (post == null) {
      return LoadingIndicator();
    }

    _sendForm() {
      if (_formKey.currentState!.validate()) {
        for (PostMedia postMedia in post.postMedia) {
          if (!oneFilled([postMedia.description_en, postMedia.description_fr])) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppLocalizations.of(context)!.atLeastOneDescriptionRequired),
                  backgroundColor: CustomColors.error,
                ),
              );
            });
            return;
          }

          if (postMedia.uploadFile == null && postMedia.media == null) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppLocalizations.of(context)!.pictureMissing),
                  backgroundColor: CustomColors.error,
                ),
              );
            });
            return;
          }

        }
        BlocProvider.of<PostCreationBloc>(context).add(ChangePost(post: post));
      }
    }

    _submitDeletePost() {
      BlocProvider.of<PostCreationBloc>(context).add(DeletePost());
    }

    _deletePost() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Confirm(
            executeFct: _submitDeletePost,
            title: AppLocalizations.of(context)!.deletePostTitle,
            text: AppLocalizations.of(context)!.deletePostText,
          );
        },
      );
    }

    _addPostMedia() {
      BlocProvider.of<PostCreationBloc>(context).add(AddPostMedia());
    }

    if (state is InitialPostCreationState) {
      return LoadingIndicator();
    } else if (state is DonePostCreationState && !state.success) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message != 'post created'
                ? AppLocalizations.of(context)!.postError
                : AppLocalizations.of(context)!.profilePicError),
            backgroundColor:
                state.success ? CustomColors.success : CustomColors.error,
          ),
        );
      });
    }

    _updateStore(String? storeUrl) {
      BlocProvider.of<PostCreationBloc>(context)
          .add(ChangePostStore(storeUrl: storeUrl ?? ""));
    }

    print(stores);

    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(
        margin: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: SelectInput(
                  value: post.store,
                  callback: _updateStore,
                  items: stores
                      .map((Store store) => DropdownMenuItem(
                      value: store.url,
                      child: Container(
                        width: 200,
                        child:
                        Text(store.name, overflow: TextOverflow.ellipsis),
                      )))
                      .toList(),
                  label: AppLocalizations.of(context)!.storePost,
                  icon: Icons.store,
                  validator: isEmpty,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  key: Key(post.postMedia.length.toString()),
                  children: (null != post && null != post.postMedia)
                      ? post.postMedia
                      .asMap()
                      .map((index, postMedia) => MapEntry(index,
                      PostMediaForm(index: index, postMedia: postMedia)))
                      .values
                      .toList()
                      : [],
                ),
              ),
              post.postMedia.length == 0
                  ? Container(
                padding: EdgeInsets.fromLTRB(10, 100, 10, 0),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.addPost,
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.center,
                    ),
                    Padding(padding: EdgeInsets.all(20)),
                    ElevatedButton(
                      onPressed: _addPostMedia,
                      child: Icon(
                        Icons.post_add_outlined,
                        size: 25,
                        color: Colors.black,
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              CustomColors.success),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(25)))),
                    ),
                  ],
                ),
              )
                  : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 50,
                        margin: EdgeInsets.only(bottom: 10),
                        child: ElevatedButton(
                          onPressed: _addPostMedia,
                          child: Icon(
                            Icons.post_add_outlined,
                            size: 19,
                            color: Colors.black,
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(
                                  CustomColors.success),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(25)))),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: CustomColors.textDark,
                    ),
                    child: state is LoadingPostCreationState
                        ? LoadingIndicator()
                        : TextButton(
                      onPressed: _sendForm,
                      child: Text(
                          post.id == null
                              ? AppLocalizations.of(context)!
                              .createPost
                              : AppLocalizations.of(context)!.editPost,
                          style:
                          Theme.of(context).textTheme.headline1),
                    ),
                  ),
                  post.id == null
                      ? Container()
                      : Container(
                    margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: CustomColors.textDark,
                    ),
                    child: TextButton(
                      onPressed: _deletePost,
                      child: Text(
                          AppLocalizations.of(context)!.deletePost,
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
