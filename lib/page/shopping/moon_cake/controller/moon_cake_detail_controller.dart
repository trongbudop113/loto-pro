import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/common.dart';
import 'package:loto/common/mesage_util.dart';
import 'package:loto/common/utils.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product.dart';
import 'package:loto/page/shopping/moon_cake/models/egg_data.dart';
import 'package:loto/page/shopping/moon_cake/models/order_moon_cake.dart';
import 'package:loto/src/color_resource.dart';

class MoonCakeDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MoonCakeDetailController());
  }
}

class MoonCakeDetailController extends GetxController {
  CakeProduct? moonCakeProduct;
  final RxInt quantity = 1.obs;
  final RxDouble productPrice = 0.0.obs;

  List<EggData> listEgg = [];

  final RxString currentImage = "".obs;

  Color getBackgroundColor(String? color, BuildContext context) {
    if (color == null) return ColorResource.color_background_light;
    return Color(int.parse("0xFF$color"));
  }

  void onDecreaseQuantity() {
    if (quantity.value <= 1) return;
    quantity.value--;
  }

  void onIncreaseQuantity() {
    quantity.value++;
  }

  void selectEgg(EggData data) {
    for (var e in listEgg) {
      e.isSelect.value = false;
      if (e.value == data.value) {
        e.isSelect.value = true;
        data.isSelect.value = true;
        productPrice.value = (moonCakeProduct!.productPrice ?? 0).toDouble() + (e.defaultPrice ?? 0).toDouble();
      }
    }
  }

  void onClickAddToCart() {
    moonCakeProduct!.quantity = quantity.value;
    if (currentProductInCart(moonCakeProduct!) != null) {
      currentProductInCart(moonCakeProduct!)!.quantity +=
          moonCakeProduct!.quantity;
      quantity.value = 1;
      return;
    }
    moonCakeProduct!.numberEggs = listEgg.firstWhereOrNull((e) => e.isSelect.value)!.value ?? 1;
    moonCakeProduct!.productPrice = productPrice.value;
    ProductOrder productOrder = ProductOrder();
    productOrder.productMoonCakeList = [];
    productOrder.boxCake = moonCakeProduct;
    productOrder.quantity.value = 1;
    productOrder.productType = 1;
    AppCommon.singleton.currentProductInCart.add(productOrder);
    quantity.value = 1;
    print("Thêm thành công");
    MessageUtil.show(
      msg: "Thêm vào giỏ hàng thành công",
      duration: 1,
    );
  }

  ProductOrder? currentProductInCart(CakeProduct product) {
    var data = AppCommon.singleton.currentProductInCart.firstWhereOrNull(
        (e) => e.productMoonCakeList![0].productID == product.productID);
    if (data != null) {
      return data;
    }
    return null;
  }

  String formatCurrency(double d) {
    return "${FormatUtils.oCcy.format(d)}đ";
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  void initData() {
    moonCakeProduct = Get.arguments as CakeProduct;
    currentImage.value = moonCakeProduct?.productImageMain ?? '';
    listEgg = EggData.listTwo();
    if (moonCakeProduct?.productType == 200) {
      listEgg = EggData.listThree();
    }
    listEgg[1].isSelect.value = true;
    productPrice.value = (moonCakeProduct!.productPrice ?? 0).toDouble() + (listEgg[1].defaultPrice ?? 0).toDouble();
  }

  void onTapViewImage(String image) {
    currentImage.value = image;
  }
}
