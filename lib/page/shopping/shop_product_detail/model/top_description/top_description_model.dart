import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/base/base_model.dart';
import 'package:loto/common/common.dart';
import 'package:loto/common/mesage_util.dart';
import 'package:loto/common/utils.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product.dart';
import 'package:loto/page/shopping/moon_cake/models/egg_data.dart';
import 'package:loto/page/shopping/moon_cake/models/order_moon_cake.dart';

import '../../../../../src/color_resource.dart';
import '../../../cart/cart_controller.dart';

class TopDescriptionModel extends BaseModel{

  TopDescriptionModel({required CakeProduct data}){
    moonCakeProduct.value = data;
    initData();
  }

  final RxBool isLoadingPage = true.obs;
  final Rx<CakeProduct> moonCakeProduct = CakeProduct().obs;
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
    if(quantity.value >= (moonCakeProduct.value.limitCart ?? 0)){
      return;
    }
    quantity.value++;
  }

  void selectEgg(EggData data) {
    for (var e in listEgg) {
      e.isSelect.value = false;
      if (e.value == data.value) {
        e.isSelect.value = true;
        data.isSelect.value = true;
        productPrice.value = (moonCakeProduct.value.productPrice ?? 0).toDouble() + (e.defaultPrice ?? 0).toDouble();
      }
    }
  }

  @override
  void onFinish() {
    // TODO: implement onFinish
  }

  @override
  void onStart() {
    initData();
  }

  Future<void> onClickAddToCart() async {
    await AppCommon.singleton.onAddCartToServer(onHandleNext: (){
      moonCakeProduct.value.quantity = quantity.value;
      if (currentProductInCart(moonCakeProduct.value) != null) {
        currentProductInCart(moonCakeProduct.value)!.quantity +=
            moonCakeProduct.value.quantity;
        quantity.value = 1;
        return;
      }
      moonCakeProduct.value.numberEggs = listEgg.firstWhereOrNull((e) => e.isSelect.value)?.value ?? 1;
      moonCakeProduct.value.productPrice = productPrice.value;
      ProductOrder productOrder = ProductOrder();
      productOrder.productMoonCakeList = [];
      productOrder.boxCake = moonCakeProduct.value;
      productOrder.quantity.value = 1;
      productOrder.productType = 2;
      AppCommon.singleton.currentProductInCart.add(productOrder);
      quantity.value = 1;
      Get.find<CartController>().countTotalPrice();
    });
    MessageUtil.show(
      msg: "Thêm vào giỏ hàng thành công",
      duration: 1,
    );
  }

  ProductOrder? currentProductInCart(CakeProduct product) {
    var data = AppCommon.singleton.currentProductInCart.firstWhereOrNull((e){
      return e.boxCake?.productID == product.productID;
    });
    if (data != null) {
      return data;
    }
    return null;
  }

  String formatCurrency(double d) {
    return "${FormatUtils.oCcy.format(d)}đ";
  }

  Future<void> initData() async {
    currentImage.value = moonCakeProduct.value.productImageMain;
    if(moonCakeProduct.value.productCategory == 4){
      listEgg = EggData.listTwo();
      if (moonCakeProduct.value.productType == 200) {
        listEgg = EggData.listThree();
      }
      listEgg[1].isSelect.value = true;
      productPrice.value = (moonCakeProduct.value.productPrice ?? 0).toDouble() + (listEgg[1].defaultPrice ?? 0).toDouble();
    }else{
      productPrice.value = (moonCakeProduct.value.productPrice ?? 0).toDouble();
    }
    isLoadingPage.value = false;
  }

  void onTapViewImage(String image) {
    currentImage.value = image;
  }

}