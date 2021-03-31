import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/theme/colors.dart';

import 'StoresScreen.dart';

class RegisterCommercialScreen extends StatefulWidget {
  @override
  _RegisterCommercialScreenState createState() =>
      _RegisterCommercialScreenState();
}

class _RegisterCommercialScreenState extends State<RegisterCommercialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/bg_login.jpg"),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Sign Up A Store",
                    style: Theme.of(context).textTheme.headline5),
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
                  child: TextField(
                    style: Theme.of(context).textTheme.bodyText1,
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
                        hintText: 'Enter valid mail id as abc@gmail.com'),
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
                  child: TextField(
                    obscureText: true,
                    style: Theme.of(context).textTheme.bodyText1,
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

                        labelText: 'Password',
                        hintText: 'Enter your secure password'),
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
                  child: TextField(
                    obscureText: true,
                    style: Theme.of(context).textTheme.bodyText1,
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

                        labelText: 'Please type your password again',
                        hintText: 'Enter your secure password'),
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => StoresScreen()));
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
        ],
      ),
    );
  }
}
