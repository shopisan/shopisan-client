import 'package:flutter/material.dart';

import 'colors.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: CustomColors.lightRed,
        scaffoldBackgroundColor: CustomColors.background,
        fontFamily: 'Montserrat',
        buttonTheme: ButtonThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: CustomColors.lightPurple,
        ));
  }
}
