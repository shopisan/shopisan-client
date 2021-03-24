import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopisan/authentication/authentication_bloc.dart';
import 'package:shopisan/repository/user_repository.dart';
import 'package:shopisan/screens/Login.dart';
import 'package:shopisan/screens/Profile.dart';
import 'package:shopisan/utils/common.dart';

class SettingsTab extends StatelessWidget {
  final userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        // @ todo nope, juste faire passer les elements
        // if (state is AuthenticationUnintialized) {
        //   return Text("Un initialized");
        // }
        if (state is AuthenticationAuthenticated) {
          return LoginPage(
            userRepository: userRepository,
          );
        }
        if (state is AuthenticationUnauthenticated) {
          return ProfilePage();
        }
        return LoadingIndicator();
      },
    );
    // return Container(child: Center(child: Text("Plutôt en faire la page de profil?"),),
    // );
  }
}
