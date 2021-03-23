import 'package:shopisan/model/File.dart';

class PostMedia {
  final int id;
  final String description;
  final double price;
  final int post;
  final File media;

  PostMedia({this.id, this.description, this.price, this.post, this.media});

  factory PostMedia.fromJson(Map<String, dynamic> json) {
    return PostMedia(
        id: json['id'],
        description: json['description'],
        price: json['price'],
        post: json['post'],
        media: File.fromJson(json['media'])
    );
  }
}

class PostMediaCollection {
  final List<PostMedia> postMedias;

  PostMediaCollection({this.postMedias});

  factory PostMediaCollection.fromJson(json) {
    return PostMediaCollection(
      postMedias: json.map<PostMedia>((json) => PostMedia.fromJson(json as Map<String, dynamic>)).toList(),
    );
  }
}
