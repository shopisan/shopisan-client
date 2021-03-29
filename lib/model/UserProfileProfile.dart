import 'package:shopisan/model/File.dart';

class UserProfileProfile {
  int id;
  String name;
  String surname;
  File picture;
  String dob;
  List favouriteStores;

  UserProfileProfile(
      {this.id,
      this.name,
      this.surname,
      this.picture,
      this.dob,
      this.favouriteStores});

  factory UserProfileProfile.fromJson(Map<String, dynamic> data) =>
      UserProfileProfile(
          id: data['id'],
          name: data['name'],
          surname: data['surname'],
          dob: data['date_of_birth'],
          favouriteStores: data['favourite_stores'],
          picture: File.fromJson(data['picture']));

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "name": this.name,
        "surname": this.surname,
        "picture": this.picture.url,
        "date_of_birth": this.dob,
        "favourite_stores": this.favouriteStores,
      };
}
