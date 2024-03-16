
import 'package:get/get.dart';

class ProductManagerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProductManagerController());
  }
}

class ProductManagerController extends GetxController {

}