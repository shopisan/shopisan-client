import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/model/Store.dart';

class HeaderPosts extends StatefulWidget {
  const HeaderPosts({Key key, @required this.stores}) : super(key: key);

  final List<Store> stores;

  // @todo ici, ce n'est pas le storeId que tu veux, mais le post
  //      Dans ce Post, tu trouvera le Store (normalement)

  // const HeaderPosts({Key key, @required this.storeId}) : super(key: key);
  //
  // final int storeId;

  @override
  _HeaderPostsState createState() => _HeaderPostsState();
}

class _HeaderPostsState extends State<HeaderPosts> {
  List<Store> stores = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              // ignore: deprecated_member_use
              FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/store_detail", arguments: {"storeId": 800});
                },
                // @todo Le post sera injecté depuis le widget de la tab avec les posts
                child: Text(AppLocalizations.of(context).commercialName,
                    // "${store.name}",
                    style: Theme.of(context).textTheme.headline2),
              ),
              Text("Product Name",
                  style: Theme.of(context).textTheme.headline2),
            ],
          ),

          // ignore: deprecated_member_use
          FlatButton(
              onPressed: () {
                // todo ajouter l'ajout aux favoris directement depuis les posts ?
              },
              child: Icon(
                Icons.favorite,
              ))
        ],
      ),
    );
  }
}
