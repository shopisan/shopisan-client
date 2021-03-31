import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/components/ManagePost/my_posts.dart';
import 'package:shopisan/model/Post.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/common.dart';

class ManagePost extends StatefulWidget {
  @override
  _ManagePostState createState() => _ManagePostState();
}

class _ManagePostState extends State<ManagePost> {
  List<Post> posts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: CustomColors.iconsActive,
              ),
              child: TextButton.icon(
                icon: Icon(
                  Icons.post_add_outlined,
                  color: Colors.black,
                ),
                label: Text(AppLocalizations.of(context).createPost,
                    style: Theme.of(context).textTheme.headline3),
                onPressed: () {
                  Navigator.pushNamed(context, '/create_post');
                },
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(AppLocalizations.of(context).post,
                  style: Theme.of(context).textTheme.headline4),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    // color: Colors.red,
                    height: 550,
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: FutureBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return MyPosts(posts: snapshot.data);
                        }
                        return LoadingIndicator();
                      },
                      future: getPosts(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
