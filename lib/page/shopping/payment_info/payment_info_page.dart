import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/payment_info/payment_info_controller.dart';

class PaymentInfoPage extends GetView<PaymentInfoController> {
  const PaymentInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Image.network(
            "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/payment%2FIMG_0918.jpg?alt=media&token=b7c4b66d-836f-4aa8-918d-3c6b8688a180"
          )
        ],
      ),
    );
  }
}
