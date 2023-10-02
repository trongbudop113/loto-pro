import 'package:get/get.dart';

class PortFoliorBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PortFoliorController());
  }
}

class PortFoliorController extends GetxController {

}