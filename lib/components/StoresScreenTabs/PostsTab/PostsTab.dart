import 'package:flutter/cupertino.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';

import 'DetailsPostsTab/DescriptionPosts.dart';
import 'DetailsPostsTab/HeaderPosts.dart';
import 'DetailsPostsTab/PicturePosts.dart';

class PostsTab extends StatefulWidget {
  const PostsTab({Key key, @required this.stores}) : super(key: key);

  final List<Store> stores;

  @override
  _PostsTabState createState() => _PostsTabState();
}

class _PostsTabState extends State<PostsTab> {
  List<Store> stores = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: SizedBox(
        width: double.infinity,
        child: ListView(
          // @todo map des posts
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
                  HeaderPosts(stores: stores),
                  PicturePosts(),
                  DescriptionPosts(),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: CustomColors.search,
              ),
              child: Column(
                children: [
                  HeaderPosts(),
                  PicturePosts(),
                  DescriptionPosts(),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: CustomColors.search,
              ),
              child: Column(
                children: [
                  HeaderPosts(),
                  PicturePosts(),
                  DescriptionPosts(),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: CustomColors.search,
              ),
              child: Column(
                children: [
                  HeaderPosts(),
                  PicturePosts(),
                  DescriptionPosts(),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: CustomColors.search,
              ),
              child: Column(
                children: [
                  HeaderPosts(),
                  PicturePosts(),
                  DescriptionPosts(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
