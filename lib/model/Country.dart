class Country {
  final int id;
  final String iso;

  Country({this.id, this.iso});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
        id: json['id'], iso: json['iso']);
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "iso": iso,
    };
  }
}

class CountryCollection {
  final List<Country> countries;

  CountryCollection({this.countries});

  factory CountryCollection.fromJson(json) {
    return CountryCollection(
      countries: json.map<Country>((json) => Country.fromJson(json as Map<String, dynamic>)).toList(),
    );
  }
}
