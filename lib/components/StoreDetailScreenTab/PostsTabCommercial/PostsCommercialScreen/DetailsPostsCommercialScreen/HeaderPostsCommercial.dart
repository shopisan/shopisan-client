import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderPostsCommercial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Product Name", style: Theme.of(context).textTheme.headline1),
          ],
        ));
  }
}
