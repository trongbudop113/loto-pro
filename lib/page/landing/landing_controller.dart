import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/common.dart';
import 'package:loto/core/custom_get_controller.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/models/user_login.dart';
import 'package:loto/page/admin/dashboard/dashboard_page.dart';
import 'package:loto/page/landing/models/block_menu.dart';
import 'package:loto/page/landing/provider/banner_provider.dart';
import 'package:loto/page/landing/provider/block_body_provider.dart';
import 'package:loto/page/landing/provider/block_left_provider.dart';
import 'package:loto/page/landing/provider/block_right_provider.dart';
import 'package:loto/page/landing/provider/game_provider.dart';
import 'package:loto/page_config.dart';

class LandingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LandingController());
  }
}

class LandingController extends CustomGetController with BlockLeftProvider, BlockRightProvider, GameMenuProvider, BannerMenuProvider, BlockBodyProvider {

  final Color bgColor = Colors.deepPurple[200]!;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  String get textAppbar => "H O M E";

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

  Future<void> onClickItemBlock(BlockMenu menu, {required String argument, String? image}) async {
    var isLogin = FirebaseAuth.instance.currentUser == null;
    print(isLogin);
    if((menu.isRequireLogin ?? false) && isLogin){
      Get.toNamed(PageConfig.LOGIN);
      return;
    }
    User? user = AppCommon.singleton.currentUser;
    // if(user != null){
    //   CollectionReference usersReference = firestore.collection(DataRowName.Users.name);
    //   final getUSer = await usersReference.doc(user.uid ?? '').get();
    //   UserLogin userLogin = AppCommon.singleton.userLogin(getUSer.data());
    //   if((userLogin.isAdmin ?? false) && (menu.page ?? '') == PageConfig.PROFILE){
    //     Get.to(() => DashBoard());
    //     return;
    //   }
    // }
    Get.toNamed(menu.page ?? '', arguments: {
      "blockID" : argument,
      "documentID" : menu.documentID,
      "image" :  image
    });
  }
}