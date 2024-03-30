import 'dart:typed_data';

class ImagePick{
  int? type;
  String? imagePath;
  Uint8List? localPath;

  ImagePick({this.type, this.imagePath, this.localPath});
}