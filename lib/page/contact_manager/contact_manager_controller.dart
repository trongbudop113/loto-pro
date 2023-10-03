import 'package:get/get.dart';

class ContactManagerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ContactManagerController());
  }
}

class ContactManagerController extends GetxController {

}