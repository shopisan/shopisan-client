import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/blocs/login/login_bloc.dart';
import 'package:shopisan/components/Form/text_input.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/common.dart';
import 'package:shopisan/utils/validators.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      if (_formKey.currentState.validate()) {
        BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
          username: _emailController.text,
          password: _passwordController.text,
        ));
      }
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFaliure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context).loginError),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            constraints: BoxConstraints.expand(),
            alignment: Alignment.center,
            child: SingleChildScrollView(child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(AppLocalizations.of(context).logIn,
                      style: Theme.of(context).textTheme.headline5),
                  TextInput(
                    controller: _emailController,
                    icon: Icons.mail_outline,
                    label: AppLocalizations.of(context).emailAddress,
                    margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
                    padding: EdgeInsets.only(left: 10),
                    hint: AppLocalizations.of(context).emailAddress,
                    validator: isEmpty,
                  ),
                  TextInput(
                    controller: _passwordController,
                    icon: Icons.lock_outline,
                    label: AppLocalizations.of(context).password,
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    padding: EdgeInsets.only(left: 10),
                    hint: AppLocalizations.of(context).passHint,
                    obscureText: true,
                    validator: isEmpty,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: CustomColors.textDark,
                      boxShadow: [
                        BoxShadow(
                          color: CustomColors.spreadRegister,
                          spreadRadius: 5,
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: TextButton(
                      onPressed:
                      state is! LoginLoading ? _onLoginButtonPressed : null,
                      child: Text(
                        AppLocalizations.of(context).logIn,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // shape: StadiumBorder(
                      //   side: BorderSide(
                      //     color: Colors.black,
                      //     width: 2,
                      //   ),
                      // ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgot_password');
                      },
                      child: Text(
                        AppLocalizations.of(context).forgotPassword,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      AppLocalizations.of(context).register,
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.textDark,
                      ),
                    ),
                  ),
                  Container(
                    child: state is LoginLoading ? LoadingIndicator() : null,
                  ),
                ],
              ),
            ),),
          );
        },
      ),
    );
  }
}
