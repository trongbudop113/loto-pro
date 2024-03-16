
import 'package:get/get.dart';

class UserManagerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => UserManagerController());
  }
}

class UserManagerController extends GetxController {

}