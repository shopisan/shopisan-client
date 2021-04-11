import 'package:shopisan/model/File.dart';
import 'package:shopisan/model/Store.dart';

class UserProfileProfile {
  int id;
  String name;
  String surname;
  File picture;
  String dob;
  List favouriteStores;
  List ownedStores;

  UserProfileProfile({
    this.id,
    this.name,
    this.surname,
    this.picture,
    this.dob,
    this.favouriteStores,
    this.ownedStores
  });

  factory UserProfileProfile.fromJson(Map<String, dynamic> data) => UserProfileProfile(
    id: data['id'],
    name: data['name'],
    surname: data['surname'],
    dob: data['date_of_birth'],
    favouriteStores: data['favourite_stores'],
    picture: File.fromJson(data['picture']),
    ownedStores: StoreCollection.fromJson(data['owned_stores']).stores
  );

  Map<String, dynamic> toJson() => {
    "id": this.id,
    "name": this.name,
    "surname": this.surname,
    "picture": this.picture?.url,
    "date_of_birth": this.dob == "" ? null : this.dob,
    "favourite_stores": this.favouriteStores,
  };
}
