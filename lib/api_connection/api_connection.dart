import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shopisan/api_connection/interceptors/common_request_interceptor.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/City.dart';
import 'package:shopisan/model/Country.dart';
import 'package:shopisan/model/File.dart' as FileModel;
import 'package:shopisan/model/Post.dart';
import 'package:shopisan/model/PostMedia.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/model/UserProfile.dart';
import 'package:shopisan/model/api_model.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:shopisan/repository/user_repository.dart';

part 'kits/posts_api.dart';

part 'kits/user_api.dart';

// final _base = "10.0.2.2:8000";
// final _base = "shopisan.herokuapp.com";
final _base = "shopisan.com";
final _tokenEndpoint = "/api/token-auth/";
final _tokenURL = Uri.https(_base, _tokenEndpoint);
final client = InterceptedClient.build(interceptors: [
  CommonRequestInterceptor(),
]);

Future<List<Category>> fetchCategories() async {
  final response = await client.get(Uri.https(_base, "/api/stores/categories/"),
      headers: {'Accept': 'application/json'});

  if (response.statusCode == 200) {
    return CategoryCollection.fromJson(jsonDecode(response.body)).categories!;
  } else {
    throw Exception(
        'Failed to load categories, ca serait bien de faire quelque chose dans ce cas la');
  }
}

Future<List<Country>> fetchCountries() async {
  final response = await client.get(Uri.https(_base, "/api/countries/"),
      headers: {'Accept': 'application/json'});

  if (response.statusCode == 200) {
    return CountryCollection.fromJson(jsonDecode(response.body)).countries!;
  } else {
    throw Exception(
        'Failed to load countries, ca serait bien de faire quelque chose dans ce cas la');
  }
}

Future<List<City>> fetchCities(String country) async {
  final response = await client.get(
      Uri.https(_base, "/api/cities/", {"country": country}),
      headers: {'Accept': 'application/json'});

  if (response.statusCode == 200) {
    return CityCollection.fromJson(jsonDecode(response.body)).cities!;
  } else {
    throw Exception(
        'Failed to load countries, ca serait bien de faire quelque chose dans ce cas la');
  }
}

Future<List<Store>> fetchStores(List<dynamic> categories, double latitude,
    double longitude, String country) async {
  Map<String, String> params = {};

  if (categories.length > 0) {
    categories.remove('all');
    params['categories'] = categories.join(",");
  }

  params['countries'] = country;

  params['position'] = "$latitude,$longitude";

  final response = await client.get(
      Uri.https(_base, "/api/stores_geo/", params)
  );

  if (response.statusCode == 200) {
    return StoreCollection.fromJson(json.decode(response.body)).stores!;
  } else {
    throw Exception('Failed to load stores');
  }
}

Future<Store> fetchStore(int storeId) async {
  final response = await client.get(
      Uri.https(_base, "/api/stores/stores/${storeId.toString()}/"));

  if (response.statusCode == 200) {
    return Store.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load stores');
  }
}

Future<int> editStore(Store store) async {
  http.Response response;

  if (store.id == null) {
    response = await client.post(Uri.https(_base, "/api/stores/stores/"),
        body: jsonEncode(store.toJson()));
  } else {
    response = await client.put(
        Uri.https(_base, "/api/stores/stores/${store.id.toString()}/"),
        body: jsonEncode(store.toJson()));
  }

  if (response.statusCode >= 200 && response.statusCode < 300) {
    return json.decode(response.body)['id'];
  } else {
    throw Exception(response.body);
  }
}

Future<UserProfile> manageFavouriteStore(int storeId) async {
  final http.Response response = await client.post(
      Uri.https(_base, "/api/manage_favourite_store/"),
      body: jsonEncode({"favourite_store": storeId}));

  if (response.statusCode == 200) {
    // return true;
    return UserProfile.fromJson(json.decode(response.body));
  } else {
    throw Exception(json.decode(response.body));
  }
}

Future<bool> postEvaluation(int storeId, double score) async {

  final http.Response response = await client.post(
      Uri.https(_base, "/api/stores/evals/"),
      body: jsonEncode({"store": storeId, "score": score}));

  if (response.statusCode >= 200 && response.statusCode < 300) {
    return true;
  } else {
    throw Exception(json.decode(response.body));
  }
}

Future<FileModel.File?> uploadFile(File file, String type) async {
  print(file.lengthSync());
  print(type);

  try {
    var request = http.MultipartRequest('POST', Uri.https(_base, "/api/files/"));

    final UserRepository userRepo = UserRepository();
    bool hasUser = await userRepo.hasToken();

    if (hasUser) {
      String token = await userRepo.getAuthToken();
      var headers = {"Authorization": "Token $token"};
      request.headers.addAll(headers);
    }

    request.files.add(http.MultipartFile.fromBytes('file', file.readAsBytesSync(),
        filename: file.toString()));
    request.fields['file_type'] = type;

    http.Response response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 201) {
      return FileModel.File.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to upload file');
    }
  } catch (exception){
    if (exception is SocketException){
      print(exception.message);
    }
    print(exception);
  }

  return null;
}

Future<Map<String, dynamic>> sendStoreRegistration(
    Map<String, dynamic> body) async {

  final http.Response response = await client.post(
      Uri.https(_base, "/api/store_contact/"),
      body: jsonEncode(body));

  if (response.statusCode == 201) {
    return {'success': true};
  } else {
    return json.decode(response.body);
  }
}

Future<Map<String, dynamic>> searchLocation(String locationName) async {
  // Map<String, dynamic> headers = await getHeaders();
  Map<String, dynamic> params = {
    "address": locationName,
    "key": "AIzaSyCegSUW6N1wYgRONnn_4kOZXUzFu7w2Drs"
  };

  final http.Response response = await client
      .get(Uri.https("maps.googleapis.com", "/maps/api/geocode/json", params));

  return json.decode(response.body);
}

// Future<Map<String, String>> getHeaders() async {
//   Map<String, String> headers = {
//     'Accept': 'application/json',
//     'Content-type': 'application/json'
//   };
//
//   final UserRepository userRepo = UserRepository();
//   bool hasUser = await userRepo.hasToken();
//
//   if (hasUser) {
//     String token = await userRepo.getAuthToken();
//     headers['Authorization'] = "Token $token";
//   }
//
//   return headers;
// }

// bool _shouldRetryOnHttpException(DioError err) {
//   return err.type == DioErrorType.other &&
//       ((err.error is HttpException && err.message.contains('Connection closed before full header was received')));
// }
