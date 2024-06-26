import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/models/user_login.dart';
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
    getDataUser();
    super.onInit();
  }

  Future<void> getDataUser() async {
    try {
      CollectionReference usersReference = firestore.collection(DataRowName.Users.name);
      final getUSer = await usersReference.doc(FirebaseAuth.instance.currentUser?.uid ?? '').get();
      if (getUSer.data() == null) return;
      var userLogin = UserLogin.fromJson(getUSer.data() as Map<String, dynamic>);
      if (userLogin.isAdmin ?? false) {
        return;
      }
      nameController.text = userLogin.name ?? '';
      emailController.text = userLogin.email ?? '';
    } catch (e) {

    }
  }

  void getArgument(){
    documentID = Get.arguments["blockID"];
    streamGetContact(documentID);
  }

  Future<void> streamGetContact(String documentID) async {
    CollectionReference menuRef = firestore.collection(DataRowName.Contacts.name);
    var data = await menuRef.doc(documentID).get();
    contactData.value =  ContactData.fromJson(data.data() as Map<String, dynamic>);
  }

  Future<void> onSendMessage() async {

    final DateTime createTime = DateTime.now();

    SendContact sendContact = SendContact();
    sendContact.content = messageController.text;
    sendContact.name = nameController.text;
    sendContact.email = emailController.text;
    sendContact.isRead = false;
    sendContact.createTime = createTime;

    CollectionReference contactRef = firestore.collection(DataRowName.Contacts.name);
    await contactRef.doc(documentID).collection(DataCollection.SendMessage.name).doc(createTime.millisecondsSinceEpoch.toString()).set(sendContact.toJson());

    messageController.clear();
    nameController.clear();
    emailController.clear();
  }

}