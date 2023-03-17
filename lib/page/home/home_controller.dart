import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
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

class ItemModel {
  int? number;
  RxBool isCheck = false.obs;
  ItemModel({this.number});
}

class ItemRowModel {
  List<ItemModel>? items;
  bool typeFull;
  ItemRowModel({this.items, this.typeFull = false});

  static List<ItemRowModel> exData(){
    return [
      ItemRowModel(
        items: [
          ItemModel(number: 0),
          ItemModel(number: 13),
          ItemModel(number: 22),
          ItemModel(number: 0),
          ItemModel(number: 41),
          ItemModel(number: 0),
          ItemModel(number: 61),
          ItemModel(number: 0),
          ItemModel(number: 86),
        ]
      ),

      ItemRowModel(
        items: [
          ItemModel(number: 3),
          ItemModel(number: 0),
          ItemModel(number: 24),
          ItemModel(number: 24),
          ItemModel(number: 0),
          ItemModel(number: 52),
          ItemModel(number: 0),
          ItemModel(number: 71),
          ItemModel(number: 0),
        ]
      ),

      ItemRowModel(
        items: [
          ItemModel(number: 1),
          ItemModel(number: 0),
          ItemModel(number: 0),
          ItemModel(number: 35),
          ItemModel(number: 0),
          ItemModel(number: 56),
          ItemModel(number: 64),
          ItemModel(number: 0),
          ItemModel(number: 83),
        ]
      ),

      ItemRowModel(
        items: [], typeFull: true
      ),

      ItemRowModel(
          items: [
            ItemModel(number: 7),
            ItemModel(number: 0),
            ItemModel(number: 23),
            ItemModel(number: 36),
            ItemModel(number: 0),
            ItemModel(number: 53),
            ItemModel(number: 0),
            ItemModel(number: 75),
            ItemModel(number: 0),
          ]
      ),

      ItemRowModel(
          items: [
            ItemModel(number: 5),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 48),
            ItemModel(number: 59),
            ItemModel(number: 0),
            ItemModel(number: 72),
            ItemModel(number: 84),
          ]
      ),

      ItemRowModel(
          items: [
            ItemModel(number: 0),
            ItemModel(number: 14),
            ItemModel(number: 28),
            ItemModel(number: 0),
            ItemModel(number: 42),
            ItemModel(number: 0),
            ItemModel(number: 60),
            ItemModel(number: 0),
            ItemModel(number: 87),
          ]
      ),


      ItemRowModel(
          items: [], typeFull: true
      ),

      ItemRowModel(
          items: [
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 26),
            ItemModel(number: 0),
            ItemModel(number: 47),
            ItemModel(number: 50),
            ItemModel(number: 0),
            ItemModel(number: 79),
            ItemModel(number: 89),
          ]
      ),

      ItemRowModel(
          items: [
            ItemModel(number: 4),
            ItemModel(number: 10),
            ItemModel(number: 0),
            ItemModel(number: 30),
            ItemModel(number: 49),
            ItemModel(number: 0),
            ItemModel(number: 66),
            ItemModel(number: 0),
            ItemModel(number: 0),
          ]
      ),

      ItemRowModel(
          items: [
            ItemModel(number: 0),
            ItemModel(number: 15),
            ItemModel(number: 25),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 51),
            ItemModel(number: 0),
            ItemModel(number: 76),
            ItemModel(number: 81),
          ]
      ),
    ];
  }
}