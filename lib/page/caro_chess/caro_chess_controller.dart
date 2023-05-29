import 'package:get/get.dart';

class CaroChessBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CaroChessController());
  }
}

class CaroChessController extends GetxController {

  @override
  void onInit() {
    getArgument();
    super.onInit();
  }

  void getArgument(){

  }

}