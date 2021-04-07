import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopisan/components/Post/post_preview.dart';
import 'package:shopisan/model/Post.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';

class PostsCommercialScreen extends StatelessWidget {
  final Post post;
  final Store store;

  PostsCommercialScreen({@required this.post, @required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.lightBlue,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(store.name, style: Theme.of(context).textTheme.headline2),
      ),
      body: Container(
        color: CustomColors.lightBlue,
        child: SizedBox(
          width: double.infinity,
          child: ListView(
            children: [
              Container(
                // margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColors.search,
                ),
                child: PostPreview(
                  post: post,
                ) /*Column(
                  children: [
                    // HeaderPostsCommercial(),
                    PicturesPostsCommercial(post: post),
                    DescriptionPostsCommercial(),
                  ],
                )*/
                ,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
