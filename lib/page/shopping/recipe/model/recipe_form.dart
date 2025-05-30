import 'package:flutter/material.dart';
import 'package:loto/page/shopping/recipe/model/ingredient.dart';
import 'package:loto/page/shopping/recipe/model/recipe.dart';
import 'package:loto/page/shopping/recipe/model/recipe_type.dart';

class RecipeForm {
  int? cakeID;
  late TextEditingController unit;
  List<CakeIngredientForm> cakeIngredient = [];
  late TextEditingController cakeName;
  late TextEditingController ext;
  late RecipeType recipeType;
  List<int> relate = [];

  List<RecipeModel> listSub = [];
  List<RecipeModel> listSubPick = [];

  final List<RecipeType> listType = RecipeType.listType();
  List<CakeIngredientForm> listIngredientPick = [];

  String documentID = '';

  RecipeForm({
    this.cakeID,
    required List<IngredientModel> listModel,
    List<RecipeModel>? listSub,
  }) {
    unit = TextEditingController();
    cakeName = TextEditingController();
    ext = TextEditingController();
    unit = TextEditingController();
    recipeType = listType.first;
    listIngredientPick = listModel.map<CakeIngredientForm>((e) {
      var a = CakeIngredientForm();
      a.id = e.id;
      a.name = e.name ?? '';
      return a;
    }).toList();
    listSubPick = listSub ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cakeID'] = cakeID;
    data['unit'] = int.parse(unit.text.trim());
    data['cakeIngredient'] = cakeIngredient.map((v) => v.toJson()).toList();
    data['cakeName'] = cakeName.text;
    data['ext'] = ext.text;
    data['relate'] = relate;
    data['type'] = recipeType.typeID;
    data['documentID'] = documentID;
    return data;
  }

  void dispose() {
    cakeID = null;
    cakeName.dispose();
    unit.dispose();
    ext.dispose();
    relate = [];
    recipeType = listType.first;
    if (cakeIngredient.isNotEmpty) {
      for (var e in cakeIngredient) {
        e.dispose();
      }
    }
  }
}

class CakeIngredientForm {
  int? id;
  String name = '';
  late TextEditingController quantity;

  CakeIngredientForm() {
    quantity = TextEditingController();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = double.parse(quantity.text.trim());
    return data;
  }

  void dispose() {
    quantity.dispose();
    id = null;
  }
}
