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
    
    // Đồng bộ cart một cách an toàn
    _syncCartSafely();
    
    if ((route ?? '').contains("profile")) {
      return RouteSettings(name: PageConfig.ADMIN);
    }
    
    return RouteSettings(name: PageConfig.VIEW_ORDER);
  }

  Future<void> syncCart() async {
    await AppCommon.singleton.syncProductCart();
    // Kiểm tra xem CartController đã được đăng ký chưa trước khi sử dụng
    if (Get.isRegistered<CartController>()) {
      Get.find<CartController>().countTotalPrice();
    }
  }
  
  // Phương thức đồng bộ cart một cách an toàn không chặn luồng chính
  void _syncCartSafely() {
    // Chạy đồng bộ trong background để không chặn navigation
    Future.microtask(() async {
      try {
        await syncCart();
      } catch (e) {
        // Log lỗi nhưng không làm gián đoạn navigation
        print('Error syncing cart: $e');
      }
    });
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    return page;
  }
}