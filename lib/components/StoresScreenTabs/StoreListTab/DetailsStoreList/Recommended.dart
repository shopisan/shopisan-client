import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/theme/colors.dart';

class Recommended extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("RECOMMENDED", style: Theme.of(context).textTheme.headline1),
              Container(
                padding: EdgeInsets.only(right: 30),
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: CustomColors.iconsActive,
                      size: 13,
                    ),
                    Text("more",
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: CustomColors.iconsActive,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              )
            ],
          ),
          Container(
            height: 175,
          )
        ],
      ),
    );
  }
}
