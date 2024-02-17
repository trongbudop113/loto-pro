import 'package:get/get.dart';

class EggData{
  String? name;
  int? value;
  RxBool isSelect = false.obs;

  int? defaultPrice;

  EggData({this.value, this.name, this.defaultPrice});

  static List<EggData> listTwo(){
    return [
      EggData(name: "Không trứng", value: 0, defaultPrice: -5000),
      EggData(name: "1 trứng", value: 1, defaultPrice: 0),
    ];
  }

  static List<EggData> listThree(){
    return [
      EggData(name: "Không trứng", value: 0, defaultPrice: -5000),
      EggData(name: "1 trứng", value: 1, defaultPrice: 0),
      EggData(name: "2 trứng", value: 2, defaultPrice: 5000),
    ];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['egg_name'] = name;
    data['egg_value'] = value;
    data['default_price'] = defaultPrice;
    return data;
  }
}