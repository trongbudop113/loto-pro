import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/common.dart';
import 'package:loto/common/utils.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product.dart';
import 'package:loto/page/shopping/moon_cake/models/egg_data.dart';
import 'package:loto/page/shopping/moon_cake/models/order_moon_cake.dart';

class MoonCakeDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MoonCakeDetailController());
  }
}

class MoonCakeDetailController extends GetxController {

  CakeProduct? moonCakeProduct;
  final RxInt quantity = 1.obs;

  List<EggData> listEgg = [];

  Color getBackgroundColor(String? color, BuildContext context){
    if(color == null) return Theme.of(context).backgroundColor;
    return Color(int.parse("0xFF$color"));
  }

  void onDecreaseQuantity() {
    if(quantity.value <= 1) return;
    quantity.value--;
  }

  void onIncreaseQuantity() {
    quantity.value++;
  }

  void selectEgg(EggData data){
    for (var e in listEgg) {
      e.isSelect.value = false;
      if(e.value == data.value){
        e.isSelect.value = true;
      }
    }
  }

  void onClickAddToCart(){
    moonCakeProduct!.quantity = quantity.value;
    if(currentProductInCart(moonCakeProduct!) != null){
      currentProductInCart(moonCakeProduct!)!.quantity = moonCakeProduct!.quantity;
      quantity.value = 1;
      return;
    }
    ProductOrder productOrder = ProductOrder();
    productOrder.productMoonCakeList.add(moonCakeProduct!);
    AppCommon.singleton.currentProductInCart.add(productOrder);
    quantity.value = 1;
    print("Thêm thành công");
  }

  ProductOrder? currentProductInCart(CakeProduct product){
    var data = AppCommon.singleton.currentProductInCart.firstWhereOrNull((e) => e.productID == product.productID);
    if(data != null){
      return data;
    }
    return null;
  }

  String formatCurrency(int d) {
    return "${FormatUtils.oCcy.format(d)}đ";
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  void initData(){
    moonCakeProduct = Get.arguments as CakeProduct;
    listEgg = EggData.listTwo();
    if(moonCakeProduct?.productType == 200){
      listEgg = EggData.listThree();
    }
    listEgg[1].isSelect.value = true;
  }
}