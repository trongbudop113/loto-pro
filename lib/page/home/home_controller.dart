import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loto/page/home/models/item_model.dart';
import 'package:loto/responsive/response_layout.dart';


class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class HomeController extends GetxController with WidgetsBindingObserver {

  List<ItemRowModel> listData = ItemRowModel.exData();

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
    ResponsiveLayout.updateKeyScreen();
  }


  void onTapNumber(int i, int j){
    int number = listData[i].items![j].number!;

    int count = 0;
    for(var data in listData[i].items!){
      if((data.number ?? 0) > 0 && data.isCheck.value){
        count++;
      }
    }

    if(count == 4){
      print('wait wait wait wait');
      return;
    }

    if(count == 5){
      print('win win win win');
      return;
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeMetrics() {
    ResponsiveLayout.updateKeyScreen();
  }
}