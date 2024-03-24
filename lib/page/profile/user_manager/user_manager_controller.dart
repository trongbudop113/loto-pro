
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loto/database/data_name.dart';

class UserManagerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => UserManagerController());
  }
}

class UserManagerController extends GetxController {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> getAllUser() {
    CollectionReference collectionRef = firestore.collection(DataRowName.Users.name);
    return collectionRef.snapshots();
  }
}