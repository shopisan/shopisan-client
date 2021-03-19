class Store {
  final int id;
  final int name;
  final int url;
  final int website;
  final int openingTimes;
  final int profilePicture;
  final int categories;
  final int addresses;

  // final int evaluation;

  Store(
      {this.id,
      this.name,
      this.url,
      this.website,
      this.openingTimes,
      this.profilePicture,
      this.categories,
      this.addresses});

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
        id: json['id'],
        name: json['name'],
        url: json['url'],
        website: json['website'],
        openingTimes: json['openingTimes'],
        profilePicture: json['profilePicture'],
        categories: json['categories'],
        addresses: json['addresses']);
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
