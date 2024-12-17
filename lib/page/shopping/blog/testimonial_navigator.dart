import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/base/destination.dart';
import 'package:loto/common/common.dart';

class TestimonialNavigator extends StatelessWidget {
  const TestimonialNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody(){
    return Navigator(
      key: Get.nestedKey(2),
      initialRoute: Destination.blog.route,
      onGenerateRoute: (settings) {
        Get.routing.args = settings.arguments;
        AppCommon.singleton.blogRoute = settings.name ?? '';
        return Destination.getPage(settings);
      },

    );
  }
}
