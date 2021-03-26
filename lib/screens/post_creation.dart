import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopisan/components/Feed/post_media_form.dart';
import 'package:shopisan/model/Post.dart';
import 'package:shopisan/model/PostMedia.dart';
import 'package:shopisan/post_creation/post_creation_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PostCreation extends StatefulWidget {
  PostCreation({Key key}) : super(key: key);

  @override
  _PostCreationState createState() => _PostCreationState();
}

class _PostCreationState extends State<PostCreation> {
  // @todo chopper l'url du store et le mettre en const
  List<PostMedia> postMedias = [];

  // @todo valider le form ++ envoyer si besoin

  @override
  Widget build(BuildContext context) {
    final Post post = context.select((PostCreationBloc bloc) => bloc.state.post);
    final state = context.select((PostCreationBloc bloc) => bloc.state);

    print("1st media: ${post.postMedia[0].description}");

    _sendForm(){
      print(postMedias);
      BlocProvider.of<PostCreationBloc>(context).add(ChangePost(
        post: post
      ));
    }

    _addPostMedia(){
      BlocProvider.of<PostCreationBloc>(context).add(AddPostMedia());
    }

    if (state is InitialPostCreationState){
      return Container(
          child: state is LoadingPostCreationState
              ? CircularProgressIndicator()
              : null,
        );
    }

    print("post id: ${post.id}");

    return  Container(
          child: Form(
          child: Padding(
          padding: EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(child:
            ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              key: Key(post.postMedia.length.toString()),
              children:
              (null != post && null != post.postMedia) ?
              post.postMedia.asMap().map((index, postMedia) => MapEntry(index,
                  PostMediaForm(index: index, postMedia: postMedia)
              )).values.toList() : [],
            ),),
            ElevatedButton(onPressed: _addPostMedia, child: Icon(Icons.add)),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.width * 0.22,
              child: Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: ElevatedButton(
                  onPressed: _sendForm,
                  child: Text(
                    post.id == null ? AppLocalizations.of(context).createPost :
                      AppLocalizations.of(context).editPost,
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
