part of '../api_connection.dart';

Future<Token> getToken(UserLogin userLogin) async {
  final http.Response response = await http.post(
    _tokenURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toDatabaseJson()),
  );

  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else {
    throw Exception(json.decode(response.body));
  }
}

Future<UserProfile> getUserProfile() async {
  Map<String, dynamic> headers = await getHeaders();

  final http.Response response =
      await http.get(Uri.http(_base, "/api/get_user"), headers: headers);

  if (response.statusCode == 200) {
    return UserProfile.fromJson(json.decode(response.body));
  } else {
    throw Exception(json.decode(response.body));
  }
}

Future<bool> registrationUserProfile(Map<String, String> data) async {
  Map<String, dynamic> headers = await getHeaders();

  final http.Response response = await http.post(
      Uri.http(_base, "/api/register"),
      body: data,
      headers: headers);

  if (response.statusCode == 201) {
    return true;
  } else {
    throw Exception(json.decode(response.body));
  }
}

Future<bool> editUserProfile(UserProfile user) async {
  Map<String, dynamic> headers = await getHeaders();

  final http.Response response = await http.put(
      Uri.http(_base, "/api/users/users/${user.id}/"),
      body: jsonEncode(user.toJson()),
      headers: headers);

  if (response.statusCode == 200) {
    return true;
    // return UserProfile.fromJson(json.decode(response.body));
  } else {
    throw Exception(json.decode(response.body));
  }
}

Future<UserProfile> editUserProfilePicture(UserProfile user) async {
  Map<String, dynamic> headers = await getHeaders();

  final http.Response response = await http.put(
      Uri.http(_base, "/api/users/users/${user.id}/"),
      body: jsonEncode(user.toJson()),
      headers: headers);

  if (response.statusCode == 200) {
    return UserProfile.fromJson(json.decode(response.body));
  } else {
    throw Exception(json.decode(response.body));
  }
}
