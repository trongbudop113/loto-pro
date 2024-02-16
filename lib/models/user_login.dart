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

  List<String>? listPaper;

  String? joinRoomID;

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
        this.phoneNumber
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
    if(json['listPaper'] != null){
      listPaper = (json['listPaper'] as List).map((item) => item as String).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    return data;
  }

  Map<String, dynamic> toOrderJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phoneNumber;
    data['uuid'] = this.uuid ?? '';
    return data;
  }
}