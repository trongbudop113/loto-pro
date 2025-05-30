import 'package:flutter/material.dart';

class IngredientForm {
  late TextEditingController ext;
  int? id;
  late TextEditingController name;
  late TextEditingController price;
  late TextEditingController unit;

  IngredientForm({this.id}){
    ext = TextEditingController();
    name = TextEditingController();
    price = TextEditingController();
    unit = TextEditingController();
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ext'] = ext.text.trim();
    data['id'] = id;
    data['name'] = name.text.trim();
    data['price'] = int.parse(price.text.trim());
    data['unit'] = int.parse(unit.text.trim());
    data['type'] = 2;
    return data;
  }
}