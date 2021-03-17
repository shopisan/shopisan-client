import 'package:flutter/material.dart';
import 'package:shopisan/screens/Login.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) {
          return LoginScreen();
        });

      // case '/main':
      //   return MaterialPageRoute(builder: (_) {});

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
