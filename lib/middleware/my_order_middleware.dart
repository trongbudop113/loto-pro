import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/common.dart';
import 'package:loto/page/shopping/cart/cart_controller.dart';
import 'package:loto/page_config.dart';

class MyOrderMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final bool isAuthenticated = AppCommon.singleton.isLogin;

    if (!isAuthenticated) {
      return RouteSettings(name: PageConfig.LOGIN);
    }
    final currentUser = AppCommon.singleton.userLoginData;

    syncCart();
    if((route ?? '').contains("profile")){
      return RouteSettings(name: PageConfig.ADMIN);

    }
    return RouteSettings(name: route);
  }

  Future<void> syncCart() async {
    await AppCommon.singleton.syncProductCart();
    Get.find<CartController>().countTotalPrice();
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    return page;
  }
}