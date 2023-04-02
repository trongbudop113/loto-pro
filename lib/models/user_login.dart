class UserLogin {
  String? email;
  String? name;
  int? lastSignInTime;
  String? avatar;
  int? createTime;
  String? keyName;
  String? uuid;
  int? updateTime;

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
        this.joinRoomID
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['lastSignInTime'] = this.lastSignInTime;
    data['avatar'] = this.avatar;
    data['createTime'] = this.createTime;
    data['keyName'] = this.keyName;
    data['uuid'] = this.uuid;
    data['updateTime'] = this.updateTime;
    data['joinRoomID'] = this.joinRoomID;
    return data;
  }
}