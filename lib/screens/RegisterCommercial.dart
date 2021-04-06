import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/components/Form/text_input.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/validators.dart';

class RegisterCommercialScreen extends StatefulWidget {
  @override
  _RegisterCommercialScreenState createState() =>
      _RegisterCommercialScreenState();
}

class _RegisterCommercialScreenState extends State<RegisterCommercialScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repeatPasswordController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String password;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _passwordController.addListener(() {
      password = _passwordController.text;
    });

    _submitRegistration() {
      _formKey.currentState.validate();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          // Container(
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage("assets/img/bg_login.jpg"),
          //         fit: BoxFit.cover),
          //   ),
          // ),
          Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Container(
                // height: double.infinity,
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Sign Up A Store",
                          style: Theme.of(context).textTheme.headline5),
                      TextInput(
                        controller: _usernameController,
                        icon: null,
                        noIcon: true,
                        label: AppLocalizations.of(context).userName,
                        margin: EdgeInsets.fromLTRB(0, 50, 0, 20),
                        hint: AppLocalizations.of(context).userName,
                        validator: isEmpty,
                      ),
                      TextInput(
                        controller: _emailController,
                        icon: null,
                        noIcon: true,
                        label: AppLocalizations.of(context).emailAddress,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        hint: AppLocalizations.of(context).emailHint,
                        validator: isValidEmail,
                      ),
                      TextInput(
                        obscureText: true,
                        controller: _passwordController,
                        icon: null,
                        noIcon: true,
                        label: AppLocalizations.of(context).password,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        hint: AppLocalizations.of(context).passHint,
                        validator: isEmpty,
                      ),
                      TextInput(
                        obscureText: true,
                        controller: _repeatPasswordController,
                        icon: null,
                        noIcon: true,
                        label: AppLocalizations.of(context).passwordConfirm,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        hint: AppLocalizations.of(context).passwordConfirm,
                        validator: passwordsMatch,
                        passwordValidation: password,
                      ),
                      TextInput(
                        controller: _descriptionController,
                        icon: null,
                        noIcon: true,
                        label: AppLocalizations.of(context).storeDescription,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        hint: AppLocalizations.of(context).storeDescriptionHint,
                        validator: isEmpty,
                        isTextarea: true,
                        keyboardType: TextInputType.multiline,
                      ),
                      // Container(
                      //   height: 50,
                      //   width: double.infinity,
                      //   margin: EdgeInsets.fromLTRB(0, 50, 0, 20),
                      //   padding: EdgeInsets.only(left: 10),
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(40),
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: CustomColors.spreadRegister,
                      //         spreadRadius: 5,
                      //         blurRadius: 15,
                      //       ),
                      //     ],
                      //   ),
                      //   child: TextField(
                      //     style: Theme.of(context).textTheme.bodyText1,
                      //     decoration: InputDecoration(
                      //         border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(40),
                      //           borderSide: BorderSide(
                      //             width: 0,
                      //             style: BorderStyle.none,
                      //           ),
                      //         ),
                      //         // focusedBorder: OutlineInputBorder(
                      //         //   borderSide: BorderSide(
                      //         //       color: CustomColors.spread, width: 5),
                      //         //   borderRadius: BorderRadius.circular(40),
                      //         // ),
                      //         labelText: 'Email Adress',
                      //         hintText: 'Enter valid mail id as abc@gmail.com'),
                      //   ),
                      // ),
                      // Container(
                      //   height: 50,
                      //   width: double.infinity,
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      //   padding: EdgeInsets.only(left: 10),
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(40),
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: CustomColors.spreadRegister,
                      //         spreadRadius: 5,
                      //         blurRadius: 15,
                      //       ),
                      //     ],
                      //   ),
                      //   child: TextField(
                      //     obscureText: true,
                      //     style: Theme.of(context).textTheme.bodyText1,
                      //     decoration: InputDecoration(
                      //         border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(40),
                      //           borderSide: BorderSide(
                      //             width: 0,
                      //             style: BorderStyle.none,
                      //           ),
                      //         ),
                      //         // focusedBorder: OutlineInputBorder(
                      //         //   borderSide: BorderSide(
                      //         //       color: CustomColors.spread, width: 5),
                      //         //       borderRadius: BorderRadius.circular(40),
                      //         // ),
                      //
                      //         labelText: 'Password',
                      //         hintText: 'Enter your secure password'),
                      //   ),
                      // ),
                      // Container(
                      //   height: 50,
                      //   width: double.infinity,
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                      //   padding: EdgeInsets.only(left: 10),
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(40),
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: CustomColors.spreadRegister,
                      //         spreadRadius: 5,
                      //         blurRadius: 15,
                      //       ),
                      //     ],
                      //   ),
                      //   child: TextField(
                      //     obscureText: true,
                      //     style: Theme.of(context).textTheme.bodyText1,
                      //     decoration: InputDecoration(
                      //         border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(40),
                      //           borderSide: BorderSide(
                      //             width: 0,
                      //             style: BorderStyle.none,
                      //           ),
                      //         ),
                      //         // focusedBorder: OutlineInputBorder(
                      //         //   borderSide: BorderSide(
                      //         //       color: CustomColors.spread, width: 5),
                      //         //       borderRadius: BorderRadius.circular(40),
                      //         // ),
                      //
                      //         labelText: 'Please type your password again',
                      //         hintText: 'Enter your secure password'),
                      //   ),
                      // ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(0, 50, 0, 40),
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
                          onPressed: () {
                            _submitRegistration();
                          },
                          child: Text(
                            "Sign Up A Store",
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
          ),
        ],
      ),
    );
  }
}
