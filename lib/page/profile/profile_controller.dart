import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}

class ProfileController extends GetxController {

  void onChangeThemeMode(BuildContext context){
    // HapticFeedback.mediumImpact();
    // Provider.of<ThemeProvider>(context, listen:false).toggleMode();
    test(context);
  }

  void test(BuildContext context){

  }

}