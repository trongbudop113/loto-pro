import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PaymentInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentInfoController());
  }
}

class PaymentInfoController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;



}
