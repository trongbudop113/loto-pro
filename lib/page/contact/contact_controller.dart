import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/contact/models/contact_data.dart';


class ContactBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ContactController());
  }
}

class ContactController extends GetxController {

  final Rx<ContactData> contactData = ContactData().obs;

  @override
  void onInit() {
    streamGetContact();
    super.onInit();
  }

  Future<void> streamGetContact() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference menuRef = firestore.collection(DataRowName.Contacts.name);
    var data = await menuRef.doc('ContactUs').get();
    contactData.value =  ContactData.fromJson(data.data() as Map<String, dynamic>);
  }

}