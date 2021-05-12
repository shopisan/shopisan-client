import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/components/Post/post_preview.dart';
import 'package:shopisan/model/Post.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/common.dart';

class ManagePost extends StatefulWidget {
  @override
  _ManagePostState createState() => _ManagePostState();
}

class _ManagePostState extends State<ManagePost> {
  FutureOr refreshList(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          bottomOpacity: 0.0,
          elevation: 8,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            AppLocalizations.of(context).editPosts,
            style: Theme.of(context).textTheme.headline3,
          )),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: CustomColors.textDark,
              ),
              child: TextButton.icon(
                icon: Icon(
                  Icons.post_add_outlined,
                  color: Colors.white,
                ),
                label: Text(AppLocalizations.of(context).createPost,
                    style: Theme.of(context).textTheme.headline1),
                onPressed: () {
                  Navigator.pushNamed(context, '/create_post')
                      .then(refreshList);
                },
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(AppLocalizations.of(context).post.toUpperCase(),
                  style: Theme.of(context).textTheme.headline4),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: getScreenHeight(context) - 90 - 80 - 3,
                    child: FutureBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Post> posts = snapshot.data;
                          return Container(
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              children: posts.map((post) {
                                    return TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                                context, '/create_post',
                                                arguments: {"postId": post.id})
                                            .then(refreshList);
                                      },
                                      child: PostPreview(post: post),
                                    );
                                  })?.toList() ??
                                  [],
                            ),
                          );
                        }
                        return LoadingIndicator();
                      },
                      future: fetchPostsByOwnedStores(),
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
