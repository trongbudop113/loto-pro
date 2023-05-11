import 'package:loto/page/home/models/item_model.dart';

class SelectPaper{
  String? color;
  String? paperName;
  String? selectedName;
  String? selectedUserID;
  String? paperID;
  bool? isSelected;
  int? sortOrder;
  int? createDate;

  List<ItemRowModel>? papers;

  SelectPaper({this.color, this.isSelected, this.paperName, this.selectedName, this.papers, this.sortOrder, this.createDate, this.paperID, this.selectedUserID});

  SelectPaper.fromJson(Map<String, dynamic> json) {
    paperID = json['paperID'];
    color = json['color'];
    isSelected = json['isSelected'];
    paperName = json['paperName'];
    selectedName = json['selectedName'];
    selectedUserID = json['selectedUserID'];
    if (json['papers'] != null) {
      papers = <ItemRowModel>[];
      json['papers'].forEach((v) {
        papers?.add(ItemRowModel.fromJson(v));
      });
    }
    createDate = json['createDate'];
    sortOrder = json['sortOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paperID'] = this.paperID;
    data['color'] = this.color;
    data['isSelected'] = this.isSelected;
    data['paperName'] = this.paperName;
    data['selectedName'] = this.selectedName;
    data['selectedUserID'] = this.selectedUserID;
    if (this.papers != null) {
      data['papers'] = this.papers!.map((v) => v.toJson()).toList();
    }
    data['createDate'] = this.createDate;
    data['sortOrder'] = this.sortOrder;
    return data;
  }
}

class SelectPaperChange{
  String? color;
  String? paperName;
  String? selectedName;
  String? paperID;
  bool? isSelected;
  int? sortOrder;
  int? createDate;
  String? selectedUserID;

  List<ItemRowModelChange>? papers;

  SelectPaperChange({this.color, this.isSelected, this.paperName, this.selectedName, this.papers, this.sortOrder, this.createDate, this.paperID, this.selectedUserID});

  SelectPaperChange.fromJson(Map<String, dynamic> json) {
    paperID = json['paperID'];
    color = json['color'];
    isSelected = json['isSelected'];
    paperName = json['paperName'];
    selectedName = json['selectedName'];
    selectedUserID = json['selectedUserID'];
    if (json['papers'] != null) {
      papers = <ItemRowModelChange>[];
      json['papers'].forEach((v) {
        papers?.add(ItemRowModelChange.fromJson(v));
      });
    }
    createDate = json['createDate'];
    sortOrder = json['sortOrder'];
  }

  static SelectPaperChange convertData(SelectPaper value){
    return SelectPaperChange(
      color: value.color,
      paperName: value.paperName,
      selectedName: value.selectedName,
      paperID: value.paperID,
      sortOrder: value.sortOrder,
      isSelected: value.isSelected,
      createDate: value.createDate,
     selectedUserID: value.selectedUserID
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paperID'] = this.paperID;
    data['color'] = this.color;
    data['isSelected'] = this.isSelected;
    data['paperName'] = this.paperName;
    data['selectedName'] = this.selectedName;
    data['selectedUserID'] = this.selectedUserID;
    if (this.papers != null) {
      data['papers'] = this.papers!.map((v) => v.toJson()).toList();
    }
    data['createDate'] = this.createDate;
    data['sortOrder'] = this.sortOrder;
    return data;
  }
}