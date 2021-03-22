import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/components/Login/login_form.dart';
import 'package:shopisan/screens/ForgotPassword.dart';
import 'package:shopisan/screens/Register.dart';
import 'package:shopisan/screens/StoresScreen.dart';
import 'package:shopisan/theme/colors.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopisan/repository/user_repository.dart';
import 'package:shopisan/authentication/authentication_bloc.dart';
import 'package:shopisan/login/login_bloc.dart';


class LoginPage extends StatelessWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login | Home Hub'),
      ),
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

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage("assets/img/bg_login.jpg"),
//                   fit: BoxFit.cover),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(20),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // aussi traduire le text login
//                 Text(
//                   "Log In",
//                   style: GoogleFonts.poppins(
//                       color: CustomColors.textResearch,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 30),
//                 ),
//                 Container(
//                   height: 50,
//                   width: double.infinity,
//                   margin: EdgeInsets.fromLTRB(0, 50, 0, 20),
//                   padding: EdgeInsets.only(left: 10),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(40),
//                     boxShadow: [
//                       BoxShadow(
//                         color: CustomColors.spreadRegister,
//                         spreadRadius: 5,
//                         blurRadius: 10,
//                       ),
//                     ],
//                   ),
//                   child: TextField(
//                     style: GoogleFonts.roboto(
//                       color: CustomColors.textDescription,
//                       fontSize: 14,
//                     ),
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(40),
//                           borderSide: BorderSide(
//                             width: 0,
//                             style: BorderStyle.none,
//                           ),
//                         ),
//                         // focusedBorder: OutlineInputBorder(
//                         //   borderSide: BorderSide(
//                         //       color: CustomColors.spread, width: 5),
//                         //   borderRadius: BorderRadius.circular(40),
//                         // ),
//                         labelText: AppLocalizations.of(context).emailAddress,
//                         hintText: AppLocalizations.of(context).emailHint),
//                   ),
//                 ),
//                 Container(
//                   height: 50,
//                   width: double.infinity,
//                   margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
//                   padding: EdgeInsets.only(left: 10),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(40),
//                     boxShadow: [
//                       BoxShadow(
//                         color: CustomColors.spreadRegister,
//                         spreadRadius: 5,
//                         blurRadius: 15,
//                       ),
//                     ],
//                   ),
//                   child: TextField(
//                     obscureText: true,
//                     style: GoogleFonts.roboto(
//                       color: CustomColors.textDescription,
//                       fontSize: 14,
//                     ),
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(40),
//                           borderSide: BorderSide(
//                             width: 0,
//                             style: BorderStyle.none,
//                           ),
//                         ),
//                         // focusedBorder: OutlineInputBorder(
//                         //   borderSide: BorderSide(
//                         //       color: CustomColors.spread, width: 5),
//                         //       borderRadius: BorderRadius.circular(40),
//                         // ),
//
//                         labelText: AppLocalizations.of(context).password,
//                         hintText: AppLocalizations.of(context).passHint),
//                   ),
//                 ),
//                 Container(
//                   height: 50,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(40),
//                     color: CustomColors.textResearch,
//                     boxShadow: [
//                       BoxShadow(
//                         color: CustomColors.spreadRegister,
//                         spreadRadius: 5,
//                         blurRadius: 15,
//                       ),
//                     ],
//                   ),
//                   // ignore: deprecated_member_use
//                   child: FlatButton(
//                     onPressed: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (_) => StoresScreen()));
//                     },
//                     child: Text(
//                       "Login",
//                       style: GoogleFonts.roboto(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 // ignore: deprecated_member_use
//                 FlatButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (_) => ForgotPasswordScreen()));
//                   },
//                   child: Text(
//                     AppLocalizations.of(context).forgotPassword,
//                     style: GoogleFonts.roboto(
//                       fontSize: 14,
//                       color: CustomColors.textDescription,
//                     ),
//                   ),
//                 ),
//                 // ignore: deprecated_member_use
//                 FlatButton(
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (_) => RegisterScreen()));
//                   },
//                   child: Text(
//                     AppLocalizations.of(context).register,
//                     style: GoogleFonts.roboto(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: CustomColors.textResearch,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
