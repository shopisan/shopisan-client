import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/model/Store.dart';

class HeaderPosts extends StatefulWidget {
  // @todo ici, ce n'est pas le storeId que tu veux, mais le post
  //      Dans ce Post, tu trouvera le Store (normalement)
  const HeaderPosts({Key key, @required this.storeId}) : super(key: key);

  final int storeId;

  @override
  _HeaderPostsState createState() => _HeaderPostsState();
}

class _HeaderPostsState extends State<HeaderPosts> {
  Store store;

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
                  Navigator.pushNamed(context, "/store_detail", arguments: 800);
                },
                // @todo ici, pourquoi tu fais un FutureBuilder?
                //  Il n'y a pas de requete, ou de fonction async, pas besoin de future builder
                // Le post sera injecté depuis le widget de la tab avec les posts
                child: FutureBuilder<Store>(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final store = snapshot.data;
                      return Column(
                        children: [
                          Text(
                              // AppLocalizations.of(context).commercialName,
                              "${store.name}",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error",
                          style: TextStyle(color: Colors.black));
                    }

                    return CircularProgressIndicator();
                  },
                ),
              ),
              Text(
                "Product Name",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              )
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
