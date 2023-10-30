import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/core/custom_get_view.dart';
import 'package:loto/page/landing/body/desktop_body.dart';
import 'package:loto/page/landing/body/mobile_body.dart';
import 'package:loto/page/landing/body/tablet_body.dart';
import 'package:loto/page/landing/landing_controller.dart';
import 'package:loto/responsive/responsive_layout.dart';


class LandingPage extends CustomGetView<LandingController>{

  @override
  Widget buildBodyMobile(BuildContext context) {
    return MyMobileBody(
      controller: controller,
    );
  }

  @override
  Widget buildBodyTablet(BuildContext context) {
    return MyTabletBody(
      controller: controller,
    );
  }

  @override
  Widget buildBodyWeb(BuildContext context) {
    return MyDesktopBody(
      controller: controller,
    );
  }
}