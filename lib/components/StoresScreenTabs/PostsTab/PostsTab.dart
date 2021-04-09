import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopisan/components/Post/post_preview.dart';
import 'package:shopisan/model/Post.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';

class PostsTab extends StatelessWidget {
  const PostsTab({Key key, @required this.stores, @required this.posts})
      : super(key: key);

  final List<Store> stores;
  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return posts == null
        ? Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context).noPost,
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                  Padding(padding: EdgeInsets.all(20)),
                  FaIcon(
                    FontAwesomeIcons.newspaper,
                    color: CustomColors.iconsActive,
                    size: 40,
                  )
                ],
              ),
            ),
          )
        : Container(
            // padding: EdgeInsets.only(top: 10),
            child: ListView(
              // reverse: true,
              scrollDirection: Axis.vertical,
              children: posts.reversed.map((post) {
                    return PostPreview(post: post);
                  })?.toList() ??
                  [],
            ),
          );
  }
}
