import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/shop_product_detail/shop_product_detail_controller.dart';

class ShopProductDetailPage extends GetView<BlogDetailController> {
  const ShopProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:
            width > 900 ? _buildWeb(context) : _buildTabletAndMobile(context),
      ),
    );
  }

  Widget _buildWeb(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 1440,
          minWidth: 600,
        ),
        child: buildWebUI(context),
      ),
    );
  }

  Widget _buildTabletAndMobile(BuildContext context) {
    return buildMobileUI(context);
  }

  Widget buildMobileUI(BuildContext context) {
    return Column(
      children: controller.listModelView,
    );
  }

  Widget buildWebUI(BuildContext context) {
    return Column(
      children: controller.listModelView,
    );
  }
}
