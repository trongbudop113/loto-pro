import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/common.dart';
import 'package:loto/common/utils.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product.dart';
import 'package:loto/page_config.dart';

class MoonCakeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MoonCakeController());
  }
}

class MoonCakeController extends GetxController {

  ContainerTransitionType transitionType = ContainerTransitionType.fade;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  var cartQuantityItems = 0;

  void listClick(GlobalKey widgetKey) async {
    await runAddToCartAnimation(widgetKey);
    await cartKey.currentState!
        .runCartAnimation((++cartQuantityItems).toString());
  }

  @override
  void onInit() {
    super.onInit();
  }

  Stream<QuerySnapshot<Object?>> streamGetListProduct() {
    CollectionReference cakeRef = firestore.collection(DataRowName.Cakes.name);
    var products = cakeRef.doc(DataCollection.Products.name).collection(DataCollection.MoonCakes.name).orderBy("sort_order", descending: false);

    return products.snapshots();
  }

  String formatCurrency(int d) {
    return "${FormatUtils.oCcy.format(d)}đ";
  }

  void onClickDetail(CakeProduct moonCakeProduct){
    Get.toNamed(PageConfig.MOON_CAKE_DETAIL, arguments: moonCakeProduct);
  }

  void goToCart(){
    Get.toNamed(PageConfig.CART);
  }

  Color getBackgroundColor(String? color, BuildContext context){
    if(color == null) return Theme.of(context).backgroundColor;
    return Color(int.parse("0xFF$color"));
  }

  CakeProduct? currentProductInCart(CakeProduct product){
    var data = AppCommon.singleton.currentProductInCart.firstWhereOrNull((e) => e.productID == product.productID);
    if(data != null){
      return data;
    }
    return null;
  }
}