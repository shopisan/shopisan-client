import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopisan/theme/colors.dart';

import 'PostsCommercialScreen/PostsCommercialScreen.dart';

class PostsTabCommercial extends StatefulWidget {
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
          20,
          (index) {
            return Center(
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => PostsCommercialScreen()));
                },
                // margin: EdgeInsets.all(3),
                color: CustomColors.lightBlue,
                child: Text(
                  "Pic $index",
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
