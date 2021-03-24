import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/theme/colors.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
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
          //     decoration: BoxDecoration(
          //       image: DecorationImage(
          //           image: AssetImage("assets/img/bg_login.jpg"),
          //           fit: BoxFit.cover),
          //     ),
          //     ),
          Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(20, 100, 20, 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context).signUp,
                      style: GoogleFonts.poppins(
                          color: CustomColors.textResearch,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(0, 50, 0, 20),
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                            color: CustomColors.spreadRegister,
                            spreadRadius: 5,
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        style: GoogleFonts.roboto(
                          color: CustomColors.textDescription,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            // focusedBorder: OutlineInputBorder(
                            //   borderSide: BorderSide(
                            //       color: CustomColors.spread, width: 5),
                            //   borderRadius: BorderRadius.circular(40),
                            // ),
                            labelText:
                                AppLocalizations.of(context).emailAddress,
                            hintText: AppLocalizations.of(context).emailHint),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                            color: CustomColors.spreadRegister,
                            spreadRadius: 5,
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        obscureText: true,
                        style: GoogleFonts.roboto(
                          color: CustomColors.textDescription,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            // focusedBorder: OutlineInputBorder(
                            //   borderSide: BorderSide(
                            //       color: CustomColors.spread, width: 5),
                            //       borderRadius: BorderRadius.circular(40),
                            // ),
                            labelText: AppLocalizations.of(context).password,
                            hintText: AppLocalizations.of(context).passHint),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                            color: CustomColors.spreadRegister,
                            spreadRadius: 5,
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        obscureText: true,
                        style: GoogleFonts.roboto(
                          color: CustomColors.textDescription,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          // focusedBorder: OutlineInputBorder(
                          //   borderSide: BorderSide(
                          //       color: CustomColors.spread, width: 5),
                          //       borderRadius: BorderRadius.circular(40),
                          // ),

                          labelText:
                              AppLocalizations.of(context).passwordConfirm,
                          hintText: AppLocalizations.of(context).passHint,
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: CustomColors.textResearch,
                        boxShadow: [
                          BoxShadow(
                            color: CustomColors.spreadRegister,
                            spreadRadius: 5,
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (_) => StoresScreen()));
                          Navigator.pushNamed(context, '/');
                        },
                        child: Text(
                          AppLocalizations.of(context).signUp,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => RegisterCommercialScreen()));
                      },
                      child: Text(
                        AppLocalizations.of(context).signUpStore,
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: CustomColors.textDescription,
                        ),
                      ),
                    ),
                    // ignore: deprecated_member_use
                    // FlatButton(
                    //   onPressed: () {
                    //     Navigator.pushNamed(context, '/login');
                    //     // Navigator.push(context,
                    //     //     MaterialPageRoute(builder: (_) => LoginScreen()));
                    //   },
                    //   child: Text(
                    //     "Log In Here",
                    //     style: GoogleFonts.roboto(
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.bold,
                    //       color: CustomColors.textResearch,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
