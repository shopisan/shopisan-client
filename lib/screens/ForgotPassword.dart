import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            Text("Forgot Password", style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 30
            ),),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 40),
              child: Text("We will send you an email to reset your password. Please enter your email adress",
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
              padding: EdgeInsets.only(left:10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: CustomColors.spreadRegister,
                    spreadRadius: 5,
                    blurRadius: 15,),
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
                    labelText: 'Email Adress',
                    hintText: 'Enter valid mail id as abc@gmail.com'
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
                  " Send Reset Link", style: GoogleFonts.roboto(
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
