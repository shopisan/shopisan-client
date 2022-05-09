part of '../api_connection.dart';

Future<Token> getToken(UserLogin userLogin) async {
  final http.Response response = await client.post(
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
  final http.Response response =
      await client.get(Uri.https(_base, "/api/get_user/"));

  if (response.statusCode == 200) {
    return UserProfile.fromJson(json.decode(response.body));
  } else {
    // @todo faire une fonction pour reset le user token (reco auto)
    throw Exception(json.decode(response.body));
  }
}

Future<bool> registrationUserProfile(Map<String, String> data) async {
  final http.Response response = await client.post(
      Uri.https(_base, "/api/register/"),
      body: jsonEncode(data));

  if (response.statusCode == 201) {
    return true;
  } else {
    throw Exception(response.body);
  }
}

Future<bool> forgotPasswordSubmit(Map<String, String> data) async {
  final http.Response response = await client.post(
      Uri.https(_base, "/api/forgot-password/"),
      body: jsonEncode(data));

  if (response.statusCode == 200) {
    Map<String, dynamic> rslt = jsonDecode(response.body);
    if (rslt['success']) {
      return true;
    }

    return false;
  } else {
    throw Exception(response.body);
  }
}

Future<bool> resetPasswordSubmit(Map<String, String> data) async {
  final http.Response response = await client.post(
      Uri.https(_base, "/api/reset-password/"),
      body: jsonEncode(data));

  if (response.statusCode == 200) {
    Map<String, dynamic> rslt = jsonDecode(response.body);
    if (rslt['success']) {
      return true;
    }

    return false;
  } else {
    throw Exception(response.body);
  }
}

Future<bool> editUserProfile(UserProfile user) async {
  final http.Response response = await client.put(
      Uri.https(_base, "/api/users/users/${user.id}/"),
      body: jsonEncode(user.toJson()));

  if (response.statusCode == 200) {
    return true;
    // return UserProfile.fromJson(json.decode(response.body));
  } else {
    throw Exception(json.decode(response.body));
  }
}

Future<UserProfile> editUserProfilePicture(UserProfile user) async {
  final http.Response response = await client.put(
      Uri.https(_base, "/api/users/users/${user.id}/"),
      body: jsonEncode(user.toJson()));

  if (response.statusCode == 200) {
    return UserProfile.fromJson(json.decode(response.body));
  } else {
    throw Exception(json.decode(response.body));
  }
}
