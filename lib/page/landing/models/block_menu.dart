class BlockMenu {
  String? blockID;
  String? blockName;
  int? blockType;
  String? page;
  String? blockIcon;
  bool? isShow;
  bool? isRequireLogin;

  BlockMenu(
      {this.blockID,
        this.blockName,
        this.blockType,
        this.page,
        this.blockIcon,
        this.isShow,
        this.isRequireLogin
      });

  BlockMenu.fromJson(Map<String, dynamic> json) {
    blockID = json['block_id'];
    blockName = json['block_name'];
    blockType = json['block_type'];
    page = json['page'];
    blockIcon = json['block_icon'];
    isShow = json['is_show'];
    isRequireLogin = json['is_require_login'];
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
    return data;
  }
}