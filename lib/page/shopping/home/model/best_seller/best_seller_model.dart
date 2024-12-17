import 'package:get/get.dart';
import 'package:loto/base/base_model.dart';
import 'package:loto/base/destination.dart';
import 'package:loto/common/common.dart';
import 'package:loto/common/mesage_util.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product_model.dart';
import 'package:loto/page/shopping/moon_cake/models/order_moon_cake.dart';

class TastyRecipeModel extends BaseModel{
  TastyRecipeModel();

  final RxList<CakeProductModel> listCakeFeature = <CakeProductModel>[].obs;

  void setListCateFeature(List<CakeProductModel> list){
    listCakeFeature.clear();
    if(list.length > 4){
      listCakeFeature.addAll(list.getRange(0, 4).toList());
    }else{
      listCakeFeature.addAll(list);
    }
  }

  @override
  void onFinish() {
    // TODO: implement onFinish
  }

  @override
  void onStart() {
    // TODO: implement onStart
  }

  void onTapDetail(CakeProduct cakeProduct) {
    Get.nestedKey(1)?.currentState?.pushNamed(
      Destination.shop_product_detail.route,
      arguments: cakeProduct,
    );
  }

  void listClick(CakeProduct product) async {
    if (checkExistedInBox(product) != null) {
      checkExistedInBox(product)!.quantity += product.quantity;
      AppCommon.singleton.currentProductInCart.refresh();
      return;
    }
    var productOrder = ProductOrder();
    productOrder.productMoonCakeList = [];
    productOrder.boxCake = product;
    productOrder.quantity.value = 1;
    productOrder.productType = 2;

    AppCommon.singleton.currentProductInCart.add(productOrder!);
    MessageUtil.show(
      msg: "Thêm vào giỏ hàng thành công",
      duration: 1,
    );
  }

  ProductOrder? checkExistedInBox(CakeProduct product) {
    var data =
    AppCommon.singleton.currentProductInCart.firstWhereOrNull((element) {
      return product.productID == element.boxCake!.productID &&
          product.numberEggs == element.boxCake!.numberEggs &&
          product.productType == element.boxCake!.productType;
    });
    if (data != null) {
      return data;
    }
    return null;
  }
}