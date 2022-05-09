import 'dart:io';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class FileHandler{
  final double maxSize = 3 * (1024 * 1024);

  Future<File> compressUploadedFile(File file) async {
    double maxSize = 3 * (1024 * 1024);

    String initialPath = file.path;
    int indexOfExt = initialPath.lastIndexOf('.');
    String pathName = initialPath.substring(0, indexOfExt);
    String extension = initialPath.substring(indexOfExt);

    String targetPath = pathName + "compressed" + extension;

    while(file.lengthSync() > maxSize){
      file = await compressAndGetFile(initialPath, targetPath);
    }

    return file;
  }

  Future<File> compressAndGetFile(String path, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      path,
      targetPath,
      quality: 98,
      rotate: 0,
    );

    return result!;
  }

  Future<File> handleFile(PickedFile pickedFile) async {
    File rotatedImage =
        await FlutterExifRotation.rotateImage(path: pickedFile.path);

    File finalFile = await compressUploadedFile(rotatedImage);

    return finalFile;
  }
}