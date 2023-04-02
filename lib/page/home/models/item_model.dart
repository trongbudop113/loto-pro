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

class ItemRowModel {
  List<ItemModel>? items;
  bool? typeFull;
  ItemRowModel({this.items, this.typeFull = false});

  ItemRowModel.fromJson(Map<String, dynamic> json) {
    if(json['items'] != null){
      items = <ItemModel>[];
      json['items'].forEach((v) {
        items!.add(ItemModel.fromJson(v));
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
            ItemModel(number: 19),
            ItemModel(number: 0),
            ItemModel(number: 35),
            ItemModel(number: 49),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 71),
            ItemModel(number: 85),
          ]
      ),

      ItemRowModel(
          items: [
            ItemModel(number: 8),
            ItemModel(number: 14),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 47),
            ItemModel(number: 54),
            ItemModel(number: 0),
            ItemModel(number: 74),
            ItemModel(number: 0),
          ]
      ),

      ItemRowModel(
          items: [
            ItemModel(number: 6),
            ItemModel(number: 0),
            ItemModel(number: 25),
            ItemModel(number: 36),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 62),
            ItemModel(number: 0),
            ItemModel(number: 84),
          ]
      ),

      ItemRowModel(
          items: [], typeFull: true
      ),

      ItemRowModel(
          items: [
            ItemModel(number: 0),
            ItemModel(number: 15),
            ItemModel(number: 22),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 58),
            ItemModel(number: 0),
            ItemModel(number: 70),
            ItemModel(number: 89),
          ]
      ),

      ItemRowModel(
          items: [
            ItemModel(number: 0),
            ItemModel(number: 12),
            ItemModel(number: 0),
            ItemModel(number: 31),
            ItemModel(number: 43),
            ItemModel(number: 0),
            ItemModel(number: 68),
            ItemModel(number: 0),
            ItemModel(number: 90),
          ]
      ),

      ItemRowModel(
          items: [
            ItemModel(number: 1),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 0),
            ItemModel(number: 42),
            ItemModel(number: 0),
            ItemModel(number: 65),
            ItemModel(number: 72),
            ItemModel(number: 87),
          ]
      ),

      ItemRowModel(
          items: [], typeFull: true
      ),

      ItemRowModel(
          items: [
            ItemModel(number: 5),
            ItemModel(number: 0),
            ItemModel(number: 21),
            ItemModel(number: 38),
            ItemModel(number: 0),
            ItemModel(number: 52),
            ItemModel(number: 0),
            ItemModel(number: 76),
            ItemModel(number: 0),
          ]
      ),

      ItemRowModel(
          items: [
            ItemModel(number: 0),
            ItemModel(number: 13),
            ItemModel(number: 0),
            ItemModel(number: 33),
            ItemModel(number: 0),
            ItemModel(number: 57),
            ItemModel(number: 67),
            ItemModel(number: 0),
            ItemModel(number: 82),
          ]
      ),

      ItemRowModel(
          items: [
            ItemModel(number: 0),
            ItemModel(number: 11),
            ItemModel(number: 26),
            ItemModel(number: 0),
            ItemModel(number: 44),
            ItemModel(number: 0),
            ItemModel(number: 69),
            ItemModel(number: 79),
            ItemModel(number: 0),
          ]
      ),
    ];
  }
}