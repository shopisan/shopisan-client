import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopisan/components/Post/post_preview.dart';
import 'package:shopisan/model/Post.dart';
import 'package:shopisan/model/Store.dart';

class PostsTab extends StatelessWidget {
  const PostsTab({Key key, @required this.stores, @required this.posts})
      : super(key: key);

  final List<Store> stores;
  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: ListView(
        // reverse: true,
        scrollDirection: Axis.vertical,
        children: posts.reversed.map((post) {
              return PostPreview(post: post);
            })?.toList() ??
            [],
      ),
    );
  }
}
