import 'package:shopisan/model/PostMedia.dart';

class Post {
  final int id;
  final String url;
  final String created;
  final String store;
  final List postMedia;

  Post({this.id, this.url, this.created, this.store, this.postMedia});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        url: json['url'],
        created: json['en'],
        store: json['fr'],
        postMedia: PostMediaCollection.fromJson(json['post_media']).postMedias
    );
  }
}

class PostCollection {
  final List<Post> posts;

  PostCollection({this.posts});

  factory PostCollection.fromJson(json) {
    return PostCollection(
      posts: json.map<Post>((json) => Post.fromJson(json as Map<String, dynamic>)).toList(),
    );
  }
}
