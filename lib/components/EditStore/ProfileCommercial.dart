import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/theme/colors.dart';

class ProfileCommercial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 50,
            width: double.infinity,
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: CustomColors.spreadRegister,
                  spreadRadius: 5,
                  blurRadius: 15,
                ),
              ],
            ),
            child: TextFormField(
              style: GoogleFonts.roboto(
                color: CustomColors.textDescription,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.store_outlined,
                    color: CustomColors.iconsActive,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  labelText: AppLocalizations.of(context).storeName),
            ),
          ),
          Container(
            height: 50,
            width: double.infinity,
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: CustomColors.spreadRegister,
                  spreadRadius: 5,
                  blurRadius: 15,
                ),
              ],
            ),
            child: TextFormField(
              style: GoogleFonts.roboto(
                color: CustomColors.textDescription,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.streetview_outlined,
                    color: CustomColors.iconsActive,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  labelText: AppLocalizations.of(context).street),
            ),
          ),
        ],
      ),
    );
  }
}
