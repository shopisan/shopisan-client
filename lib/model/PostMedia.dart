import 'package:shopisan/model/File.dart' as FileModel;
import 'dart:io';


class PostMedia {
  int id;
  String description;
  double price;
  int post;
  FileModel.File media;
  File uploadFile;


  PostMedia({this.id, this.description, this.price, this.post, this.media});

  factory PostMedia.fromJson(Map<String, dynamic> json) {
    return PostMedia(
        id: json['id'],
        description: json['description'],
        price: json['price'],
        post: json['post'],
        media: FileModel.File.fromJson(json['media'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "description": description,
      "price": price,
      "media": media.url
    };
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
