import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    Future.delayed(const Duration(seconds: 2), (){
      Get.toNamed(PageConfig.MENU);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Image.asset('images/loto.png', width: Get.width * 0.5),
      ),
    );
  }
}
