import 'package:get/get.dart';

class EggData{
  String? name;
  int? value;
  RxBool isSelect = false.obs;

  EggData({this.value, this.name});

  static List<EggData> listTwo(){
    return [
      EggData(name: "Không trứng", value: 0),
      EggData(name: "1 trứng", value: 1),
    ];
  }

  static List<EggData> listThree(){
    return [
      EggData(name: "Không trứng", value: 0),
      EggData(name: "1 trứng", value: 1),
      EggData(name: "2 trứng", value: 2),
    ];
  }
}