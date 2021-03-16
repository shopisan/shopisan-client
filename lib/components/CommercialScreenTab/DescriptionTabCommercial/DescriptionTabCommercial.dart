import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/components/CommercialScreenTab/DescriptionTabCommercial/DetailsDescriptionTabCommercial/ConnectCommercial.dart';
import 'package:shopisan/theme/colors.dart';

class DescriptionTabCommercial extends StatefulWidget {
  @override
  _DescriptionTabCommercialState createState() => _DescriptionTabCommercialState();
}

class _DescriptionTabCommercialState extends State<DescriptionTabCommercial> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20,10,20,0),
      decoration: BoxDecoration(
          color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
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
              )
            ),
            child: Text("DESCRIPTION", style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            ),
          ),
          Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien non nulla vestibulum elementum et sed eros. Proin et metus vel urna elementum euismod.",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: CustomColors.textDescription,
                      ),),
                  ),
          ConnectCommercial(),
        ],
      ),
    );
  }
}
