import 'package:loto/page/home/models/item_model.dart';

class SelectPaper{
  String? color;
  String? paperName;
  String? selectedName;
  bool? isSelected;
  int? sortOrder;
  int? createDate;

  List<ItemRowModel>? papers;

  SelectPaper({this.color, this.isSelected, this.paperName, this.selectedName, this.papers, this.sortOrder, this.createDate});

  SelectPaper.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    isSelected = json['isSelected'];
    paperName = json['paperName'];
    selectedName = json['selectedName'];
    if (json['papers'] != null) {
      papers = <ItemRowModel>[];
      json['papers'].forEach((v) {
        papers!.add(ItemRowModel.fromJson(v));
      });
    }
    createDate = json['createDate'];
    sortOrder = json['sortOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['color'] = this.color;
    data['isSelected'] = this.isSelected;
    data['paperName'] = this.paperName;
    data['selectedName'] = this.selectedName;
    if (this.papers != null) {
      data['papers'] = this.papers!.map((v) => v.toJson()).toList();
    }
    data['createDate'] = this.createDate;
    data['sortOrder'] = this.sortOrder;
    return data;
  }
}