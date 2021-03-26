import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopisan/post_creation/post_creation_bloc.dart';
import 'package:shopisan/screens/CommercialScreen.dart';
import 'package:shopisan/screens/StoresScreen.dart';
import 'package:shopisan/screens/post_creation.dart';

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

      case '/manage_post':
        return MaterialPageRoute(builder: (_) {
          // return StoresScreen();
          return BlocProvider<PostCreationBloc>(
              create: (context) {
                return PostCreationBloc()
                  ..add(IsStarted(postId: args));
              },
              child: Scaffold(
                body: SingleChildScrollView(child: PostCreation(),),
              ));
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
