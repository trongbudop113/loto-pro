import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseModel{
  final RxBool isLoading = false.obs;
  VoidCallback? submitCallBack;

  void onStart();

  void onFinish();
}