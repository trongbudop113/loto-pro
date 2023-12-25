import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loto/common/custom_icon_icons.dart';
import 'package:loto/page/portfolior/models/page_data.dart';
import 'package:loto/page/portfolior/pages/page_five.dart';
import 'package:loto/page/portfolior/pages/page_four.dart';
import 'package:loto/page/portfolior/pages/page_main.dart';
import 'package:loto/page/portfolior/pages/page_one.dart';
import 'package:loto/page/portfolior/pages/page_six.dart';
import 'package:loto/page/portfolior/pages/page_three.dart';
import 'package:loto/page/portfolior/pages/page_two.dart';

class PortFoliorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PortFoliorController());
  }
}

class PortFoliorController extends GetxController {
  TextStyle textStyleNewFont = GoogleFonts.oswald(height: 1);

  String linkin =
      "https://www.linkedin.com/in/l%C6%B0u-ho%C3%A0ng-tr%E1%BB%8Dng-b87970140?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app";

  PageController pageController = PageController();
  List<PageData> listPage = [];
  final RxInt curr = 0.obs;

  void onTapForward() {
    if (curr.value == 0) return;
    pageController.animateToPage(curr.value - 1,
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void onTapNext() {
    if (curr.value == listPage.length - 1) return;
    pageController.animateToPage(curr.value + 1,
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  void initData() {
    listPage = <PageData>[
      PageData(
          page: Center(
              child: PageMain(
            portFoliorController: this,
          )),
          pageIcon: CustomIcon.home,
          pageName: "Intro"),
      PageData(
          page: Center(child: PageOne()),
          pageIcon: CustomIcon.user,
          pageName: "Home"),
      PageData(
          page: Center(child: PageTwo()),
          pageIcon: CustomIcon.shopping_bag,
          pageName: "About Me"),
      PageData(
          page: Center(child: PageThree()),
          pageIcon: CustomIcon.timeline,
          pageName: "Resume"),
      PageData(
          page: Center(child: PageFour()),
          pageIcon: CustomIcon.monetization_on,
          pageName: "PortFolio"),
      PageData(
          page: Center(child: PageFive()),
          pageIcon: CustomIcon.phone_square_alt,
          pageName: "Testimonials"),
      PageData(
          page: Center(child: PageSix()),
          pageIcon: CustomIcon.shopping_bag,
          pageName: "Contact"),
    ];
  }
}
