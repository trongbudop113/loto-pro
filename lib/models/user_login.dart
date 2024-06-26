import 'package:intl/intl.dart';

class UserLogin {
  String? email;
  String? name;
  int? lastSignInTime;
  String? avatar;
  int? createTime;
  String? keyName;
  String? uuid;
  int? updateTime;
  bool? isAdmin;
  String? phoneNumber;
  String? address;

  List<String>? listPaper;

  String? joinRoomID;

  String get loginDate {
    var dt = DateTime.now();
    if(lastSignInTime != null){
      dt = DateTime.fromMillisecondsSinceEpoch(lastSignInTime!);
    }

    var date = DateFormat('dd/MM/yyyy, hh:mm:ss').format(dt);
    return date;
  }

  UserLogin(
      {this.email,
        this.name,
        this.lastSignInTime,
        this.avatar,
        this.createTime,
        this.keyName,
        this.uuid,
        this.updateTime,
        this.joinRoomID,
        this.listPaper,
        this.isAdmin,
        this.phoneNumber,
        this.address
      });

  UserLogin.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    lastSignInTime = json['lastSignInTime'];
    avatar = json['avatar'];
    createTime = json['createTime'];
    keyName = json['keyName'];
    uuid = json['uuid'];
    updateTime = json['updateTime'];
    joinRoomID = json['joinRoomID'];
    isAdmin = json['isAdmin'];
    address = json['address'];
    if(json['listPaper'] != null){
      listPaper = (json['listPaper'] as List).map((item) => item as String).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = this.email;
    data['name'] = this.name;
    data['lastSignInTime'] = this.lastSignInTime;
    data['avatar'] = this.avatar;
    data['createTime'] = this.createTime;
    data['keyName'] = this.keyName ?? '';
    data['uuid'] = this.uuid ?? '';
    data['updateTime'] = this.updateTime;
    data['joinRoomID'] = this.joinRoomID;
    data['listPaper'] = this.listPaper;
    data['isAdmin'] = this.isAdmin;
    data['address'] = this.address;
    return data;
  }

  Map<String, dynamic> toOrderJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    if(phoneNumber != null){
      data['phone'] = this.phoneNumber;
    }else{
      data['email'] = this.email;
    }
    data['uuid'] = this.uuid ?? '';
    return data;
  }
}