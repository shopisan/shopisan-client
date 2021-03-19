import 'package:flutter/material.dart';
import 'package:shopisan/screens/CommercialScreen.dart';
import 'package:shopisan/screens/StoresScreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) {
          return StoresScreen();
        });

      case '/store_detail':
        return MaterialPageRoute(builder: (_) {
          print(args);
          return CommercialScreen(storeId: args);
        });

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Center(
          child: Center(
            child: Text("This location doesn't exists"),
          ),
        ),
      );
    });
  }
}
