import 'package:flutter/material.dart';
import 'package:shopisan/theme/style.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/router_generator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopisan',
      theme: CustomTheme.lightTheme,
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: '/'
    );
  }
}

