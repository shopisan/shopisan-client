import 'dart:io';
import 'package:flutter/material.dart';

export './loading_indicator.dart';

double getScreenHeight(context) {
  double height = MediaQuery.of(context).size.height;
  var padding = MediaQuery.of(context).padding;
  return height - padding.top - padding.bottom;
}

double getFullScreenHeight(context) {
  return MediaQuery.of(context).size.height;
}

double getScreenWidth(context) {
  double width = MediaQuery.of(context).size.width;
  var padding = MediaQuery.of(context).padding;
  return width - padding.left - padding.right;
}

String getLocaleCode() {
  final String defaultLocale = Platform.localeName;
  if (defaultLocale.contains("fr")) {
    return "fr";
  }

  return "en";
}
