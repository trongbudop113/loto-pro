import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/about_us/about_controller.dart';

class AboutPage extends GetView<AboutController> {
  const AboutPage({super.key});

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
    return ListView.builder(
      itemCount: controller.listModelViewMobile.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (c, i){
        return controller.listModelViewMobile[i];
      },
    );
  }

  Widget buildTabletUI(BuildContext context) {
    return ListView.builder(
      itemCount: controller.listModelViewTablet.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (c, i){
        return controller.listModelViewTablet[i];
      },
    );
  }

  Widget buildWebUI(BuildContext context) {
    return ListView.builder(
      itemCount: controller.listModelView.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (c, i){
        return controller.listModelView[i];
      },
    );
  }
}
