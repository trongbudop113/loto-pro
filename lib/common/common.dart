import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product.dart';

class AppCommon {
  static final AppCommon singleton = AppCommon._internal();

  factory AppCommon() {
    return singleton;
  }

  AppCommon._internal();

  final RxList<ProductOrder> currentProductInCart = <ProductOrder>[].obs;

  RxInt get countCart{
    if(currentProductInCart.isEmpty) return 0.obs;
    int i = 0;
    for (var w in currentProductInCart) {
      i = i + w.quantity;
    }

    return i.obs;
  }

  User? get currentUser => FirebaseAuth.instance.currentUser;

  bool get isLogin => currentUser != null && (currentUser?.email ?? '').isNotEmpty;
}