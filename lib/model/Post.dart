import 'package:shopisan/model/PostMedia.dart';

class Post {
  int? id;
  String? url;
  String? created;
  String? store;
  List<PostMedia> postMedia;

  Post({this.id, this.url, this.created, this.store, required this.postMedia});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        url: json['url'],
        created: json['created'],
        store: json['store'],
        postMedia: PostMediaCollection.fromJson(json['post_media']).postMedias);
  }
}

class PostCollection {
  final List<Post> posts;

  PostCollection({required this.posts});

  factory PostCollection.fromJson(json) {
    return PostCollection(
      posts: json
          .map<Post>((json) => Post.fromJson(json as Map<String, dynamic>))
          .toList(),
    );
  }
}
