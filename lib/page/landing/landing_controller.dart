import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/landing/provider/banner_provider.dart';
import 'package:loto/page/landing/provider/block_left_provider.dart';
import 'package:loto/page/landing/provider/block_right_provider.dart';
import 'package:loto/page/landing/provider/game_provider.dart';

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
}