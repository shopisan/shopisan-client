import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopisan/model/Post.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/common.dart';

class PostsTabCommercial extends StatefulWidget {
  PostsTabCommercial(
      {@required this.store, @required this.posts, @required this.height});

  final Store store;
  final List<Post> posts;
  final double height;

  @override
  _PostsTabCommercialState createState() => _PostsTabCommercialState();
}

class _PostsTabCommercialState extends State<PostsTabCommercial> {
  @override
  Widget build(BuildContext context) {
    if (null == widget.posts) {
      return LoadingIndicator();
    }

    return Container(
      //height: widget.height - 250 - 73 - 20,
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
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      AppLocalizations.of(context).noPost,
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  FaIcon(
                    FontAwesomeIcons.newspaper,
                    color: CustomColors.iconsActive,
                    size: 40,
                  )
                ],
              ),
            )
          : GridView.count(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              padding: EdgeInsets.all(10),
              children: List.generate(
                widget.posts.reversed.length ?? 0,
                (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: CustomColors.lightBlue,
                          padding: EdgeInsets.all(0),
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
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(widget
                                    .posts[index].postMedia[0].media.file),
                                fit: BoxFit.cover,
                              )),
                        ) /*Image(
                        image: NetworkImage(
                            widget.posts[index].postMedia[0].media.file),
                        fit: BoxFit.cover,

                      ),*/
                        ),
                  );
                },
              ),
            ),
    );
  }
}
