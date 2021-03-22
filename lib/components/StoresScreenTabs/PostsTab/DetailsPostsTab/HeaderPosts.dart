import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/models/Store.dart';

class HeaderPosts extends StatefulWidget {
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
