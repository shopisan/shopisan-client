import 'package:shopisan/model/Address.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/OpeningTime.dart';
import 'package:shopisan/model/File.dart';

class Store {
  int id;
  String name;
  String url;
  String website;
  List<OpeningTime> openingTimes;
  File profilePicture;
  List<Category> categories;
  List<Address> addresses;
  String description;
  bool appointmentOnly;
  double evaluation;
  // final String evaluation;

  Store({
    this.id,
    this.name,
    this.url,
    this.website,
    this.openingTimes,
    this.profilePicture,
    this.categories,
    this.addresses,
    this.description,
    this.appointmentOnly,
    this.evaluation
  });

  factory Store.fromJson(final json) {
    List<Address> addressesList =
        AddressCollection.fromJson(json['addresses']).addresses;

    List<Category> categoriesList =
        CategoryCollection.fromJson(json["categories"]).categories;

    return Store(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      website: json['website'],
      // openingTimes: [],
      profilePicture: json['profilePicture'],
      description: json['description'],
      appointmentOnly: json['appointmentOnly'],
      categories: categoriesList,
      addresses: addressesList,
      evaluation: json['average_score']['score__avg'],
    );
  }
}

class StoreCollection {
  final List<Store> stores;

  StoreCollection({this.stores});

  factory StoreCollection.fromJson(json) {
    return StoreCollection(
      stores: json
          .map<Store>((json) => Store.fromJson(json as Map<String, dynamic>))
          .toList(),
    );
  }
}
