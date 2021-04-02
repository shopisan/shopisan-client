import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopisan/model/Post.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';

import 'PostsCommercialScreen/PostsCommercialScreen.dart';

class PostsTabCommercial extends StatefulWidget {
  final Store store;
  final List<Post> posts;

  PostsTabCommercial({@required this.store, @required this.posts});

  @override
  _PostsTabCommercialState createState() => _PostsTabCommercialState();
}

class _PostsTabCommercialState extends State<PostsTabCommercial> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 390,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(
          widget.posts?.length ?? 0,
          (index) {
            return Center(
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/post_detail', arguments: widget.posts[index]);
                },
                // margin: EdgeInsets.all(3),
                color: CustomColors.lightBlue,
                child: Text(
                  widget.posts[index]?.postMedia[0].description,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
