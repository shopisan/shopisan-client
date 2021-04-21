import 'package:shopisan/model/File.dart' as FileModel;
import 'dart:io';

class PostMedia {
  int id;
  String description_fr;
  String description_en;
  double price;
  int post;
  FileModel.File media;
  File uploadFile;

  PostMedia({
      this.id,
      this.description_fr,
      this.description_en,
      this.price,
      this.post,
      this.media});

  getDescriptionLocale(String locale) {
    String description;
    List<String> locales = ['en', 'fr'];
    description = this.toJson()["description_" + locale];

    if ("" == description || description == null) {
      description = this.description_en;
    }

    if ("" == description || description == null) {
      for (locale in locales) {
        if ("" != this.toJson()["description_" + locale] && this.toJson()["description_" + locale] != null) {
          description = this.toJson()["description_" + locale];
          print(description);
          break;
        }
      }
    }

    return description;
  }

  factory PostMedia.fromJson(Map<String, dynamic> json) {
    return PostMedia(
        id: json['id'],
        description_fr: json['description_fr'],
        description_en: json['description_en'],
        price: json['price'],
        post: json['post'],
        media: FileModel.File.fromJson(json['media']));
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "description_fr": description_fr,
      "description_en": description_en,
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
      postMedias: json
          .map<PostMedia>(
              (json) => PostMedia.fromJson(json as Map<String, dynamic>))
          .toList(),
    );
  }
}
