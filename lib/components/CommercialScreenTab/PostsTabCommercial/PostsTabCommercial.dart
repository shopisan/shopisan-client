import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopisan/theme/colors.dart';

class PostsTabCommercial extends StatefulWidget {
  @override
  _PostsTabCommercialState createState() => _PostsTabCommercialState();
}

class _PostsTabCommercialState extends State<PostsTabCommercial> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
        margin: EdgeInsets.fromLTRB(20,10,20,0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      child: GridView.count(
        crossAxisCount: 3,
        children:
          List.generate(20, (index) {
            return Center(
              child: Container(
                margin: EdgeInsets.all(3),
                color: CustomColors.commercialBlue,
                child:  Text(
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
