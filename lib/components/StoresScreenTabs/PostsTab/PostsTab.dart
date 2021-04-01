import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopisan/components/Post/post_preview.dart';
import 'package:shopisan/model/Post.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/utils/common.dart';

class PostsTab extends StatelessWidget {
  const PostsTab({Key key, @required this.stores, @required this.posts})
      : super(key: key);

  final List<Store> stores;
  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(); // a virer
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: SizedBox(
        width: double.infinity,
        child: ListView(
          // @todo map des posts
          children: [
            // Container(
            //   padding: EdgeInsets.all(20),
            //   margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     color: CustomColors.search,
            //   ),
            //   child: Column(
            //     children: [
            //       HeaderPosts(stores: stores),
            //       PicturePosts(),
            //       DescriptionPosts(),
            //     ],
            //   ),
            // ),
            ListView(
              scrollDirection: Axis.vertical,
              children: posts?.map((post) {
                    return PostPreview(post: post);
                  })?.toList() ??
                  [],
            ),
          ],
        ),
      ),
    );
  }
}
