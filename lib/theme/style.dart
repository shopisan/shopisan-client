import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: CustomColors.iconsActive,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',
        buttonTheme: ButtonThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          buttonColor: CustomColors.iconsActive,
        ),
        textTheme: TextTheme(
          headline1: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          headline2: GoogleFonts.poppins(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          headline3: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          headline4: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          headline5: GoogleFonts.poppins(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: CustomColors.textDark),
          headline6: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: CustomColors.iconsActive),
          bodyText1:
              GoogleFonts.poppins(fontSize: 14, color: CustomColors.textLight),
          bodyText2:
              GoogleFonts.poppins(fontSize: 12, color: CustomColors.textLight),
        ));
  }
}
