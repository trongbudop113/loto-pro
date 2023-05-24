
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/contact/contact_controller.dart';
import 'package:loto/page/contact/models/contact_data.dart';

class ContactPage extends GetView<ContactController>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() => Visibility(
        visible: (controller.contactData.value.phone ?? '').isNotEmpty,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text("Thông Tin Liên Hệ", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 15),
            Container(
              alignment: Alignment.centerLeft,
              child: Text("Số điện thoại: ${controller.contactData.value.phone}", style: TextStyle(fontSize: 16.0)),
            ),
            SizedBox(height: 15),
            Container(
              alignment: Alignment.centerLeft,
              child: Text("Email: ${controller.contactData.value.email}", style: TextStyle(fontSize: 16.0)),
            ),
            SizedBox(height: 15),
            Container(
              alignment: Alignment.centerLeft,
              child: Text("Địa chỉ: ${controller.contactData.value.address}", style: TextStyle(fontSize: 16.0)),
            ),
            SizedBox(height: 15),
            Container(
              alignment: Alignment.centerLeft,
              child: Text("${controller.contactData.value.content}", style: TextStyle(fontSize: 16.0)),
            ),
          ],
        ),
      )),
    );
  }
}

