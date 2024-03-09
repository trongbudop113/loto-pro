import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loto/common/common.dart';
import 'package:loto/common/utils.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/models/user_login.dart';
import 'package:loto/page/shopping/cart/models/order_cart.dart';
import 'package:loto/page/shopping/moon_cake/models/order_moon_cake.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController());
  }
}

class CartController extends GetxController {
  final RxDouble finalPrice = 0.0.obs;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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

  void onTapRemoveProductItem(ProductOrder productItem) {
    AppCommon.singleton.currentProductInCart.remove(productItem);
    countTotalPrice();
  }

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

  Future<void> onTapOrder() async {
    DateTime current = DateTime.now();
    var data =  DateFormat("dd/MM/yyyy").format(current);
    // if (currentProductInCart.isEmpty) return;
    // CollectionReference cakeRef = firestore.collection(DataRowName.Cakes.name);
    // DateTime current = DateTime.now();
    //
    // OrderCart orderCart = OrderCart();
    // orderCart.orderTime = current;
    // orderCart.orderID = current.millisecondsSinceEpoch.toString();
    // orderCart.listProductItem = AppCommon.singleton.currentProductInCart;
    // orderCart.totalPrice = finalPrice.value;
    // orderCart.discountCart = 0.0;
    // orderCart.statusOrder = 1;
    // orderCart.cartPrice = finalPrice.value;
    // orderCart.userOrder =
    //     UserLogin(name: "Trong", phoneNumber: "0356882046", uuid: "01");
    //
    // await cakeRef
    //     .doc(DataCollection.Orders.name)
    //     .collection(current.millisecondsSinceEpoch.toString())
    //     .doc(current.millisecondsSinceEpoch.toString())
    //     .set(orderCart.toJson());
    //
    // AppCommon.singleton.currentProductInCart.clear();
    // Get.back();
  }

  void onRemoveAllCart() {
    AppCommon.singleton.currentProductInCart.clear();
    countTotalPrice();
  }
}
