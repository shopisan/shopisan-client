import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';

class MapItem extends StatelessWidget {
  const MapItem({Key key, @required this.stores}) : super(key: key);

  final List<Store> stores;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: SizedBox(
        width: 400,
        height: 60,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: stores
              .map((store) => TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/store_detail",
                          arguments: store.id);
                    },
                    child: Container(
                      height: 50,
                      width: 150,
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
                                  "${store.name}",
                                  // AppLocalizations.of(context).commercialName,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: CustomColors.textDescription,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
