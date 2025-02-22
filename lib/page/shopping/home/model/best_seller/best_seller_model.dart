import 'package:get/get.dart';
import 'package:loto/base/base_model.dart';
import 'package:loto/base/destination.dart';
import 'package:loto/common/common.dart';
import 'package:loto/common/mesage_util.dart';
import 'package:loto/page/shopping/cart/cart_controller.dart';
import 'package:loto/page/shopping/home_main/home_main_controller.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product_model.dart';
import 'package:loto/page/shopping/moon_cake/models/order_moon_cake.dart';
import 'package:loto/page/shopping/shop_product/shop_product_controller.dart';

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
    Get.find<ShopProductController>().searchArticleModel.onSelectCategory(0);
    Get.find<HomeMainController>().onChangeTap(2);
    Get.nestedKey(1)?.currentState?.pushNamed(
      Destination.shop_product_detail.route,
      arguments: cakeProduct,
    );
  }

  void listClick(CakeProduct product) async {
    await AppCommon.singleton.onAddCartToServer(onHandleNext: (){
      if (checkExistedInBox(product) != null) {
        checkExistedInBox(product)!.quantity += product.quantity;
        AppCommon.singleton.currentProductInCart.refresh();
        Get.find<CartController>().countTotalPrice();
        return;
      }
      var productOrder = ProductOrder();
      productOrder.productMoonCakeList = [];
      productOrder.boxCake = product;
      productOrder.quantity.value = 1;
      productOrder.productType = 2;

      AppCommon.singleton.currentProductInCart.add(productOrder);
      Get.find<CartController>().countTotalPrice();
      MessageUtil.show(
        msg: "Thêm vào giỏ hàng thành công",
        duration: 1,
      );
    });
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