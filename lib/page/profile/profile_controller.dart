import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loto/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}

class ProfileController extends GetxController {

  void onChangeThemeMode(BuildContext context){
    HapticFeedback.mediumImpact();
    Provider.of<ThemeProvider>(context, listen:false).toggleMode();
  }

}