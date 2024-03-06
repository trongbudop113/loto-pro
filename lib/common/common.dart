import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:loto/models/user_login.dart';
import 'package:loto/page/shopping/moon_cake/models/order_moon_cake.dart';

class AppCommon {
  static final AppCommon singleton = AppCommon._internal();

  factory AppCommon() {
    return singleton;
  }

  AppCommon._internal();

  final RxList<ProductOrder> currentProductInCart = <ProductOrder>[].obs;

  RxInt get countCart {
    if (currentProductInCart.isEmpty) return 0.obs;
    return currentProductInCart.length.obs;
  }

  RxInt get countTotalCart {
    if (currentProductInCart.isEmpty) return 0.obs;
    int i = 0;
    for (var w in currentProductInCart) {
      i = i + w.quantity.value;
    }

    return i.obs;
  }

  User? get currentUser => FirebaseAuth.instance.currentUser;

  UserLogin userLogin(Object? data){
    return UserLogin.fromJson(data as Map<String, dynamic>);
  }

  bool get isLogin =>
      currentUser != null && (currentUser?.uid ?? '').isNotEmpty;
}
