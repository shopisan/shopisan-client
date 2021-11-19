import 'Country.dart';

class City {
  final int? id;
  final String? en;
  final String? fr;
  final List<dynamic>? postalCodes;
  final Country? country;
  final double? latitude;
  final double? longitude;

  City({this.id, this.en, this.fr, this.postalCodes, this.country,
    this.latitude, this.longitude});

  getNameLocale(String locale) {
    String name;
    List<String> locales = ['en', 'fr'];
    name = this.toJson()[locale];

    if ("" == name || name == null) {
      name = this.en!;
    }

    if ("" == name || name == null) {
      for (locale in locales) {
        if ("" != this.toJson()[locale] && this.toJson()[locale] != null) {
          name = this.toJson()[locale];
          break;
        }
      }
    }

    return name;
  }

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
        id: json['id'],
        en: json['en'],
        fr: json['fr'],
        postalCodes: json['postal_codes'],
        country: Country.fromJson(json['country']),
        latitude: json['latitude'],
        longitude: json['longitude']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "en": en,
      "fr": fr,
      "postal_codes": postalCodes,
      "country": country,
      "latitude": latitude,
      "longitude": longitude
    };
  }
}

class CityCollection {
  final List<City>? cities;

  CityCollection({this.cities});

  factory CityCollection.fromJson(json) {
    return CityCollection(
      cities: json.map<City>((json) => City.fromJson(json as Map<String, dynamic>)).toList(),
    );
  }
}
