import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopisan/model/Post.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';

class PostsTabCommercial extends StatefulWidget {
  final Store store;
  final List<Post> posts;

  PostsTabCommercial({@required this.store, @required this.posts});

  @override
  _PostsTabCommercialState createState() => _PostsTabCommercialState();
}

class _PostsTabCommercialState extends State<PostsTabCommercial> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 460,
      margin: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      child: widget.posts.length == 0
          ? Center(
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
            )
          : GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(10),
              children: List.generate(
                widget.posts.reversed.length ?? 0,
                (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    // ignore: deprecated_member_use
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: CustomColors.lightBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/post_detail',
                            arguments: {
                              "post": widget.posts[index],
                              "store": widget.store
                            });
                      },
                      // margin: EdgeInsets.all(3),

                      // padding: EdgeInsets.all(10),
                      // height: 100,
                      // child: Text(
                      //   widget.posts[index]?.postMedia[0].description,
                      // ),

                      child: Image(
                        image: NetworkImage(
                            widget.posts[0].postMedia[0].media.file),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
