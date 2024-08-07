import 'dart:ui';

import 'package:get/get.dart';
import 'package:loto/common/utils.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product.dart';
import 'package:loto/page/shopping/moon_cake/models/egg_data.dart';
import 'package:loto/page_config.dart';
import 'package:loto/src/color_resource.dart';

class CakeProductModel{
  final CakeProduct cakeProduct;
  List<EggData> listEgg = [];
  final RxDouble productPrice = 0.0.obs;

  CakeProductModel(this.cakeProduct){
    initListEgg();
  }

  void initListEgg() {
    listEgg = EggData.listTwo();
    if (cakeProduct.productType != null && cakeProduct.productType == 200) {
      listEgg = EggData.listThree();
    }
    listEgg[1].isSelect.value = true;
    productPrice.value = (cakeProduct.productPrice ?? 0).toDouble() +
        (listEgg[1].defaultPrice ?? 0).toDouble();
    cakeProduct.numberEggs = listEgg[1].value ?? 1;
  }

  void selectEgg(EggData data) {
    for (var e in listEgg) {
      e.isSelect.value = false;
      if (e.value == data.value) {
        e.isSelect.value = true;
        data.isSelect.value = true;
        print(e.toJson());
        productPrice.value = (cakeProduct.productPrice ?? 0).toDouble() +
            (e.defaultPrice ?? 0).toDouble();
        cakeProduct.numberEggs = e.value ?? 1;
      }
    }
  }

  Color get getBackgroundColor {
    var color = cakeProduct.productColor;
    if (color == null) return ColorResource.color_background_light;
    return Color(int.parse("0xFF$color"));
  }

  RxString get formatCurrency {
    return "${FormatUtils.oCcy.format(productPrice.value)}đ".obs;
  }

  void onClickDetail(CakeProduct moonCakeProduct) {
    Get.toNamed(PageConfig.MOON_CAKE_DETAIL, arguments: moonCakeProduct);
  }

  String get productName => cakeProduct.productName ?? '';
}