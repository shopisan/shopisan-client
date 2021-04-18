import 'dart:io';
import 'country_translations.dart';

// todo faire la fonction pour traduire les iso selon la locale
class IsoCountryTranslation{
  static String defaultLocale = Platform.localeName;

  static String getCountryName(String isoCode){
    final String localeCode = getLocaleCode();
    return countryTranslations[localeCode][isoCode.toLowerCase()];

    // todo selon la locale check dans le bon fichier + return la traduction
  }

  static getLocaleCode(){
    if (defaultLocale.contains("fr")) {
      return "fr";
    }

    return "en";
  }
}