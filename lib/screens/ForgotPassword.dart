import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/theme/colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context).forgotPassword,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 40),
              child: Text(
                AppLocalizations.of(context).forgPassText,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: CustomColors.textResearch,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
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
              child: TextField(
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
                  labelText: AppLocalizations.of(context).emailAddress,
                  hintText: AppLocalizations.of(context).emailHint,
                ),
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 30),
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
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: () {
                  // todo send mail ;
                },
                child: Text(
                  AppLocalizations.of(context).resetLink,
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
    );
  }
}
