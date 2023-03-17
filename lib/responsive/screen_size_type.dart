
import 'package:get/get.dart';
import 'package:loto/responsive/screen_size_config.dart';

class ScreenSizeType{
  static DeviceScreen getScreenType () {
    double width = Get.width;

    //var ls = [600, 1000, 1400];
    var items = ScreenSizeConfig.list.where((element) => width <= element.maxWidth).toList();

    items.add(ScreenSizeConfig.list.last);
    return items.first.key;
  }
}