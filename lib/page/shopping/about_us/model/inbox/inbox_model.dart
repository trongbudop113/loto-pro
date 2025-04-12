import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:loto/base/base_model.dart';
import 'package:flutter/cupertino.dart';

class InboxModel extends BaseModel{
  InboxModel();

  TextEditingController emailController = TextEditingController();

  @override
  void onFinish() {
    // TODO: implement onFinish
  }

  @override
  void onStart() {
    // TODO: implement onStart
  }

  void onSubscribe() {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar(
        'Thông báo',
        'Vui lòng nhập email của bạn',
        backgroundColor: Colors.white,
        colorText: const Color(0xFF333333),
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        'Thông báo',
        'Email không hợp lệ',
        backgroundColor: Colors.white,
        colorText: const Color(0xFF333333),
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // TODO: Add API call to subscribe email
    Get.snackbar(
      'Thành công',
      'Cảm ơn bạn đã đăng ký nhận thông tin',
      backgroundColor: const Color(0xFFFF8E25),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );

    emailController.clear();
  }
}