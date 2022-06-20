part of '../api_connection.dart';

Future<int> addCode(String code) async {
  http.Response response;

  response = await client.post(Uri.https(_base, "/featured/add_contest_code/"),
      body: jsonEncode({
        "code": code,
      }));

  print(response.statusCode);

  return response.statusCode;
}