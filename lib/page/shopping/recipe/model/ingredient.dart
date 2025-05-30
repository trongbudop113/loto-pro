import 'package:loto/page/shopping/recipe/model/ingredient_form.dart';

class IngredientModel {
  String? ext;
  int? id;
  String? name;
  int? price;
  int? type;
  int? unit;

  IngredientModel(
      {this.ext, this.id, this.name, this.price, this.type, this.unit});

  IngredientModel.fromJson(Map<String, dynamic> json) {
    ext = json['ext'];
    id = json['id'];
    name = json['name'];
    price = json['price'];
    type = json['type'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ext'] = this.ext;
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['type'] = this.type;
    data['unit'] = this.unit;
    return data;
  }

  IngredientModel.fromOther(IngredientForm form) {
    ext = form.ext.text;
    id = form.id;
    name = form.name.text;
    price = int.parse(form.price.text.trim());
    type = 2;
    unit = int.parse(form.unit.text.trim());
  }
}