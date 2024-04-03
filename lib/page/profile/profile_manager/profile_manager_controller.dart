import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loto/common/mesage_util.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/models/user_login.dart';
import 'package:loto/page/profile/page_manager/edit_page_manager/models/image_pick.dart';

class ProfileManagerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileManagerController());
  }
}

class ProfileManagerController extends GetxController {


  final ImagePicker _picker = ImagePicker();
  final Rx<ImagePick> imageUserPick = ImagePick().obs;
  final Rx<UserLogin> currentUserLogin = UserLogin().obs;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController blockNameController = TextEditingController();
  final TextEditingController blockAddressController = TextEditingController();
  final TextEditingController blockPhoneController = TextEditingController();

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  void initData(){
    var data = Get.arguments as UserLogin;
    currentUserLogin.value = data;

    blockNameController.text = data.name ?? '';
    blockAddressController.text = data.address ?? '';
    blockPhoneController.text = data.phoneNumber ?? '';

    imageUserPick.value.type = 1;
    imageUserPick.value.imagePath = data.avatar ?? '';

  }

  Future<void> onChangeAvatar() async {
    XFile? imagePick = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
      maxHeight: 300,
      imageQuality: 100,
    );

    if(imagePick == null) return;

    imageUserPick.value.localPath = await imagePick.readAsBytes();
    imageUserPick.value.type = 2;
    imageUserPick.refresh();
  }

  bool isUpdateImageSuccess = false;

  Future<void> uploadFile(Uint8List uint8list) async {
    print("uploadFile");
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child("users/$fileName");
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
            currentUserLogin.value.avatar = downloadUrl;
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


  Future<void> onUpdateUserInfo() async {
    if(imageUserPick.value.type != 1 && imageUserPick.value.imagePath != currentUserLogin.value.avatar){
      await uploadFile(imageUserPick.value.localPath!);
    }
    print("isUpdateImageSuccess $isUpdateImageSuccess");
    if(!isUpdateImageSuccess){
      return;
    }

    if(blockAddressController.text != (currentUserLogin.value.address ?? '')){
      currentUserLogin.value.address = blockAddressController.text;
    }

    if(blockNameController.text != (currentUserLogin.value.name ?? '')){
      currentUserLogin.value.name = blockNameController.text;
    }

    if(blockPhoneController.text != (currentUserLogin.value.phoneNumber ?? '')){
      currentUserLogin.value.phoneNumber = blockPhoneController.text;
    }

    CollectionReference collectionRef = firestore.collection(DataRowName.Users.name);
    await collectionRef.doc(currentUserLogin.value.uuid).update(currentUserLogin.value.toJson());

    MessageUtil.show(
      msg: "Cập nhật thành công",
      duration: 1,
    );

    Get.back();
  }

}