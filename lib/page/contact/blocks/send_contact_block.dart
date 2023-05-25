import 'package:flutter/material.dart';
import 'package:loto/page/contact/contact_controller.dart';

class SendContactBlock extends StatelessWidget {
  final ContactController controller;
  const SendContactBlock({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text("Liên Hệ Cho Tôi", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            child: Text("Gửi tin nhắn cho tôi, tôi sẽ phản hồi bạn trong thời gian sớm nhất.", style: TextStyle(fontSize: 16.0)),
          ),
          SizedBox(height: 15),
          TextField(
            controller: controller.nameController,
            decoration: InputDecoration(
              labelText: 'Họ và Tên',
            ),
            onChanged: (text) {

            },
          ),
          SizedBox(height: 10),
          TextField(
            controller: controller.emailController,
            decoration: InputDecoration(
              labelText: 'Email',
            ),
            onChanged: (text) {

            },
          ),
          SizedBox(height: 10),
          TextField(
            controller: controller.messageController,
            decoration: InputDecoration(
              labelText: 'Nội dung tin nhắn',
            ),
            onChanged: (text) {

            },
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: (){
              controller.onSendMessage();
            },
            child: Container(
              height: 45,
              color: Colors.black,
              alignment: Alignment.center,
              child: Text("Gửi tin nhắn", style: TextStyle(fontSize: 16.0, color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
