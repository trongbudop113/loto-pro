
import 'package:get/get.dart';
import 'package:loto/responsive/screen_size_config.dart';

class DividerLayoutModel {
  void init({Map<DeviceScreen, int>? responsiveScreens})    {
    if(responsiveScreens != null){
      for(var k in ScreenSizeConfig.list){
        listResponsiveScreens[k.key] = responsiveScreens[k.key] ?? numberOfRow;
      }
    }
  }


  static const numberOfRow = 9;

  static final Rx<DeviceScreen> key = DeviceScreen.mobile.obs;

  final Map<DeviceScreen, int> listResponsiveScreens = {
    DeviceScreen.mobile : 1,
    DeviceScreen.tablet: 1,
    DeviceScreen.desktop: 1,
  };

  int get sumRow => numberOfRow;
}