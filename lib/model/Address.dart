class Address {
  int? id;
  String streetAvenue;
  String postalCode;
  String city;
  String country;
  String? latitude;
  String? longitude;
  int? store;

  Address(
      {this.id,
      required this.streetAvenue,
      required this.postalCode,
      required this.city,
      required this.country,
      this.longitude,
      this.latitude,
      this.store});

  factory Address.fromJson(final json) {
    return Address(
        id: json['id'],
        streetAvenue: json['streetAvenue'],
        postalCode: json['postalCode'],
        city: json['city'],
        country: json['country'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        store: json['store']);
  }

  Map<String, dynamic> toJson(){
    return {
    "id": id ?? 0,
    "streetAvenue": streetAvenue,
    "postalCode": postalCode,
    "city": city,
    "country": country
    };
  }
}

class AddressCollection {
  final List<Address>? addresses;

  AddressCollection({this.addresses});

  factory AddressCollection.fromJson(json) {
    return AddressCollection(
      addresses: json
          .map<Address>(
              (json) => Address.fromJson(json as Map<String, dynamic>))
          .toList(),
    );
  }
}
