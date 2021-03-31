import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shopisan/model/Post.dart';
import 'package:shopisan/theme/colors.dart';

class ManagePost extends StatefulWidget {
  const ManagePost({Key key, @required this.postId}) : super(key: key);

  final int postId;

  @override
  _ManagePostState createState() => _ManagePostState();
}

class _ManagePostState extends State<ManagePost> {
  Future<Post> getPost() async {
    final response = await http.get(
        Uri.http("10.0.2.2:8000", "/api/posts/posts/"),
        headers: {'Accept': 'application/json'});
    try {
      if (response.statusCode == 200) {
        return Post.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      print("Oops: $Exception");
    }
    return null;
  }

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
                label: Text(
                  AppLocalizations.of(context).createPost,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/create_post');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
