import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/landing/body/desktop_body.dart';
import 'package:loto/page/landing/body/mobile_body.dart';
import 'package:loto/page/landing/body/tablet_body.dart';
import 'package:loto/page/landing/landing_controller.dart';
import 'package:loto/responsive/responsive_layout.dart';


class LandingPage extends GetView<LandingController>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobileBody: MyMobileBody(
          controller: controller,
        ),
        desktopBody: MyDesktopBody(
          controller: controller,
        ),
        tabletBody: MyTabletBody(
          controller: controller,
        ),
      ),
    );
  }
}