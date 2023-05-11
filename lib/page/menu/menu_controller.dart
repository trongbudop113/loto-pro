import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/models/user_login.dart';
import 'package:loto/page/menu/model/menu.dart';
import 'package:loto/page_config.dart';

class MenuBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MenuController());
  }
}

class MenuController extends GetxController with WidgetsBindingObserver {

  List<MenuCategory> listMenu = MenuCategory.listEx();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserLogin? userLogin;

  @override
  void onInit() {
    getDataUser();
    super.onInit();
  }

  Future<void> getDataUser() async {
    CollectionReference usersReference = firestore.collection(DataRowName.Users.name);
    final getUSer = await usersReference.doc(FirebaseAuth.instance.currentUser?.email ?? '').get();
    userLogin = UserLogin.fromJson(getUSer.data() as Map<String, dynamic>);
  }

  void goToRoomPage(MenuCategory menu){
    if(userLogin?.isAdmin ?? false){

    }else{
      if(menu.id == '1'){
        Get.toNamed(PageConfig.ROOM);
      }else if(menu.id == "2"){
        generateRandomNumbers();
      }else{

      }
    }
  }

  List<int> listNumber = [];

  generateRandomNumbers() {
    final secure = Random.secure();
    int randomNumber = secure.nextInt(100);
    if(randomNumber == 0 || listNumber.contains(randomNumber)){
      randomNumber = secure.nextInt(90);
    }
    listNumber.add(randomNumber);
    print(randomNumber);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

}

