import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/components/Form/text_input.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/common.dart';
import 'package:shopisan/utils/validators.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool tokenSent = false;

  @override
  Widget build(BuildContext context) {
    _submitForm() async {
      if (_formKey.currentState.validate()) {
        bool rslt = await forgotPasswordSubmit(
            {"email": _emailController.text, "lang": getLocaleCode()});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: rslt ? CustomColors.success : CustomColors.error,
            content: Text(rslt
                ? AppLocalizations.of(context).forgotPasswordMailSent
                : AppLocalizations.of(context).anErrorOccurred)));

        if (rslt) {
          Navigator.of(context).pushNamed("/reset_password",
              arguments: {"email": _emailController.text});
        }
      }
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
                width: double.infinity,
                padding: EdgeInsets.all(20),
                constraints: BoxConstraints.expand(),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context).forgotPassword,
                            style: Theme.of(context).textTheme.headline5,
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                            child: Text(
                              AppLocalizations.of(context).forgPassText,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: CustomColors.textDark,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: TextInput(
                              controller: _emailController,
                              icon: (Icons.mail_outline),
                              label: AppLocalizations.of(context).emailAddress,
                              hint: AppLocalizations.of(context).emailHint,
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 40),
                              validator: isValidEmail,
                            ),
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
                                AppLocalizations.of(context).resetLink,
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                )),
          ],
        ));
  }
}
