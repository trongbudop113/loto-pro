import 'package:get/get.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product.dart';

class ProductCommon {
  static final ProductCommon singleton = ProductCommon._internal();

  factory ProductCommon() {
    return singleton;
  }

  ProductCommon._internal();

  final RxList<CakeProduct> currentProductInCart = <CakeProduct>[].obs;

  RxInt get countCart{
    if(currentProductInCart.isEmpty) return 0.obs;
    int i = 0;
    for (var w in currentProductInCart) {
      i = i + w.quantity;
    }

    return i.obs;
  }
}