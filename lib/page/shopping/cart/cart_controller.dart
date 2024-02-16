import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/common.dart';
import 'package:loto/common/utils.dart';
import 'package:loto/page/shopping/moon_cake/models/order_moon_cake.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController());
  }
}

class CartController extends GetxController {
  final RxDouble finalPrice = 0.0.obs;

  @override
  void onInit() {
    countTotalPrice();
    super.onInit();
  }

  double countTotalPrice() {
    double price = 0.0;
    for (ProductOrder element in currentProductInCart) {
      price = price + (element.productPrice * element.quantity.value);
    }
    finalPrice.value = price;
    return price;
  }

  String formatCurrency(double d) {
    return "${FormatUtils.oCcy.format(d)}đ";
  }

  List<ProductOrder> get currentProductInCart =>
      AppCommon.singleton.currentProductInCart;

  void onTapSubtract(ProductOrder productItem) {
    if (productItem.quantity.value == 1) return;
    productItem.quantity.value--;
    countTotalPrice();
  }

  void onTapPlus(ProductOrder productItem) {
    productItem.quantity.value++;
    countTotalPrice();
  }

  Color getBackgroundColor(String? color, BuildContext context) {
    if (color == null) return Theme.of(context).backgroundColor;
    return Color(int.parse("0xFF$color"));
  }
}
