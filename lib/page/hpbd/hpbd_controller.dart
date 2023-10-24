import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/hpbd/models/hpbd_data.dart';
import 'package:loto/page/landing/models/block_menu.dart';
import 'package:loto/page/landing/provider/banner_provider.dart';
import 'package:loto/page/landing/provider/block_left_provider.dart';
import 'package:loto/page/landing/provider/block_right_provider.dart';
import 'package:loto/page/landing/provider/game_provider.dart';
import 'package:loto/page/menu/menu_page.dart';
import 'package:loto/page_config.dart';

class HPBDBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HPBDController());
  }
}

class HPBDController extends GetxController {

  final Color bgColor = Colors.deepPurple[200]!;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Rx<HPBDData> mainData = HPBDData().obs;

  RxBool isLoading = true.obs;
  Widget imageWaiting = Container();

  final box = GetStorage();
  bool get isSelected => box.read('select_gift') ?? false;
  bool get isBack => box.read('is_back') ?? false;

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  initData() async {
    String documentID = Get.arguments["documentID"];
    String image = Get.arguments["image"];
    imageWaiting = Image.network(image);
    await streamGetListHPBD(documentID);
  }

  Future<void> streamGetListHPBD(String id) async {
    Future.delayed(Duration(seconds: 2), () async {
      CollectionReference bdRef = firestore.collection(DataRowName.Menus.name);
      var data = await bdRef.doc("Blocks").collection('BlockRight').doc(id).collection("2023").get();
      mainData.value = HPBDData.fromJson(data.docs[0].data());
      mainData.refresh();
      isLoading.value = false;
    });
  }

  void onSelectGift(){
    if(isSelected){
      if(isBack){
        return;
      }
      return;
    }
    box.write('select_gift', true);
  }
}