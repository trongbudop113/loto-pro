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

  CakeProduct? moonCakeProduct;
  final RxInt quantity = 1.obs;

  void listClick(GlobalKey widgetKey) async {
    await runAddToCartAnimation(widgetKey);
    await cartKey.currentState!
        .runCartAnimation((++cartQuantityItems).toString());
  }

  void itemClick(GlobalKey widgetKey) async {
    await runAddToCartAnimation(widgetKey);
    await cartKey.currentState!
        .runCartAnimation((++quantity.value).toString());
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

  List<EggData> listEgg = [];

  void onClickDetail(CakeProduct moonCakeProduct){
    this.moonCakeProduct = moonCakeProduct;
    listEgg = EggData.listTwo();
    if(moonCakeProduct.productType == 200){
      listEgg = EggData.listThree();
    }
    listEgg[1].isSelect.value = true;
    quantity.value = 1;
  }

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

  void onClickAddToCart(GlobalKey widgetKey){
    moonCakeProduct!.quantity = quantity.value;
    if(currentProductInCart(moonCakeProduct!) != null){
      currentProductInCart(moonCakeProduct!)!.quantity = moonCakeProduct!.quantity;
      quantity.value = 1;
      itemClick(widgetKey);
      return;
    }
    ProductCommon.singleton.currentProductInCart.add(moonCakeProduct!);
    quantity.value = 1;
    itemClick(widgetKey);
  }

  CakeProduct? currentProductInCart(CakeProduct product){
    var data = ProductCommon.singleton.currentProductInCart.firstWhereOrNull((e) => e.productID == product.productID);
    if(data != null){
      return data;
    }
    return null;
  }
}