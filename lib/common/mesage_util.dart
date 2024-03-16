import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageUtil {
  static void show({BuildContext? context, required String msg, int duration = 2}) {
    context ??= Get.context!;
    var snackBar = SnackBar(
      content: Text(msg),
      padding: const EdgeInsets.symmetric(
        vertical: 25,
        horizontal: 15,
      ),
      duration: Duration(seconds: duration),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
