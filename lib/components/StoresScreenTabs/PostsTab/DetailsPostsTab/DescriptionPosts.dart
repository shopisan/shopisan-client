import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DescriptionPosts extends StatefulWidget {
  @override
  _DescriptionPostsState createState() => _DescriptionPostsState();
}

class _DescriptionPostsState extends State<DescriptionPosts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 250,
            height: 100,
            child: SingleChildScrollView(
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eu quam nec erat feugiat sollicitudin non vitae nisl."
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eu quam nec erat feugiat sollicitudin non vitae nisl.",
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Text(
            "Price €",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
