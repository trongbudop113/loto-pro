import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/common.dart';
import 'package:loto/common/mesage_util.dart';
import 'package:loto/common/utils.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/models/user_login.dart';
import 'package:loto/page/shopping/cart/layout/pick_user_layout.dart';
import 'package:loto/page/shopping/cart/models/order_cart.dart';
import 'package:loto/page/shopping/home_main/home_main_controller.dart';
import 'package:loto/page/shopping/moon_cake/models/order_moon_cake.dart';
import 'package:loto/page_config.dart';
import 'package:loto/src/color_resource.dart';
import 'package:loto/widget/loading/loading_overlay.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController());
  }
}

class CartController extends GetxController {
  final RxDouble finalPrice = 0.0.obs;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference cakeRef = FirebaseFirestore.instance.collection(DataRowName.Cakes.name);
  final TextEditingController textNoteController = TextEditingController();

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

  Future<void> onTapRemoveProductItem(ProductOrder productItem) async {
    AppCommon.singleton.currentProductInCart.remove(productItem);
    await AppCommon.singleton.onUpdateCartToServer();
    countTotalPrice();
  }

  Future<void> onTapSubtract(ProductOrder productItem) async {
    if (productItem.quantity.value == 1) return;
    productItem.quantity.value--;
    await 0.5.delay();
    await AppCommon.singleton.onUpdateCartToServer();
    countTotalPrice();
  }

  Future<void> onTapPlus(ProductOrder productItem) async {
    productItem.quantity.value++;
    await 0.5.delay();
    await AppCommon.singleton.onUpdateCartToServer();
    countTotalPrice();
  }

  Future<UserLogin?> showDialogPickUser() async {
    var user = await Get.dialog(Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: PickUserLayout(controller: this),
    ));

    return user;
  }

  Color getBackgroundColor(String? color, BuildContext context) {
    if (color == null) return ColorResource.color_background_light;
    return Color(int.parse("0xFF$color"));
  }

  Future<void> onTapOrder(BuildContext context) async {
    if (!AppCommon.singleton.isLogin) {
      Get.toNamed(PageConfig.LOGIN);
      return;
    }
    if (currentProductInCart.isEmpty) return;

    UserLogin currentUserLogin;

    if(AppCommon.singleton.userLoginData.isAdmin ?? false){
      var result = await showDialogPickUser();
      if(result == null){
        return;
      }
      currentUserLogin = result;
    }else{
      currentUserLogin = await AppCommon.singleton.getCurrentUserLogin();
    }

    LoadingOverlay.instance().show(context: context);
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
    LoadingOverlay.instance().hide();
    Get.find<HomeMainController>().onBackPage(context);
  }

  Future<void> onRemoveAllCart() async {
    AppCommon.singleton.currentProductInCart.clear();
    await AppCommon.singleton.onUpdateCartToServer();
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

  Stream<QuerySnapshot<Object?>> getListUser() {
    CollectionReference userRef = firestore.collection(DataRowName.Users.name);


    return userRef.snapshots();
  }

  void onPickUser(UserLogin user) {
    Get.back(result: user);
  }
}
