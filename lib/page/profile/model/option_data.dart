import 'package:get/get.dart';

class OptionData {
  String? value;
  RxBool isSelected = false.obs;

  OptionData({this.value});
}