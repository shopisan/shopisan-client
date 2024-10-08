import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopisan/blocs/authentication/authentication_bloc.dart';
import 'package:shopisan/repository/user_repository.dart';
import 'package:shopisan/screens/Login.dart';
import 'package:shopisan/screens/Profile.dart';
import 'package:shopisan/utils/common.dart';

class SettingsTab extends StatelessWidget {
  final userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    final state = context.select((AuthenticationBloc bloc) => bloc.state);

    if (state is AuthenticationAuthenticated) {
      return ProfileScreen();
    }

    if (state is AuthenticationUnauthenticated) {
      return LoginPage(
        userRepository: userRepository,
      );
    }

    return LoadingIndicator();
  }
}
