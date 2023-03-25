import 'package:firebase_auth/firebase_auth.dart';
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
    if(FirebaseAuth.instance.currentUser != null){
      goToPage(PageConfig.MENU);
    }else{
      goToPage(PageConfig.LOGIN);
    }
  }

  void goToPage(String pageName){
    Future.delayed(const Duration(seconds: 2), (){
      Get.toNamed(pageName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Image.asset(ImageResource.ic_app_loto, width: Get.width * 0.5),
      ),
    );
  }
}
