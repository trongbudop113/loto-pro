import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/contact/models/contact_data.dart';
import 'package:loto/page/contact/models/send_contact.dart';


class ContactBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ContactController());
  }
}

class ContactController extends GetxController {

  final Rx<ContactData> contactData = ContactData().obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String documentID = "";

  @override
  void onInit() {
    getArgument();
    super.onInit();
  }

  void getArgument(){
    documentID = Get.arguments as String;
    streamGetContact(documentID);
  }

  Future<void> streamGetContact(String documentID) async {
    CollectionReference menuRef = firestore.collection(DataRowName.Contacts.name);
    var data = await menuRef.doc(documentID).get();
    contactData.value =  ContactData.fromJson(data.data() as Map<String, dynamic>);
  }

  Future<void> onSendMessage() async {

    final int createTime = DateTime.now().millisecondsSinceEpoch;

    SendContact sendContact = SendContact();
    sendContact.content = messageController.text;
    sendContact.name = nameController.text;
    sendContact.email = emailController.text;
    sendContact.isRead = false;
    sendContact.createTime = createTime;

    CollectionReference contactRef = firestore.collection(DataRowName.Contacts.name);
    await contactRef.doc(documentID).collection("SendMessage").doc(createTime.toString()).set(sendContact.toJson());

    messageController.clear();
    nameController.clear();
    emailController.clear();
  }

}