import 'package:flutter/material.dart';

export './loading_indicator.dart';

double getScreenHeight(context){
  double height = MediaQuery.of(context).size.height;
  var padding = MediaQuery.of(context).padding;
  return height - padding.top - padding.bottom;
}

double getFullScreenHeight(context){
  return MediaQuery.of(context).size.height;
}
