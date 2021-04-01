import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopisan/components/StoreDetailScreenTab/PostsTabCommercial/PostsCommercialScreen/DetailsPostsCommercialScreen/DescriptionPostsCommercial.dart';
import 'package:shopisan/components/StoreDetailScreenTab/PostsTabCommercial/PostsCommercialScreen/DetailsPostsCommercialScreen/HeaderPostsCommercial.dart';
import 'package:shopisan/components/StoreDetailScreenTab/PostsTabCommercial/PostsCommercialScreen/DetailsPostsCommercialScreen/PicturesPostsCommercial.dart';
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
        backgroundColor: CustomColors.lightBlue,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Commercial Name",
            style: Theme.of(context).textTheme.headline2),
      ),
      body: Container(
        color: CustomColors.lightBlue,
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
