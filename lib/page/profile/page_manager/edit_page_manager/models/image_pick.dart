import 'dart:typed_data';

class ImagePick{
  int? type;
  String? imagePath;
  Uint8List? localPath;

  int selectIndexView = -1;

  String? imageName;

  ImagePick({this.type, this.imagePath, this.localPath, this.imageName});
}