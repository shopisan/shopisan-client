import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';

class StorePreview extends StatelessWidget {
  final Store store;

  StorePreview({@required this.store});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, "/store_detail", arguments: store.id);
      },
      // padding: EdgeInsets.all(0),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(5)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${store.name}',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black),
              ),
              Text(
                "${store.categories.map((category) => '${" " + category.fr + " "}')}",
                style: GoogleFonts.poppins(
                  color: CustomColors.textDescription,
                  fontSize: 12,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
