import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/common.dart';
import 'package:loto/page_config.dart';

class RecipeMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route)  {
    final bool isAuthenticated = AppCommon.singleton.isLogin;

    if (!isAuthenticated) {
      return RouteSettings(name: PageConfig.LOGIN);
    }
    final currentUser = AppCommon.singleton.userLoginData;

    if (!(currentUser.isAdmin ?? false)) {
      Get.snackbar(
        'Thông báo',
        'Bạn không có quyền truy cập trang này',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return RouteSettings(name: PageConfig.HOME);
    }

    return null;
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    return page;
  }
}