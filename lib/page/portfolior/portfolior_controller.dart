import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/portfolior/widget/page_slide.dart';

class PortFoliorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PortFoliorController());
  }
}

class PortFoliorController extends GetxController {
  String linkin =
      "https://www.linkedin.com/in/l%C6%B0u-ho%C3%A0ng-tr%E1%BB%8Dng-b87970140?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app";

  PageController pageController = PageController();
  final List<Widget> listPage = <Widget>[
    const Center(
      child: Pages(
        text: "Page 1",
      ),
    ),
    const Center(
      child: Pages(
        text: "Page 2",
      ),
    ),
    const Center(
      child: Pages(
        text: "Page 3",
      ),
    ),
    const Center(
      child: Pages(
        text: "Page 4",
      ),
    )
  ];
  final RxInt curr = 0.obs;

  void onTapForward() {
    if(curr.value == 0) return;
    pageController.animateToPage(curr.value - 1, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void onTapNext() {
    if(curr.value == listPage.length - 1) return;
    pageController.animateToPage(curr.value + 1, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }
}
