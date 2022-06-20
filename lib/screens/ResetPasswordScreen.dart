import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/components/Form/text_input.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/validators.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  ResetPasswordScreen({required this.email});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? password;
  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    String email = widget.email;
    _passwordController.addListener(() {
      setState(() {
        password = _passwordController.text;
      });
    });

    _submitForm() async {
      if (_formKey.currentState!.validate()) {
        bool rslt = await resetPasswordSubmit({
          "email": email,
          "token": _tokenController.text.trim(),
          "password": _passwordController.text
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: rslt ? CustomColors.success : CustomColors.error,
            content: Text(rslt
                ? AppLocalizations.of(context)!.resetPasswordSuccess
                : AppLocalizations.of(context)!.anErrorOccurred)));

        if (rslt) {
          Navigator.of(context).popUntil(ModalRoute.withName("/"));
        }
      }
    }

    _onPasswordVisibilityChange(){
      setState(() {
        _passwordVisible = !_passwordVisible;
      });
    }

    return Scaffold(
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottomOpacity: 0.0,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              constraints: BoxConstraints.expand(),
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.resetPassword,
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: Text(
                          AppLocalizations.of(context)!.resetPassText,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: CustomColors.textDark,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      TextInput(
                        controller: _tokenController,
                        icon: Icons.lock_outline,
                        label: AppLocalizations.of(context)!.resetPassToken,
                        hint: AppLocalizations.of(context)!.resetPassTokenHint,
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        validator: isEmpty,
                      ),
                      TextInput(
                        controller: _passwordController,
                        icon: Icons.lock_outline,
                        label: AppLocalizations.of(context)!.password,
                        hint: AppLocalizations.of(context)!.passHint,
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        validator: isEmpty,
                        obscureText: true,
                        setPasswordVisibility: _onPasswordVisibilityChange,
                        passwordVisible: _passwordVisible,
                      ),
                      TextInput(
                        controller: _repeatPasswordController,
                        icon: Icons.lock_outline,
                        label: AppLocalizations.of(context)!.passwordConfirm,
                        hint: AppLocalizations.of(context)!.passwordConfirm,
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 40),
                        validator: passwordsMatch,
                        passwordValidation: password,
                        obscureText: true,
                        setPasswordVisibility: _onPasswordVisibilityChange,
                        passwordVisible: _passwordVisible,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: CustomColors.textDark,
                          boxShadow: [
                            BoxShadow(
                              color: CustomColors.spreadRegister,
                              spreadRadius: 5,
                              blurRadius: 15,
                            ),
                          ],
                        ),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          onPressed: _submitForm,
                          child: Text(
                            AppLocalizations.of(context)!.resetPassword,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
