import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/blocs/post_creation/post_creation_bloc.dart';
import 'package:shopisan/components/Feed/post_media_form.dart';
import 'package:shopisan/components/Utils/confirm.dart';
import 'package:shopisan/model/Post.dart';
import 'package:shopisan/model/PostMedia.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/common.dart';

class PostCreation extends StatefulWidget {
  PostCreation({Key key}) : super(key: key);

  @override
  _PostCreationState createState() => _PostCreationState();
}

class _PostCreationState extends State<PostCreation> {
  List<PostMedia> postMedias = [];

  @override
  Widget build(BuildContext context) {
    final Post post =
        context.select((PostCreationBloc bloc) => bloc.state.post);
    final state = context.select((PostCreationBloc bloc) => bloc.state);

    if (state is RedirectPostCreationState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
    }

    if ((state is DonePostCreationState) && state.success) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).postSaved),
            backgroundColor: CustomColors.success,
          ),
        );
      });
    }

    _sendForm() {
      BlocProvider.of<PostCreationBloc>(context).add(ChangePost(post: post));
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
            title: AppLocalizations.of(context).deletePostTitle,
            text: AppLocalizations.of(context).deletePostText,
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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message != 'post created'
                ? AppLocalizations.of(context).postError
                : AppLocalizations.of(context).profilePicError),
            backgroundColor:
                state.success ? CustomColors.success : CustomColors.error,
          ),
        );
      });
    }

    if (post == null) {
      return LoadingIndicator();
    }

    return Container(
      child: Form(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  key: Key(post.postMedia.length.toString()),
                  children: (null != post && null != post.postMedia)
                      ? post.postMedia
                          .asMap()
                          .map((index, postMedia) => MapEntry(
                              index,
                              PostMediaForm(
                                  index: index, postMedia: postMedia)))
                          .values
                          .toList()
                      : [],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 50,
                    margin: EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      onPressed: _addPostMedia,
                      child: Icon(
                        Icons.add,
                        size: 19,
                        color: Colors.black,
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              CustomColors.success),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                  color: CustomColors.iconsActive,
                ),
                child: state is LoadingPostCreationState
                    ? LoadingIndicator()
                    : TextButton(
                        onPressed: _sendForm,
                        child: Text(
                            post.id == null
                                ? AppLocalizations.of(context).createPost
                                : AppLocalizations.of(context).editPost,
                            style: Theme.of(context).textTheme.headline3),
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
                        color: CustomColors.iconsActive,
                      ),
                      child: TextButton(
                        onPressed: _deletePost,
                        child: Text(AppLocalizations.of(context).deletePost,
                            style: Theme.of(context).textTheme.headline3),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
