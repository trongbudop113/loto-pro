import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/resources/image_resource.dart';
import 'package:loto/page_config.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData(){
    goToPage(PageConfig.LANDING);
  }

  void goToPage(String pageName){
    Future.delayed(const Duration(seconds: 2), (){
      Get.offNamed(pageName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: Center(
        child: Image.asset(ImageResource.ic_app_logo, width: Get.width * 0.5),
      ),
    );
  }
}
