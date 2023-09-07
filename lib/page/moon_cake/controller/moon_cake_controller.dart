import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loto/page/moon_cake/controller/moon_cake_detail_controller.dart';
import 'package:loto/page/moon_cake/page/moon_cake_page.dart';

class MoonCakeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MoonCakeController());
    Get.lazyPut(() => MoonCakeDetailController());
  }
}

class MoonCakeController extends GetxController {

  ContainerTransitionType transitionType = ContainerTransitionType.fade;
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
    list = List.generate(15, (index) => AppListItem(onClick: listClick, index: index, controller: this));
    super.onInit();
  }

}