import 'dart:io';

import 'country_translations.dart';

class IsoCountryTranslation {
  static String defaultLocale = Platform.localeName;

  static String getCountryName(String isoCode) {
    final String localeCode = getLocaleCode();
    return countryTranslations[localeCode][isoCode.toLowerCase()] ?? "";
  }

  static getLocaleCode() {
    if (defaultLocale.contains("fr")) {
      return "fr";
    }

    return "en";
  }
}
