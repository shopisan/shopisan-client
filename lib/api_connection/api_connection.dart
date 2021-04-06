import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/File.dart' as FileModel;
import 'package:shopisan/model/Post.dart';
import 'package:shopisan/model/PostMedia.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/model/UserProfile.dart';
import 'package:shopisan/model/api_model.dart';
import 'package:shopisan/repository/user_repository.dart';

part 'kits/posts_api.dart';
part 'kits/user_api.dart';

final _base = "10.0.2.2:8000";
final _tokenEndpoint = "/api/token-auth/";
final _tokenURL = Uri.http(_base, _tokenEndpoint);

Future<List<Category>> fetchCategories() async {
  final response = await http.get(Uri.http(_base, "/api/stores/categories/"),
      headers: {'Accept': 'application/json'});

  if (response.statusCode == 200) {
    return CategoryCollection.fromJson(jsonDecode(response.body)).categories;
  } else {
    throw Exception(
        'Failed to load categories, ca serait bien de faire quelque chose dans ce cas la');
  }
}

Future<List<Store>> fetchStores(
    List<dynamic> categories, String latitude, String longitude) async {
  Map<String, String> params = {};

  if (categories != null) {
    params['categories'] = categories.join(",");
  }

  if (latitude != null && longitude != null) {
    params['position'] = "$latitude,$longitude";
  }

  Map<String, dynamic> headers = await getHeaders();
  final response = await http.get(Uri.http(_base, "/api/stores_geo/", params),
      headers: headers);

  if (response.statusCode == 200) {
    return StoreCollection.fromJson(json.decode(response.body)).stores;
  } else {
    throw Exception('Failed to load stores');
  }
}

Future<Store> fetchStore(int storeId) async {
  Map<String, dynamic> headers = await getHeaders();
  final response = await http.get(
      Uri.http(_base, "/api/stores/stores/${storeId.toString()}/"),
      headers: headers);

  if (response.statusCode == 200) {
    return Store.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load stores');
  }
}

Future<int> editStore(Store store) async {
  Map<String, dynamic> headers = await getHeaders();
  http.Response response;

  if (store.id == null) {
    response = await http.post(
        Uri.http(_base, "/api/stores/stores/"),
        body: jsonEncode(store.toJson()),
        headers: headers
    );
  } else {
    response = await http.put(
        Uri.http(_base, "/api/stores/stores/${store.id.toString()}/"),
        body: jsonEncode(store.toJson()),
        headers: headers
    );
  }

  if (response.statusCode >= 200 && response.statusCode < 300) {
    return json.decode(response.body)['id'];
  } else {
    throw Exception(response.body);
  }
}

Future<UserProfile> manageFavouriteStore(int storeId) async {
  Map<String, dynamic> headers = await getHeaders();

  final http.Response response = await http.post(
      Uri.http(_base, "/api/manage_favourite_store/"),
      body: jsonEncode({"favourite_store": storeId}),
      headers: headers);

  if (response.statusCode == 200) {
    // return true;
    return UserProfile.fromJson(json.decode(response.body));
  } else {
    throw Exception(json.decode(response.body));
  }
}

Future<bool> postEvaluation(int storeId, double score) async {
  Map<String, dynamic> headers = await getHeaders();

  final http.Response response = await http.post(
      Uri.http(_base, "/api/stores/evals/"),
      body: jsonEncode({
        "store": storeId,
        "score": score
      }),
      headers: headers
  );

  if (response.statusCode >= 200 && response.statusCode < 300) {
    return true;
  } else {
    throw Exception(json.decode(response.body));
  }
}

Future<FileModel.File> uploadFile(File file, String type) async {
  Map<String, String> headers = await getHeaders();

  var request = http.MultipartRequest('POST', Uri.http(_base, "/api/files/"));
  request.files.add(http.MultipartFile.fromBytes('file', file.readAsBytesSync(),
      filename: file.toString()));
  request.fields['file_type'] = type;
  request.headers.addAll(headers);

  http.Response response = await http.Response.fromStream(await request.send());

  if (response.statusCode == 201) {
    return FileModel.File.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to upload file');
  }
}

Future<Map<String, String>> getHeaders() async {
  Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-type': 'application/json'
  };

  final UserRepository userRepo = UserRepository();
  bool hasUser = await userRepo.hasToken();

  if (hasUser) {
    String token = await userRepo.getAuthToken();
    headers['Authorization'] = "Token $token";
  }

  return headers;
}

// @todo faire la requete delete pour les posts media
// @todo transformer ce fichier en barrel export
