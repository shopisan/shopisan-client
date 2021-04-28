import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/components/StoreDetailScreenTab/DetailsCommercialScreenTab/CategoriesCommercial.dart';
import 'package:shopisan/components/StoreDetailScreenTab/PostsTabCommercial/PostsTabCommercial.dart';
import 'package:shopisan/model/Post.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/utils/common.dart';

class DescriptionTabCommercial extends StatefulWidget {
  const DescriptionTabCommercial(
      {Key key, @required this.store, @required this.height})
      : super(key: key);

  final Store store;
  final double height;

  @override
  _DescriptionTabCommercialState createState() =>
      _DescriptionTabCommercialState();
}

class _DescriptionTabCommercialState extends State<DescriptionTabCommercial> {
  final String locale = getLocaleCode();
  List<Post> posts;

  @override
  Widget build(BuildContext context) {
    Store store = widget.store;

    return Column(
      children: [
        CategoriesCommercial(
          store: store,
        ),
        Container(
            height: widget.height - 250 - 73 - 70,
            margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    /*decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(color: CustomColors.spread),
                    )),*/
                    child: Text(
                      AppLocalizations.of(context).description.toUpperCase(),
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    // height: 200,
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
                    child:
                        /*SingleChildScrollView(
                      child: */
                        Text(
                      store?.getDescriptionLocale(locale) ?? "",
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.justify,
                    ),
                    /*),*/
                  ),
                  PostsTabCommercial(
                    store: store,
                    posts: posts,
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
