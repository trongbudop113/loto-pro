import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loto/common/common.dart';
import 'package:loto/common/mesage_util.dart';
import 'package:loto/common/utils.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product.dart';
import 'package:loto/page/shopping/moon_cake/models/order_moon_cake.dart';
import 'package:loto/page/shopping/moon_cake/widgets/select_box_layout.dart';
import 'package:loto/page_config.dart';

class MoonCakeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MoonCakeController());
  }
}

class MoonCakeController extends GetxController {
  ContainerTransitionType transitionType = ContainerTransitionType.fade;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var cartQuantityItems = 0;

  ProductOrder? productOrder;
  final RxList<CakeProduct> listCakeBoxTemp = <CakeProduct>[].obs;
  final RxBool isStatusBuyBox = false.obs;

  void listClick(CakeProduct product) async {
    print(product.toJson());
    if (!isStatusBuyBox.value) {
      if (checkExistedInBox(product) != null) {
        checkExistedInBox(product)!.quantity += product.quantity;
        AppCommon.singleton.currentProductInCart.refresh();
        return;
      }
      productOrder = ProductOrder();
      productOrder?.productMoonCakeList = [];
      productOrder?.boxCake = product;
      productOrder?.quantity.value = 1;
      productOrder?.productType = 2;

      AppCommon.singleton.currentProductInCart.add(productOrder!);
      MessageUtil.show(
        msg: "Thêm vào giỏ hàng thành công",
        duration: 1,
      );
      return;
    }
    if (listCakeBoxTemp.length == productOrder?.boxCake!.productType) {
      MessageUtil.show(msg: "Số lượng bánh đã đủ");
      return;
    }
    listCakeBoxTemp.add(product);
  }

  ProductOrder? checkExistedInBox(CakeProduct product) {
    var data =
        AppCommon.singleton.currentProductInCart.firstWhereOrNull((element) {
      return product.productID == element.boxCake!.productID &&
          product.numberEggs == element.boxCake!.numberEggs &&
          product.productType == element.boxCake!.productType;
    });
    if (data != null) {
      return data!;
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();
  }

  Stream<QuerySnapshot<Object?>> streamGetListProduct() {
    CollectionReference cakeRef = firestore.collection(DataRowName.Cakes.name);
    var products = cakeRef
        .doc(DataCollection.Products.name)
        .collection(DataCollection.MoonCakes.name)
        .orderBy("sort_order", descending: false);

    return products.snapshots();
  }

  Stream<QuerySnapshot<Object?>> streamGetListBox() {
    CollectionReference cakeRef = firestore.collection(DataRowName.Cakes.name);
    var products = cakeRef
        .doc(DataCollection.Products.name)
        .collection(DataCollection.Boxs.name);

    return products.snapshots();
  }

  String formatCurrency(double d) {
    return "${FormatUtils.oCcy.format(d)}đ";
  }

  void onClickDetail(CakeProduct moonCakeProduct) {
    Get.toNamed(PageConfig.MOON_CAKE_DETAIL, arguments: moonCakeProduct);
  }

  void goToCart() {
    Get.toNamed(PageConfig.CART);
  }

  Color getBackgroundColor(String? color, BuildContext context) {
    if (color == null) return Theme.of(context).backgroundColor;
    return Color(int.parse("0xFF$color"));
  }

  ProductOrder? currentProductInCart(ProductOrder product) {
    var data = AppCommon.singleton.currentProductInCart.firstWhereOrNull(
        (e) => e.boxCake?.productID == product.boxCake?.productID);
    if (data != null) {
      return data;
    }
    return null;
  }

  void onShowOrCompleteBuyBox(BuildContext context) {
    if (isStatusBuyBox.value) {
      if (listCakeBoxTemp.length < (productOrder?.boxCake!.productType ?? 0)) {
        MessageUtil.show(
          msg: "Số lượng bánh chưa đủ, hãy chọn thêm",
          duration: 1,
        );
        return;
      }
      productOrder?.productMoonCakeList!.addAll(listCakeBoxTemp);
      AppCommon.singleton.currentProductInCart.add(productOrder!);

      listCakeBoxTemp.clear();
      isStatusBuyBox.value = false;
      MessageUtil.show(
        msg: "Thêm vào giỏ hàng thành công",
        duration: 1,
      );
      return;
    }
    showBoxCakeDialog(context);
  }

  void showBoxCakeDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Select Box",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) {
        return SelectBoxLayout(
          controller: this,
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(
            begin: Offset(-1, 0),
            end: Offset.zero,
          );
        } else {
          tween = Tween(
            begin: Offset(1, 0),
            end: Offset.zero,
          );
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  void onSelectBuyBox(CakeProduct product) {
    productOrder = ProductOrder();
    productOrder?.productMoonCakeList = [];
    productOrder?.boxCake = product;
    productOrder?.quantity.value = 1;
    productOrder?.productType = 1;

    isStatusBuyBox.value = true;

    Get.back();
  }

  void onTapDeleteBuyBox() {
    productOrder = ProductOrder();

    isStatusBuyBox.value = false;
    listCakeBoxTemp.clear();
  }

  void onRemoveItemInBox(int index) {
    listCakeBoxTemp.removeAt(index);
  }
}
