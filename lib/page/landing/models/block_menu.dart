import 'package:cloud_firestore/cloud_firestore.dart';

class BlockMenu {
  String? blockID;
  String? blockName;
  int? blockType;
  String? page;
  String? blockIcon;
  bool? isShow;
  bool? isRequireLogin;
  String? documentID;
  String? image;

  DateTime? createDate;
  DateTime? updateDate;

  Timestamp get convertCreateDate {
    createDate ??= DateTime.now();
    return Timestamp.fromDate(createDate!);
  }

  Timestamp get convertUpdateDate {
    createDate ??= DateTime.now();
    return Timestamp.fromDate(createDate!);
  }

  BlockMenu(
      {this.blockID,
        this.blockName,
        this.blockType,
        this.page,
        this.blockIcon,
        this.isShow,
        this.isRequireLogin,
        this.documentID,
        this.image
      });

  BlockMenu.fromJson(Map<String, dynamic> json) {
    blockID = json['block_id'];
    blockName = json['block_name'];
    blockType = json['block_type'];
    page = json['page'];
    blockIcon = json['block_icon'];
    isShow = json['is_show'];
    isRequireLogin = json['is_require_login'];
    documentID = json['document_id'];
    image = json['image'];
    if(json['create_date'] != null){
      createDate = (json['create_date'] as Timestamp).toDate();
    }
    if(json['update_date'] != null){
      updateDate = (json['update_date'] as Timestamp).toDate();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['block_id'] = this.blockID;
    data['block_name'] = this.blockName;
    data['block_type'] = this.blockType;
    data['page'] = this.page;
    data['block_icon'] = this.blockIcon;
    data['is_show'] = this.isShow;
    data['is_require_login'] = this.isRequireLogin;
    data['document_id'] = this.documentID;
    data['image'] = this.image;
    data['create_date'] = this.convertCreateDate;
    data['update_date'] = this.convertUpdateDate;
    return data;
  }
}