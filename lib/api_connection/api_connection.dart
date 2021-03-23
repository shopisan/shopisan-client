import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/model/api_model.dart';

final _base = "10.0.2.2:8000";
final _tokenEndpoint = "/api/token-auth/";
final _tokenURL = Uri.http(_base, _tokenEndpoint);

Future<Token> getToken(UserLogin userLogin) async {
  print(_tokenURL);
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
    print("login test: " + json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<CategoryCollection> fetchCategories() async {
  final response = await http.get(Uri.http(_base, "/api/stores/categories/"),
      headers: {'Accept': 'application/json'});

  if (response.statusCode == 200) {
    return CategoryCollection.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(
        'Failed to load categories, ca serait bien de faire quelque chose dans ce cas la');
  }
}

Future<List<Store>> fetchStores(
    List<dynamic> categories, String latitude, String longitude) async {
  Map<String, dynamic> params = {};

  if (categories != null) {
    params['categories'] = categories.join(",");
  }

  params['position'] = "$latitude,$longitude";

  print("URL: ${Uri.http(_base, "/api/stores_geo/", params)}");
  final response = await http.get(Uri.http(_base, "/api/stores_geo/", params),
      headers: {'Accept': 'application/json'});

  if (response.statusCode == 200) {
    return StoreCollection.fromJson(json.decode(response.body)).stores;
  } else {
    throw Exception('Failed to load stores');
  }
}
