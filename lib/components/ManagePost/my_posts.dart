import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopisan/components/Post/post_preview.dart';
import 'package:shopisan/model/Post.dart';

class MyPosts extends StatelessWidget {
  MyPosts({@required this.posts});

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height),
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: posts?.map((post) {
              return PostPreview(post: post);
            })?.toList() ??
            [],
      ),
    );
  }
}
