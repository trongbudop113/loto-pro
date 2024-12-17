import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/base/destination.dart';
import 'package:loto/common/common.dart';

class ShopProductNavigator extends StatelessWidget {
  const ShopProductNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody(){
    return Navigator(
      key: Get.nestedKey(1),
      initialRoute: Destination.shop_product.route,
      onGenerateRoute: (settings) {
        Get.routing.args = settings.arguments;
        AppCommon.singleton.shopRoute = settings.name ?? '';
        return Destination.getPage(settings);
      },
    );
  }
}
