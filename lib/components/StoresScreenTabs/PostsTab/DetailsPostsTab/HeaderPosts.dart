import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/components/StoresScreenTabs/MapTab/DetailsMap/GoogleMapScreen.dart';
import 'package:shopisan/screens/CommercialScreen.dart';

class HeaderPosts extends StatefulWidget {
  @override
  _HeaderPostsState createState() => _HeaderPostsState();
}

class _HeaderPostsState extends State<HeaderPosts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => CommercialScreen()));
            },
            child: Text("Commercial Name", style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            ),
          ),
          // ignore: deprecated_member_use
          FlatButton(
              onPressed: () {
                // todo ajouter l'ajout aux favoris directement depuis les posts ?
              },
              child: Icon(
                Icons.favorite,
              )
          )
        ],
      ),
    );
  }
}
