import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loto/common/mesage_util.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/landing/models/block_menu.dart';
import 'package:loto/page/profile/model/block_page.dart';
import 'package:loto/page/profile/page_manager/edit_page_manager/models/image_pick.dart';

class EditPageManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditPageManagerController());
  }
}

class EditPageManagerController extends GetxController {

  Rx<BlockMenu> blockPage = BlockMenu().obs;
  String idDocumentChild = "";
  String idCollection = "";
  String idBlock = "";

  final RxBool isModeAddNew = true.obs;
  final RxInt currentIndex = 0.obs;
  final RxInt currentCollectionIndex = 0.obs;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController blockNameController = TextEditingController();
  final TextEditingController blockPageController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  final Rx<ImagePick> imageUserPick = ImagePick().obs;
  final RxList<BlockPage> listBlockPage = <BlockPage>[].obs;
  final Rx<BlockPage> currentBlockPage = BlockPage().obs;

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  Future<void> getAllMenu() async {
    if(!isModeAddNew.value) return;
    try{
      CollectionReference collectionRef = firestore.collection(DataRowName.Menus.name);
      var data = await collectionRef.get();
      listBlockPage.clear();
      for (var e in data.docs) {
        listBlockPage.add(BlockPage.fromJson(e.data() as Map<String, dynamic>));
      }

      currentBlockPage.value = listBlockPage[currentIndex.value];
      idBlock = currentBlockPage.value.idBlock ?? '';
      if((currentBlockPage.value.idCollection ?? []).isNotEmpty){
        idCollection = currentBlockPage.value.idCollection![currentCollectionIndex.value];
      }
    }catch(e){
      e.printError(info: "aaa");
    }
  }

  initData() async {
    var data = Get.arguments;
    bool isAdd = data["isAdd"] as bool;
    isModeAddNew.value = false;
    if(isAdd){
      blockPage.value.isShow = true;
      blockPage.value.isRequireLogin = false;
      isModeAddNew.value = true;
      await getAllMenu();
      return;
    }

    var mapChild = data["snapshotChild"] as QueryDocumentSnapshot<Object?>;
    blockPage.value = BlockMenu.fromJson(mapChild.data() as Map<String, dynamic>);
    blockNameController.text = blockPage.value.blockName ?? '';
    blockPageController.text = blockPage.value.page ?? '';

    imageUserPick.value.type = 1;
    imageUserPick.value.imagePath = blockPage.value.blockIcon ?? '';

    blockPage.value.isRequireLogin ??= false;
    blockPage.value.isShow ??= true;

    idDocumentChild = mapChild.id;
    idCollection = data["idCollection"];
    idBlock = data["idBlock"];
  }

  Future<void> onChangRequireLogin(bool value) async {
    blockPage.value.isRequireLogin = value;
    blockPage.refresh();
  }

  Future<void> onChangShowHideBlock(bool value) async {
    blockPage.value.isShow = value;
    blockPage.refresh();
  }

  Future<void> onCreateOrUpdateBlockPage() async {

    if(blockPageController.text == "" || blockNameController.text == ''){
      MessageUtil.show(
        msg: "Điền đầy đủ thông tin",
        duration: 1,
      );
      return;
    }

    if(isModeAddNew.value){
      await uploadFile(imageUserPick.value.localPath!);
    }else{
      if(imageUserPick.value.type != 1 && imageUserPick.value.imagePath != blockPage.value.blockIcon){
        await uploadFile(imageUserPick.value.localPath!);
      }
    }
    print("isUpdateImageSuccess $isUpdateImageSuccess");
    if(!isUpdateImageSuccess){
      return;
    }

    if(blockPageController.text != (blockPage.value.page ?? '')){
      blockPage.value.page = "/${blockPageController.text}";
    }

    if(blockNameController.text != (blockPage.value.blockName ?? '')){
      blockPage.value.blockName = blockNameController.text;
    }

    if(isModeAddNew.value){
      blockPage.value.createDate = DateTime.now();
      blockPage.value.blockID = blockPage.value.blockName;
      idDocumentChild = blockPage.value.createDate!.millisecondsSinceEpoch.toString();
    }
    print(idBlock + "     " + idCollection+ "      "+ idDocumentChild);
    blockPage.value.updateDate = DateTime.now();

    if(isModeAddNew.value){
      CollectionReference collectionRef = firestore.collection(DataRowName.Menus.name);
      await collectionRef.doc(idBlock).collection(idCollection)
          .doc(idDocumentChild).set(blockPage.value.toJson());
    }else{
      CollectionReference collectionRef = firestore.collection(DataRowName.Menus.name);
      await collectionRef.doc(idBlock).collection(idCollection)
          .doc(idDocumentChild).update(blockPage.value.toJson());
    }

    MessageUtil.show(
      msg: "Cập nhật thành công",
      duration: 1,
    );

    Get.back();
  }

  Future<void> onChangeBlockIcon() async {
    XFile? imagePick = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
      maxHeight: 300,
      imageQuality: 100,
    );

    imageUserPick.value.localPath = await imagePick?.readAsBytes();
    imageUserPick.value.type = 2;
    imageUserPick.refresh();
  }

  bool isUpdateImageSuccess = false;

  Future<void> uploadFile(Uint8List uint8list) async {
    print("uploadFile");
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child("blocks/$fileName");
    UploadTask uploadTask = reference.putData(uint8list, SettableMetadata(
      contentType: "image/jpeg",
    ));
    TaskSnapshot storageTaskSnapshot = uploadTask.snapshot;

    await uploadTask.then((event) async {
      print("${event.state}");
      if(event.state == TaskState.success){
        print("uploadFile success");
        await storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl){
          print("uploadFile $downloadUrl");
          if(downloadUrl.isNotEmpty){
            blockPage.value.blockIcon = downloadUrl;
            isUpdateImageSuccess = true;
          }
        }, onError : (e){
          isUpdateImageSuccess = false;
          MessageUtil.show(
            msg: "Upload hình lỗi",
            duration: 1,
          );
        });

      }
    });
  }

  void onSelectBlockName(int i) {
    if (currentIndex.value == i) return;
    currentIndex.value = i;
    idBlock = listBlockPage[i].idBlock ?? '';
    currentBlockPage.value = listBlockPage[i];
    currentCollectionIndex.value = 0;
    idCollection =
    (currentBlockPage.value.idCollection ?? [])[0];
    listBlockPage.refresh();
  }

  void onSelectCollectionID(int i) {
    if(currentCollectionIndex.value == i) return;
    currentCollectionIndex.value = i;
    idCollection = (currentBlockPage.value.idCollection ?? [])[i];
    currentBlockPage.refresh();
  }

  Future<void> deleteDocument() async {
    if(isModeAddNew.value) return;
    CollectionReference collectionRef = firestore.collection(DataRowName.Menus.name);
    await collectionRef.doc(idBlock).collection(idCollection)
        .doc(idDocumentChild).delete();
    MessageUtil.show(
      msg: "Xóa thành công",
      duration: 1,
    );
    Get.back();
  }
}