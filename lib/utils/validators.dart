import 'package:flutter_gen/gen_l10n/app_localizations.dart';


String? isEmpty(value, context){
  if (value == null || value.isEmpty) {
    return AppLocalizations.of(context)!.emptyValidation;
  }
  return null;
}

String? isValidEmail(value, context){
  if (value == null || value.isEmpty) {
    return AppLocalizations.of(context)!.emptyValidation;
  }

  if (!RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(value)) {
    return AppLocalizations.of(context)!.emailValidation;
  }

  return null;
}

String? passwordsMatch(value, password, context){
  if (value == null || value.isEmpty) {
    return AppLocalizations.of(context)!.emptyValidation;
  }

  if (value != password) {
    return AppLocalizations.of(context)!.passwordMatchValidation;
  }

  return null;
}

bool oneFilled(List<String?> values){
  bool oneFilled = false;

  for (String? value in values){
    if (value != null && value.isNotEmpty) {
      oneFilled = true;
    }
  }

  return oneFilled;
}