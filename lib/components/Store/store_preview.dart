import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';

class StorePreview extends StatelessWidget {
  final Store store;

  StorePreview({@required this.store});

  @override
  Widget build(BuildContext context) {
    String _image = store.profilePicture?.file;

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
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
                image: _image != null ? DecorationImage(
                    image: NetworkImage(_image)) : null),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${store.name}',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: RatingBar.builder(
                      initialRating: 3,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 10,
                      itemPadding: EdgeInsets.symmetric(horizontal: 0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                      glow: true,
                    ),
                  ),
                ],
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
