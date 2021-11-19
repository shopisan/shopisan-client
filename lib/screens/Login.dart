import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopisan/blocs/authentication/authentication_bloc.dart';
import 'package:shopisan/blocs/login/login_bloc.dart';
import 'package:shopisan/components/Login/login_form.dart';
import 'package:shopisan/repository/user_repository.dart';

class LoginPage extends StatelessWidget {
  final UserRepository userRepository;

  LoginPage({required this.userRepository})
      : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: LoginForm(),
      ),
    );
  }
}

