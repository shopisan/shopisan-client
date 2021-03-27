import 'package:shopisan/model/UserProfileProfile.dart';

class UserProfile{
  int id;
  String username;
  String email;
  bool isActive;
  bool isOwner;
  String url;
  UserProfileProfile profile;


  UserProfile({
    this.id,
    this.username,
    this.email,
    this.isActive,
    this.isOwner,
    this.url,
    this.profile
  });

  factory UserProfile.fromJson(Map<String, dynamic> data) => UserProfile(
    id: data['id'],
    username: data['username'],
    email: data['email'],
    isActive: data['is_active'],
    isOwner: data['is_owner'],
    url: data['url'],
    profile: UserProfileProfile.fromJson(data['profile'])
  );

  Map<String, dynamic> toJson() => {
    "id": this.id,
    "username": this.username,
    "email": email,
    "is_active": isActive,
    "is_owner": isOwner,
    "url": url,
    "profile": profile.toJson()
  };
}