import 'package:get/get.dart';

class ItemModel {
  int? number;
  RxBool isCheck = false.obs;
  ItemModel({this.number});

  ItemModel.fromJson(Map<String, dynamic> json) {
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = this.number;
    return data;
  }
}
class ItemModelChange {
  RxInt? number = 0.obs;

  ItemModelChange();

  ItemModelChange.fromJson(Map<String, dynamic> json) {
    number?.value = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = this.number?.value;
    return data;
  }
}

class ItemRowModel {
  List<ItemModel>? items;
  bool? typeFull;
  ItemRowModel({this.items, this.typeFull = false});

  ItemRowModel.fromJson(Map<String, dynamic> json) {
    if(json['data'] != null){
      items = <ItemModel>[];
      json['data'].forEach((v) {
        items?.add(ItemModel.fromJson(v));
      });
    }
    typeFull = json['typeFull'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['typeFull'] = this.typeFull;
    if (this.items != null) {
      data['data'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static List<ItemRowModel> exData(){
    return [
      ItemRowModel(
          items: [
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
          ]
      ),

      ItemRowModel(
          items: [
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
          ]
      ),

      ItemRowModel(
          items: [
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
          ]
      ),

      ItemRowModel(
          items: [], typeFull: true
      ),

      ItemRowModel(
          items: [
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
          ]
      ),

      ItemRowModel(
          items: [
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
          ]
      ),

      ItemRowModel(
          items: [
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
          ]
      ),

      ItemRowModel(
          items: [], typeFull: true
      ),

      ItemRowModel(
          items: [
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
          ]
      ),

      ItemRowModel(
          items: [
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
          ]
      ),

      ItemRowModel(
          items: [
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
          ]
      ),
    ];
  }
}

class ItemRowModelChange {
  List<ItemModelChange>? items;
  bool? typeFull;
  ItemRowModelChange({this.items, this.typeFull = false});

  ItemRowModelChange.fromJson(Map<String, dynamic> json) {
    if(json['data'] != null){
      items = <ItemModelChange>[];
      json['data'].forEach((v) {
        items?.add(ItemModelChange.fromJson(v));
      });
    }
    typeFull = json['typeFull'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['typeFull'] = this.typeFull;
    if (this.items != null) {
      data['data'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}