import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopisan/model/Post.dart';
import 'package:shopisan/theme/colors.dart';

class PostPreview extends StatelessWidget {
  PostPreview({@required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/create_post', arguments: post.id);
      },
      child: Column(
        children: [
          Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: CustomColors.search,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(post.postMedia[0].media.file),
                    fit: BoxFit.cover,
                  ))),
          Container(
            margin: EdgeInsets.only(bottom: 40),
            padding: EdgeInsets.fromLTRB(0, 20, 10, 20),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: CustomColors.spread, width: 2))),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(
                                color: CustomColors.spread, width: 2))),
                    child: Text("${post.postMedia[0].description}",
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: post.postMedia[0].price == null
                          ? Text("")
                          : Text("${post.postMedia[0].price} €",
                              style: Theme.of(context).textTheme.headline2),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
