import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/components/Form/text_input.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/validators.dart';

class RegisterCommercialScreen extends StatefulWidget {
  @override
  _RegisterCommercialScreenState createState() =>
      _RegisterCommercialScreenState();
}

class _RegisterCommercialScreenState extends State<RegisterCommercialScreen> {
  TextEditingController _brandController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repeatPasswordController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String password;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _passwordController.addListener(() {
      setState(() {
        password = _passwordController.text;
      });
    });

    _submitRegistration() async {
      if (_formKey.currentState.validate()) {
        bool rslt = await sendStoreRegistration({
          "brand": _brandController.text,
          "name": _nameController.text,
          "surname": _surnameController.text,
          "username": _usernameController.text,
          "email": _emailController.text,
          "password": _passwordController.text,
          "phone": _phoneController.text,
          "message": _descriptionController.text
        });

        if (rslt) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(AppLocalizations.of(context).storeTicketSubmitted),
              backgroundColor: CustomColors.success,
            ));

            Navigator.of(context).popUntil(ModalRoute.withName("/"));
          });
        }
      }
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
                      Text(AppLocalizations.of(context).signUpStore,
                          style: Theme.of(context).textTheme.headline5),
                      TextInput(
                        controller: _brandController,
                        icon: Icons.store_outlined,
                        label: AppLocalizations.of(context).brand,
                        margin: EdgeInsets.fromLTRB(0, 50, 0, 20),
                        hint: AppLocalizations.of(context).brand,
                        validator: isEmpty,
                      ),
                      TextInput(
                        controller: _nameController,
                        icon: Icons.verified_user_outlined,
                        label: AppLocalizations.of(context).name,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        hint: AppLocalizations.of(context).name,
                        validator: isEmpty,
                      ),
                      TextInput(
                        controller: _surnameController,
                        icon: Icons.verified_user_outlined,
                        label: AppLocalizations.of(context).lastName,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        hint: AppLocalizations.of(context).lastName,
                        validator: isEmpty,
                      ),
                      TextInput(
                        controller: _usernameController,
                        icon: Icons.supervised_user_circle,
                        label: AppLocalizations.of(context).userName,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        hint: AppLocalizations.of(context).userName,
                        validator: isEmpty,
                      ),
                      TextInput(
                        controller: _emailController,
                        icon: Icons.mail_outline,
                        label: AppLocalizations.of(context).emailAddress,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        hint: AppLocalizations.of(context).emailHint,
                        validator: isValidEmail,
                      ),
                      TextInput(
                        controller: _phoneController,
                        icon: Icons.phone_android_outlined,
                        label: AppLocalizations.of(context).phoneNumber,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        hint: AppLocalizations.of(context).phoneNumber,
                        validator: isEmpty,
                        keyboardType: TextInputType.phone,
                      ),
                      TextInput(
                        obscureText: true,
                        controller: _passwordController,
                        icon: Icons.lock_outline,
                        label: AppLocalizations.of(context).password,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        hint: AppLocalizations.of(context).passHint,
                        validator: isEmpty,
                      ),
                      TextInput(
                        obscureText: true,
                        controller: _repeatPasswordController,
                        icon: Icons.lock_outline,
                        label: AppLocalizations.of(context).passwordConfirm,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        hint: AppLocalizations.of(context).passwordConfirm,
                        validator: passwordsMatch,
                        passwordValidation: password,
                      ),
                      TextInput(
                        controller: _descriptionController,
                        icon: Icons.text_snippet_outlined,
                        label: AppLocalizations.of(context).storeDescription,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        hint: AppLocalizations.of(context).storeDescriptionHint,
                        validator: isEmpty,
                        isTextarea: true,
                        keyboardType: TextInputType.multiline,
                      ),
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
                            AppLocalizations.of(context).signUpStore,
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
