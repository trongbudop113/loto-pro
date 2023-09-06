import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/models/user_login.dart';
import 'package:loto/page/moon_cake/page/moon_cake_page.dart';
import 'package:loto/page_config.dart';

class MoonCakeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MoonCakeController());
  }
}

class MoonCakeController extends GetxController {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  var cartQuantityItems = 0;

  List<Widget> list = [];

  void listClick(GlobalKey widgetKey) async {
    await runAddToCartAnimation(widgetKey);
    await cartKey.currentState!
        .runCartAnimation((++cartQuantityItems).toString());
  }

  @override
  void onInit() {
    list = List.generate(15, (index) => AppListItem(onClick: listClick, index: index));
    super.onInit();
  }

}