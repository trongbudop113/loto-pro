import 'package:flutter/material.dart';
import 'package:loto/page/contact/contact_controller.dart';

class InfoBlock extends StatelessWidget {
  final ContactController controller;
  const InfoBlock({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text("Thông Tin Liên Hệ", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          SizedBox(height: 15),
          Container(
            alignment: Alignment.centerLeft,
            child: Text("Số điện thoại: ${controller.contactData.value.phone}", style: TextStyle(fontSize: 16.0, color: Colors.white)),
          ),
          SizedBox(height: 15),
          Container(
            alignment: Alignment.centerLeft,
            child: Text("Email: ${controller.contactData.value.email}", style: TextStyle(fontSize: 16.0, color: Colors.white)),
          ),
          SizedBox(height: 15),
          Container(
            alignment: Alignment.centerLeft,
            child: Text("Địa chỉ: ${controller.contactData.value.address}", style: TextStyle(fontSize: 16.0, color: Colors.white)),
          ),
          SizedBox(height: 15),
          Container(
            alignment: Alignment.centerLeft,
            child: Text("${controller.contactData.value.content}", style: TextStyle(fontSize: 16.0, color: Colors.white)),
          ),
        ],
      )
    );
  }
}
