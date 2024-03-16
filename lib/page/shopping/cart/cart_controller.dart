import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loto/common/common.dart';
import 'package:loto/common/mesage_util.dart';
import 'package:loto/common/utils.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/models/user_login.dart';
import 'package:loto/page/shopping/cart/models/order_cart.dart';
import 'package:loto/page/shopping/moon_cake/models/order_moon_cake.dart';
import 'package:loto/page_config.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController());
  }
}

class CartController extends GetxController {
  final RxDouble finalPrice = 0.0.obs;

  //final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference cakeRef = FirebaseFirestore.instance.collection(DataRowName.Cakes.name);
  TextEditingController textNoteController = TextEditingController();

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
    if (!AppCommon.singleton.isLogin) {
      Get.toNamed(PageConfig.LOGIN);
      return;
    }
    if (currentProductInCart.isEmpty) return;

    DateTime current = DateTime.now();
    String month =
        current.month < 10 ? "0${current.month}" : "${current.month}";
    String day = current.day < 10 ? "0${current.day}" : "${current.day}";
    String orderOfDay = "${current.year}$month$day";
    String orderOfDayTitle = "$day-$month-${current.year}";

    OrderCart orderCart = OrderCart();
    orderCart.orderTime = current;
    orderCart.orderID = current.millisecondsSinceEpoch.toString();
    orderCart.listProductItem = AppCommon.singleton.currentProductInCart;
    orderCart.totalPrice = finalPrice.value;
    orderCart.discountCart = 0.0;
    orderCart.statusOrder = 1;
    orderCart.cartPrice = finalPrice.value;

    UserLogin currentUserLogin =
        await AppCommon.singleton.getCurrentUserLogin();
    orderCart.userOrder = currentUserLogin;
    orderCart.note = textNoteController.text.trim();

    await handleSaveOrderDate(orderOfDay : orderOfDay, orderOfDayTitle: orderOfDayTitle,);

    await cakeRef
        .doc(DataCollection.Orders.name)
        .collection(orderOfDay)
        .doc(current.millisecondsSinceEpoch.toString())
        .set(orderCart.toJson());

    AppCommon.singleton.currentProductInCart.clear();
    MessageUtil.show(
      msg: "Mua hàng thành công",
      duration: 1,
    );
    Get.back();
  }

  void onRemoveAllCart() {
    AppCommon.singleton.currentProductInCart.clear();
    countTotalPrice();
  }

  Future<void> handleSaveOrderDate({required String orderOfDay, required String orderOfDayTitle}) async {

    DocumentSnapshot<Object?> data = await cakeRef.doc(DataCollection.Orders.name).get();
    LsOrderTime lsOrderTime = LsOrderTime.fromJson(data.data() as Map<String, dynamic>);

    var filterData = lsOrderTime.lsOrderTime.firstWhereOrNull((e) => e.orderDateID == orderOfDay);
    if(filterData != null){
      return;
    }

    lsOrderTime.lsOrderTime.add(OrderTime(
      orderDateID: orderOfDay,
      orderDateTitle: orderOfDayTitle,
    ));
    await cakeRef.doc(DataCollection.Orders.name).set(lsOrderTime.toJson());
  }
}
