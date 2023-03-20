import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/menu/model/menu.dart';
import 'package:loto/responsive/response_layout.dart';

class MenuBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MenuController());
  }
}

class MenuController extends GetxController with WidgetsBindingObserver {

  List<MenuCategory> listMenu = MenuCategory.listEx();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeMetrics() {
    ResponsiveLayout.updateKeyScreen();
  }

}

