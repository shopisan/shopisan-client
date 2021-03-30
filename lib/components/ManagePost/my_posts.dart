import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, "/create_post");
      },
    );
  }
}
