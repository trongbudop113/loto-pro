import 'package:loto/page/shopping/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:
        width < 600 ?_buildMobile(context) : (width >= 600 && width < 900) ? _buildTablet(context) :  _buildWeb(context),
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

  Widget _buildMobile(BuildContext context) {
    return buildMobileUI(context);
  }

  Widget _buildTablet(BuildContext context) {
    return buildTablet(context);
  }

  Widget buildTablet(BuildContext context) {
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

  Widget buildSocial() {
    return Container();
  }

}