import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/components/CommercialScreenTab/DescriptionTabCommercial/DetailsDescriptionTabCommercial/ConnectCommercial.dart';
import 'package:shopisan/model/OpeningTime.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';

import 'DetailsDescriptionTabCommercial/TimesCommercial.dart';

class DescriptionTabCommercial extends StatefulWidget {
  const DescriptionTabCommercial({Key key, @required this.storeId})
      : super(key: key);

  final int storeId;

  @override
  _DescriptionTabCommercialState createState() =>
      _DescriptionTabCommercialState();
}

class _DescriptionTabCommercialState extends State<DescriptionTabCommercial> {
  Store store;
  OpeningTimeCollection openingTimes;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(color: CustomColors.spread),
                )),
                child: Text(
                  "DESCRIPTION",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 120,
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: SingleChildScrollView(
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien non nulla vestibulum elementum et sed eros. Proin et metus vel urna elementum euismod."
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien non nulla vestibulum elementum et sed eros. Proin et metus vel urna elementum euismod.",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: CustomColors.textDescription,
                    ),
                  ),
                ),
              ),
              TimesCommercial(
                openingTimes: openingTimes,
              ),
              ConnectCommercial(),
            ],
          ),
        ));
  }
}
