import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loto/database/data_name.dart';

class ContactManagerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ContactManagerController());
  }
}

class ContactManagerController extends GetxController {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamGetListContact() {
    CollectionReference contactRef = firestore.collection(DataRowName.Contacts.name);
    var contact = contactRef
        .doc(DataCollection.ContactUs.name)
        .collection(DataCollection.SendMessage.name);

    return contact.snapshots();
  }

}