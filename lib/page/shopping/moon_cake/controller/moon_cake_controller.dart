import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/common.dart';
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

  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  var cartQuantityItems = 0;

  ProductOrder? productOrder;
  final RxList<CakeProduct> listCakeBoxTemp = <CakeProduct>[].obs;
  final RxBool isStatusBuyBox = false.obs;

  void listClick() async {
    // await runAddToCartAnimation(widgetKey);
    // await cartKey.currentState!
    //     .runCartAnimation((++cartQuantityItems).toString());
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

  String formatCurrency(int d) {
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
    var data = AppCommon.singleton.currentProductInCart
        .firstWhereOrNull((e) => e.productOrderID == product.productOrderID);
    if (data != null) {
      return data;
    }
    return null;
  }

  Future<void> showBoxCakeDialog(BuildContext context) async {
    await showGeneralDialog(
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
    productOrder?.quantity = 1;

    isStatusBuyBox.value = true;

    Get.back();
    //AppCommon.singleton.currentProductInCart.add(productOrder);
  }
}
