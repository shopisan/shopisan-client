import 'package:shopisan/model/Address.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/OpeningTime.dart';

class Store {
  final int id;
  final String name;
  final String url;
  final String website;
  final List<OpeningTime> openingTimes;
  final String profilePicture;
  final List<Category> categories;
  final List<Address> addresses;

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
    // this.evaluation
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
      categories: categoriesList,
      addresses: addressesList,
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
