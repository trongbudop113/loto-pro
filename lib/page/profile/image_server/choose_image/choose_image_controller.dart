import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class ChooseImageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ChooseImageController());
  }
}

class ChooseImageController extends GetxController {
  PickType pickType = PickType.single;
  final RxList<ImageServer> listImageServer = <ImageServer>[].obs;

  final RxList<ImageServer> listChooseTemp = <ImageServer>[].obs;

  @override
  void onInit() {
    initData();
  }

  Future<void> initData() async {
    var arguments = Get.arguments;
    String folderPath = arguments['path'];
    pickType = arguments['type'] == 1 ? PickType.single : PickType.multiple;

    var data = await FirebaseStorage.instance.ref().storage.ref().child(folderPath).list();
    if(data.items.isNotEmpty){
      listImageServer.value = data.items.map<ImageServer>((e){
        return ImageServer(
          imageName: e.name,
          imageFullPath: e.getDownloadURL()
        );
      }).toList();
    }
  }

  void handleRemoveImage(ImageServer listImageServer) {
    listChooseTemp.removeWhere((e) => e.imageName == listImageServer.imageName);
  }

  void onAddImageToList(String value, ImageServer listImageServer) {
    if(pickType == PickType.single && listChooseTemp.length == 1){
      return;
    }
    listChooseTemp.add(ImageServer(
      imageName: listImageServer.imageName,
      imagePathAfterParse: value,
    ));
  }

  void selectDone() {
    var encodeData = jsonEncode(toImageJson());
    Get.back(result: encodeData);
  }

  Map<String, dynamic> toImageJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['images'] = listChooseTemp.map((v) => v.toJson()).toList();
    return data;
  }
}

class ImageServer{
  String? imageName;
  Future<String>? imageFullPath;

  String? imagePathAfterParse;

  final RxBool isSelected = false.obs;
  ImageServer({this.imageFullPath, this.imageName, this.imagePathAfterParse});

  ImageServer.fromJson(Map<String, dynamic> json) {
    imageName = json['image_name'];
    imagePathAfterParse = json['full_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_name'] = imageName;
    data['full_path'] = imagePathAfterParse;
    return data;
  }
}

enum PickType{
  single,
  multiple
}