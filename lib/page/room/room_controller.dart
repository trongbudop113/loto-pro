import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/responsive/response_layout.dart';

class RoomBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => RoomController());
  }
}

class RoomController extends GetxController with WidgetsBindingObserver {

  List<ColorPaper> listPaper = [];

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

class ColorPaper{
  int? color;
  String? paperName;
  String? selectedName;
  bool? isSelected;

  ColorPaper({this.color, this.isSelected, this.paperName, this.selectedName});
}