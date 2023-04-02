class RoomModel{
  String? adMinID;
  int? roomID;
  String? roomName;
  String? passWordRoom;
  int? createDate;
  List<String>? listUser;

  RoomModel({this.adMinID, this.roomID, this.roomName, this.passWordRoom, this.createDate, this.listUser});

  RoomModel.fromJson(Map<String, dynamic> json) {
    adMinID = json['adMinID'];
    roomID = json['roomID'];
    roomName = json['roomName'];
    passWordRoom = json['passWordRoom'];
    createDate = json['createDate'];
    if(json['listUser'] != null){
      listUser = (json['listUser'] as List).map((item) => item as String).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adMinID'] = this.adMinID;
    data['roomID'] = this.roomID;
    data['roomName'] = this.roomName;
    data['passWordRoom'] = this.passWordRoom;
    data['createDate'] = this.createDate;
    data['listUser'] = this.listUser;
    return data;
  }
}