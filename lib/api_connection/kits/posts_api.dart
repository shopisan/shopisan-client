part of '../api_connection.dart';

Future<int> createPost(Post post) async {
  Map<String, String> headers = await getHeaders();

  List<Map<String, dynamic>> jsonMedias = [];
  for (PostMedia postMedia in post.postMedia) {
    jsonMedias.add(postMedia.toJson());
  }

  http.Response response;

  print(post.store);

  if (post.id == null) {
    response = await http.post(Uri.https(_base, "/api/posts/posts/"),
        body: jsonEncode({
          "store": post.store,
          "post_media": jsonMedias,
        }),
        headers: headers);
  } else {
    response = await http.put(Uri.https(_base, "/api/posts/posts/${post.id}/"),
        body: jsonEncode({
          "store": post.store,
          "post_media": jsonMedias,
        }),
        headers: headers);
  }

  if (response.statusCode >= 200 && response.statusCode < 300) {
    return json.decode(response.body)['id'];
  } else {
    throw Exception('Failed to load stores');
  }
}

Future<List<Post>> getPosts() async {
  Map<String, String> headers = await getHeaders();

  try {
    final response =
    await http.get(Uri.https(_base, "/api/posts/posts/"), headers: headers);

    if (response.statusCode == 200) {
      return PostCollection.fromJson(jsonDecode(response.body)).posts;
    }
  } catch (Exception) {
    print("Oops: $Exception");
  }
  return null;
}

Future<Post> loadPost(int postId) async {
  Map<String, String> headers = await getHeaders();

  final response = await http.get(Uri.https(_base, "/api/posts/posts/$postId/"),
      headers: headers);

  if (response.statusCode == 200) {
    return Post.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

Future<List<Post>> fetchPostsByStore(int storeId) async {
  Map<String, dynamic> headers = await getHeaders();
  final response = await http.get(
      Uri.https(_base, "/api/posts/by_store/${storeId.toString()}/"),
      headers: headers);

  if (response.statusCode == 200) {
    return PostCollection.fromJson(jsonDecode(response.body)).posts;
  } else {
    throw Exception('Failed to load stores');
  }
}

Future<List<Post>> fetchPostsByOwnedStores() async {
  Map<String, dynamic> headers = await getHeaders();

  try{
    final response = await http.get(
        Uri.https(_base, "/api/posts_by_owned_stores/"),
        headers: headers);

    if (response.statusCode == 200) {
      return PostCollection.fromJson(jsonDecode(response.body)).posts;
    }
  } catch (exception){
    throw Exception('Failed to load posts');
  }
  return null;
}

Future<bool> deletePost(int postId) async {
  Map<String, String> headers = await getHeaders();

  final response = await http
      .delete(Uri.https(_base, "/api/posts/posts/$postId/"), headers: headers);

  if (response.statusCode >= 200 && response.statusCode < 300) {
    return true;
  } else {
    throw Exception('Failed to load post');
  }
}
