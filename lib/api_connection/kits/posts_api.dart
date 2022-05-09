part of '../api_connection.dart';

Future<int> createPost(Post post) async {

  List<Map<String, dynamic>> jsonMedias = [];
  for (PostMedia postMedia in post.postMedia) {
    jsonMedias.add(postMedia.toJson());
  }

  http.Response response;

  if (post.id == null) {
    response = await client.post(Uri.https(_base, "/api/posts/posts/"),
        body: jsonEncode({
          "store": post.store,
          "post_media": jsonMedias,
        }));
  } else {
    response = await client.put(Uri.https(_base, "/api/posts/posts/${post.id}/"),
        body: jsonEncode({
          "store": post.store,
          "post_media": jsonMedias,
        }));
  }

  if (response.statusCode >= 200 && response.statusCode < 300) {
    return json.decode(response.body)['id'];
  } else {
    throw Exception('Failed to load stores');
  }
}

Future<List<Post>?> getPosts() async {
  try {
    final response =
    await client.get(Uri.https(_base, "/api/posts/posts/"));

    if (response.statusCode == 200) {
      return PostCollection.fromJson(jsonDecode(response.body)).posts;
    }
  } catch (exception) {
    print("Oops: $exception");
  }
}

Future<Post> loadPost(int postId) async {

  final response = await client.get(Uri.https(_base, "/api/posts/posts/$postId/"));

  if (response.statusCode == 200) {
    return Post.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

Future<List<Post>> fetchPostsByStore(int storeId) async {
  final response = await client.get(
      Uri.https(_base, "/api/posts/by_store/${storeId.toString()}/"));

  if (response.statusCode == 200) {
    return PostCollection.fromJson(jsonDecode(response.body)).posts;
  } else {
    throw Exception('Failed to load stores');
  }
}

Future<List<Post>?> fetchPostsByOwnedStores() async {
  try{
    final response = await client.get(
        Uri.https(_base, "/api/posts_by_owned_stores/"));

    if (response.statusCode == 200) {
      return PostCollection.fromJson(jsonDecode(response.body)).posts;
    }
  } catch (exception){
    throw Exception('Failed to load posts');
  }
  return null;
}

Future<bool> deletePost(int postId) async {
  final response = await client
      .delete(Uri.https(_base, "/api/posts/posts/$postId/"));

  if (response.statusCode >= 200 && response.statusCode < 300) {
    return true;
  } else {
    throw Exception('Failed to load post');
  }
}
