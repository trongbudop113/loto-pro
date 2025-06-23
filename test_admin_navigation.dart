// Test file để navigate đến admin page
// Có thể sử dụng trong main.dart hoặc từ một button

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page_config.dart';

// Thêm button này vào bất kỳ page nào để test admin page
Widget buildAdminTestButton() {
  return ElevatedButton(
    onPressed: () {
      Get.toNamed(PageConfig.ADMIN);
    },
    child: const Text('Go to Admin Page'),
  );
}

// Hoặc navigate trực tiếp
void navigateToAdminPage() {
  Get.toNamed(PageConfig.ADMIN);
}

// Test URL: http://localhost:8080/#/admin