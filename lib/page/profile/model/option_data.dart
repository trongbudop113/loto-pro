import 'package:get/get.dart';

class OptionData {
  String? value;
  int? type;
  RxBool isSelected = false.obs;

  OptionData({this.value, this.type});
}