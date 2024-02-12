import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/components/Form/save_button.dart';
import 'package:shopisan/components/Form/text_input.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/validators.dart';

class AddCode extends StatefulWidget {
  @override
  _AddCodeState createState() => _AddCodeState();
}

class _AddCodeState extends State<AddCode> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _codeController = TextEditingController();

    _submitUser() async {
      if (_formKey.currentState!.validate()) {
        int rslt = await addCode(_codeController.text.trim());
        print(rslt);
        if(rslt == 200) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context)!.codeAdded),
                backgroundColor: CustomColors.success,
              ),
            );

            Navigator.of(context).popAndPushNamed("/");
          });
        } else {
          String message;
          if(rslt == 204){
            message = AppLocalizations.of(context)!.codeClosed;
          } else {
            message = AppLocalizations.of(context)!.codeError;
          }

          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: CustomColors.error,
              ),
            );
          });
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 8,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          AppLocalizations.of(context)!.addCode,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 30, 10, 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextInput(
                  controller: _codeController,
                  icon: Icons.mail_outline,
                  label: AppLocalizations.of(context)!.enterCode,
                  margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
                  padding: EdgeInsets.only(left: 10),
                  hint: AppLocalizations.of(context)!.enterCode,
                  validator: isEmpty,
                ),
                Container(
                    margin: EdgeInsets.all(10),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: CustomColors.textDark,
                    ),
                    child: SaveButton(callback: _submitUser))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
