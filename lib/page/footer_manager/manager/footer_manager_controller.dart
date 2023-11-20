import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/footer_manager/editor/footer_editor_page.dart';
import 'package:loto/page/footer_manager/models/footer_menu.dart';
import 'package:loto/page/footer_manager/show_page/footer_show_page.dart';

class FooterManagerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => FooterManagerController());
  }
}

class FooterManagerController extends GetxController {

  List<Vehicle> vehicles = [
    Vehicle(
      'Bike',
      ['Vehicle no. 1', 'Vehicle no. 2', 'Vehicle no. 7', 'Vehicle no. 10'],
      Icons.motorcycle,
    ),
    Vehicle(
      'Cars',
      ['Vehicle no. 3', 'Vehicle no. 4', 'Vehicle no. 6'],
      Icons.directions_car,
    ),
  ];

  void goToPage(){

    //Get.to(FooterEditorPage());
    goToShowPage();
  }

  void goToShowPage(){
    Get.to(FooterShowPage());
  }

}