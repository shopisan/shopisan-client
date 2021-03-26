class File {
  final int id;
  final String url;
  final String contentType;
  final String fileType;
  final String file;

  File({this.id, this.url, this.contentType, this.fileType, this.file});

  factory File.fromJson(Map<String, dynamic> json) {
    return File(
        id: json['id'],
        url: json['url'],
        contentType: json['content_type'],
        fileType: json['file_type'],
        file: json['file']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "fileType": fileType,
      "file": url,
      "id": id
    };
  }
}

class FileCollection {
  final List<File> files;

  FileCollection({this.files});

  factory FileCollection.fromJson(json) {
    return FileCollection(
      files: json.map<File>((json) => File.fromJson(json as Map<String, dynamic>)).toList(),
    );
  }
}
