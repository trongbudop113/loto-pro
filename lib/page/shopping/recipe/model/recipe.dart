import 'package:get/get.dart';

class RecipeModel {
  int? cakeID;
  int? unit;
  List<CakeIngredient>? cakeIngredient;
  String? cakeName;
  String? ext;
  int? type;
  List<int>? relate;

  List<CakeIngredient> cakeIngredientSub = [];

  RxBool isSelected = false.obs;

  RecipeModel({
    this.cakeID,
    this.unit,
    this.cakeIngredient,
    this.cakeName,
    this.ext,
    this.type,
    this.relate,
  });

  RecipeModel.fromJson(Map<String, dynamic> json) {
    cakeID = json['cakeID'];
    unit = json['unit'];
    if (json['cakeIngredient'] != null) {
      cakeIngredient = <CakeIngredient>[];
      json['cakeIngredient'].forEach((v) {
        cakeIngredient!.add(new CakeIngredient.fromJson(v));
      });
    }
    cakeName = json['cakeName'];
    ext = json['ext'];
    if(json['relate'] != null){
      relate = json['relate'].cast<int>();
    }
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cakeID'] = this.cakeID;
    data['unit'] = this.unit;
    if (this.cakeIngredient != null) {
      data['cakeIngredient'] =
          this.cakeIngredient!.map((v) => v.toJson()).toList();
    }
    data['cakeName'] = this.cakeName;
    data['ext'] = this.ext;
    data['relate'] = this.relate;
    data['type'] = this.type;
    return data;
  }
}

class CakeIngredient {
  int? id;
  double? quantity;
  String name = "";
  String ext = "";
  int unit = 0;
  double total = 0.0;

  CakeIngredient({this.id, this.quantity});

  CakeIngredient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    return data;
  }

  CakeIngredient.setDefault(String name){
    {
      id = -1;
      quantity = 0;
      this.name = name;
    }
  }
}
