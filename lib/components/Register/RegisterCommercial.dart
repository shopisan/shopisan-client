import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as InputService;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/components/Form/CustomPhoneInput/intl_phone_number_input.dart';
import 'package:shopisan/components/Form/text_input.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/common.dart';
import 'package:shopisan/utils/validators.dart';

class RegisterCommercial extends StatefulWidget {
  @override
  _RegisterCommercialState createState() =>
      _RegisterCommercialState();
}

class _RegisterCommercialState extends State<RegisterCommercial> {
  TextEditingController _brandController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repeatPasswordController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String phoneNumber = "";
  String password = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _passwordController.addListener(() {
      setState(() {
        password = _passwordController.text;
      });
    });

    _submitRegistration() async {
      if (_formKey.currentState!.validate()) {
        Map<String, dynamic> rslt = await sendStoreRegistration({
          "brand": _brandController.text,
          "name": _nameController.text,
          "surname": _surnameController.text,
          "username": _usernameController.text,
          "email": _emailController.text,
          "password": _passwordController.text.trim(),
          "phone": phoneNumber,
          "message": _descriptionController.text,
          "lang": getLocaleCode()
        });

        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
          if (rslt.containsKey('success')) {
            FirebaseAnalytics()
                .logEvent(name: 'Owner registration', parameters: null);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(AppLocalizations.of(context)!.storeTicketSubmitted),
              backgroundColor: CustomColors.success,
            ));

            Navigator.of(context).popUntil(ModalRoute.withName("/"));
          } else {
            if (rslt.containsKey('username')) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(AppLocalizations.of(context)!.userNameTaken),
                backgroundColor: CustomColors.error,
              ));
            }

            if (rslt.containsKey('email')) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(AppLocalizations.of(context)!.emailTaken),
                backgroundColor: CustomColors.error,
              ));
            }
          }
        });
      }
    }

    return Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Container(
                // height: double.infinity,
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.all(20),
                      child: Text(
                        AppLocalizations.of(context)!.registerStore,
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.center,
                      ),
                      ),

                      TextInput(
                        controller: _brandController,
                        icon: Icons.store_outlined,
                        label: AppLocalizations.of(context)!.brand,
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                        hint: AppLocalizations.of(context)!.brand,
                        validator: isEmpty,
                      ),
                      TextInput(
                        controller: _nameController,
                        icon: Icons.verified_user_outlined,
                        label: AppLocalizations.of(context)!.name,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        hint: AppLocalizations.of(context)!.name,
                        validator: isEmpty,
                      ),
                      TextInput(
                        controller: _surnameController,
                        icon: Icons.verified_user_outlined,
                        label: AppLocalizations.of(context)!.lastName,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        hint: AppLocalizations.of(context)!.lastName,
                        validator: isEmpty,
                      ),
                      TextInput(
                        controller: _usernameController,
                        icon: Icons.person_outline,
                        label: AppLocalizations.of(context)!.userName,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        hint: AppLocalizations.of(context)!.userName,
                        validator: isEmpty,
                      ),
                      TextInput(
                        controller: _emailController,
                        icon: Icons.mail_outline,
                        label: AppLocalizations.of(context)!.emailAddress,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        hint: AppLocalizations.of(context)!.emailHint,
                        validator: isValidEmail,
                        inputFormatters: [
                          InputService.FilteringTextInputFormatter.deny(
                              RegExp(r"\s\b|\b\s|[ ]")
                          )
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          border: Border.all(color: CustomColors.spreadRegister, width: 2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          Padding(padding: EdgeInsets.only(left: 5)),
                          Icon(
                            Icons.phone_android_outlined,
                            color: CustomColors.iconsActive,
                            size: 20,
                          ),
                          Padding(padding: EdgeInsets.only(left: 15)),
                          Flexible(child: InternationalPhoneNumberInput(
                            onInputChanged: (_){
                              phoneNumber = _.phoneNumber;
                              },
                            textFieldController: _phoneController,
                            selectorTextStyle: Theme.of(context).textTheme.bodyText1,
                            selectorConfig: SelectorConfig(
                                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                              setSelectorButtonAsPrefixIcon: true
                            ),
                            errorMessage: AppLocalizations.of(context)!.phoneNumberInvalid,
                            textStyle: Theme.of(context).textTheme.bodyText1,
                            inputBorder: InputBorder.none,
                            spaceBetweenSelectorAndTextField: 0,
                            inputDecoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: null,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              /*labelText: label,
                              hintText: hint*/),
                          ))
                        ],),
                      ),
                      TextInput(
                        obscureText: true,
                        controller: _passwordController,
                        icon: Icons.lock_outline,
                        label: AppLocalizations.of(context)!.password,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        hint: AppLocalizations.of(context)!.passHint,
                        validator: isEmpty,
                      ),
                      TextInput(
                        obscureText: true,
                        controller: _repeatPasswordController,
                        icon: Icons.lock_outline,
                        label: AppLocalizations.of(context)!.passwordConfirm,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        hint: AppLocalizations.of(context)!.passwordConfirm,
                        validator: passwordsMatch,
                        passwordValidation: _passwordController.text,
                      ),
                      TextInput(
                        controller: _descriptionController,
                        icon: Icons.text_snippet_outlined,
                        label: AppLocalizations.of(context)!.storeDescription,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        hint: AppLocalizations.of(context)!.storeDescriptionHint,
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
                            AppLocalizations.of(context)!.signUpStore,
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
          );
  }
}
