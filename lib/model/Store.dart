import 'package:shopisan/model/Address.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/File.dart';

class Store {
  int id;
  String name;
  String url;
  String website;
  Map<String, dynamic> openingTimes;
  File profilePicture;
  List<Category> categories;
  List<Address> addresses;
  String description;
  bool appointmentOnly;
  double evaluation;

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
    this.appointmentOnly = false,
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
      openingTimes: json['openingTimes'],
      profilePicture: File.fromJson(json['profilePicture']),
      description: json['description'],
      appointmentOnly: json['appointmentOnly'],
      categories: categoriesList,
      addresses: addressesList,
      evaluation: json['average_score']['score__avg'],
    );
  }

  Map<String, dynamic> toJson(){
    List<String> categoryList = [];
    if (null != categories) {
      for (Category category in this.categories) {
        categoryList.add(category.url);
      }
    }

    List<Map<String, dynamic>> addressList = [];
    if (null != addresses) {
      for (Address address in addresses) {
        addressList.add(address.toJson());
      }
    }

    return {
      "id": id,
      "name": name,
      "url": url,
      "website": website,
      "openingTimes": openingTimes,
      "profilePicture": profilePicture.url,
      "description": description,
      "appointmentOnly": appointmentOnly,
      "categories": categoryList,
      "addresses": addressList,
    };
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
