import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/components/CommercialScreenTab/PostsTabCommercial/PostsCommercialScreen/DetailsPostsCommercialScreen/DescriptionPostsCommercial.dart';
import 'package:shopisan/components/CommercialScreenTab/PostsTabCommercial/PostsCommercialScreen/DetailsPostsCommercialScreen/HeaderPostsCommercial.dart';
import 'package:shopisan/components/CommercialScreenTab/PostsTabCommercial/PostsCommercialScreen/DetailsPostsCommercialScreen/PicturesPostsCommercial.dart';
import 'package:shopisan/theme/colors.dart';

class PostsCommercialScreen extends StatefulWidget {
  @override
  _PostsCommercialScreenState createState() => _PostsCommercialScreenState();
}

class _PostsCommercialScreenState extends State<PostsCommercialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.commercialBlue,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Commercial Name",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        color: CustomColors.commercialBlue,
        child: SizedBox(
          width: double.infinity,
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColors.search,
                ),
                child: Column(
                  children: [
                    HeaderPostsCommercial(),
                    PicturesPostsCommercial(),
                    DescriptionPostsCommercial(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
