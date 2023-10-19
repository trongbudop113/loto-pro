import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/landing/models/block_menu.dart';
import 'package:loto/page/landing/provider/banner_provider.dart';
import 'package:loto/page/landing/provider/block_left_provider.dart';
import 'package:loto/page/landing/provider/block_right_provider.dart';
import 'package:loto/page/landing/provider/game_provider.dart';
import 'package:loto/page/menu/menu_page.dart';
import 'package:loto/page_config.dart';

class LandingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LandingController());
  }
}

class LandingController extends GetxController with BlockLeftProvider, BlockRightProvider, GameMenuProvider, BannerMenuProvider {

  final Color bgColor = Colors.deepPurple[200]!;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    loadMenuData();
    super.onInit();
  }

  Future<void> loadMenuData() async {
    CollectionReference menuRef = firestore.collection(DataRowName.Menus.name);
    var blockLeft = await menuRef.doc("Blocks").collection('BlockLeft').get();
    print(blockLeft);
  }

  void onClickItemBlock(BlockMenu menu, {required String argument}){
    var isLogin = FirebaseAuth.instance.currentUser == null;
    print(isLogin);
    if((menu.isRequireLogin ?? false) && isLogin){
      Get.toNamed(PageConfig.LOGIN);
      return;
    }
    Get.toNamed(menu.page ?? '', arguments: argument);
  }
}