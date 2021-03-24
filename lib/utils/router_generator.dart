import 'package:flutter/material.dart';
import 'package:shopisan/screens/CommercialScreen.dart';
import 'package:shopisan/screens/EditProfile.dart';
import 'package:shopisan/screens/ForgotPassword.dart';
import 'package:shopisan/screens/Login.dart';
import 'package:shopisan/screens/Register.dart';
import 'package:shopisan/screens/StoresScreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    final userRepository = settings.arguments;

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

      case '/login':
        return MaterialPageRoute(builder: (_) {
          print(userRepository);
          return LoginPage(userRepository: userRepository);
        });

      case '/register':
        return MaterialPageRoute(builder: (_) {
          return RegisterScreen();
        });

      case '/forgot_password':
        return MaterialPageRoute(builder: (_) {
          return ForgotPasswordScreen();
        });

      case '/edit_profile':
        return MaterialPageRoute(builder: (_) {
          return EditProfile();
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
