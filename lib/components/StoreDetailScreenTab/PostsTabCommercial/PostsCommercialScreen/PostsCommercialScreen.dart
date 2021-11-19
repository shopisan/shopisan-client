import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopisan/components/Post/post_preview.dart';
import 'package:shopisan/model/Post.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/common.dart';

class PostsCommercialScreen extends StatelessWidget {
  final Post post;
  final Store store;

  PostsCommercialScreen({required this.post, required this.store});

  @override
  Widget build(BuildContext context) {
    double height = getFullScreenHeight(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.lightBlue,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(store.name, style: Theme.of(context).textTheme.headline2),
      ),
      body: Container(
        height: height - 80,
        color: CustomColors.lightBlue,
        child: Center(child: PostPreview(post: post,),)
      ),
    );
  }
}
