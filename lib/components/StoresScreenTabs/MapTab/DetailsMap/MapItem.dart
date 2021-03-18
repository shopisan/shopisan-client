import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/screens/CommercialScreen.dart';
import 'package:shopisan/theme/colors.dart';

class MapItem extends StatefulWidget {
  @override
  _MapItemState createState() => _MapItemState();
}

class _MapItemState extends State<MapItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: SizedBox(
        height: 55,
        width: 400,
        // ignore: deprecated_member_use
        child: FlatButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => CommercialScreen()));
          },
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // Text(
                                //   AppLocalizations.of(context).city,
                                //   style: GoogleFonts.poppins(
                                //     fontSize: 14,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                Container(
                                  // margin: EdgeInsets.only(left: 10),
                                  child: RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 15,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                )
                              ],
                            ),
                            Text(
                              AppLocalizations.of(context).commercialName,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: CustomColors.textDescription,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // Text(
                                //   AppLocalizations.of(context).city,
                                //   style: GoogleFonts.poppins(
                                //     fontSize: 14,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                Container(
                                  // margin: EdgeInsets.only(left: 10),
                                  child: RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 15,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                )
                              ],
                            ),
                            Text(
                              AppLocalizations.of(context).commercialName,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: CustomColors.textDescription,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // Text(
                                //   AppLocalizations.of(context).city,
                                //   style: GoogleFonts.poppins(
                                //     fontSize: 14,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                Container(
                                  // margin: EdgeInsets.only(left: 10),
                                  child: RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 15,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                )
                              ],
                            ),
                            Text(
                              AppLocalizations.of(context).commercialName,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: CustomColors.textDescription,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // Text(
                                //   AppLocalizations.of(context).city,
                                //   style: GoogleFonts.poppins(
                                //     fontSize: 14,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                Container(
                                  // margin: EdgeInsets.only(left: 10),
                                  child: RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 15,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                )
                              ],
                            ),
                            Text(
                              AppLocalizations.of(context).commercialName,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: CustomColors.textDescription,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // Text(
                                //   AppLocalizations.of(context).city,
                                //   style: GoogleFonts.poppins(
                                //     fontSize: 14,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                Container(
                                  // margin: EdgeInsets.only(left: 10),
                                  child: RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 15,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                )
                              ],
                            ),
                            Text(
                              AppLocalizations.of(context).commercialName,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: CustomColors.textDescription,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
