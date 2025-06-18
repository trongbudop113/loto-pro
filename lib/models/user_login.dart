import 'package:intl/intl.dart';
import 'package:loto/models/membership_tier.dart';

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

  // Membership fields
  int? membershipPoints;
  String? membershipLevel;
  int? totalSpent;
  int? totalOrders;
  int? membershipJoinDate;

  // Collected vouchers
  List<String>? collectedVouchers;

  String get loginDate {
    var dt = DateTime.now();
    if(lastSignInTime != null){
      dt = DateTime.fromMillisecondsSinceEpoch(lastSignInTime!);
    }

    var date = DateFormat('dd/MM/yyyy, hh:mm:ss').format(dt);
    return date;
  }

  // Membership getters
  MembershipTier get membershipTier {
    return MembershipTierExtension.fromPoints(membershipPoints ?? 0);
  }

  String get membershipDisplayName {
    return membershipTier.displayName;
  }

  String get membershipIcon {
    return membershipTier.icon;
  }

  int get membershipColor {
    return membershipTier.color;
  }

  int get pointsToNextTier {
    final currentTier = membershipTier;
    final currentPoints = membershipPoints ?? 0;
    
    switch (currentTier) {
      case MembershipTier.bronze:
        return MembershipTier.silver.requiredPoints - currentPoints;
      case MembershipTier.silver:
        return MembershipTier.gold.requiredPoints - currentPoints;
      case MembershipTier.gold:
        return MembershipTier.platinum.requiredPoints - currentPoints;
      case MembershipTier.platinum:
        return 0; // Already at highest tier
    }
  }

  String get membershipJoinDateFormatted {
    if (membershipJoinDate == null) return '';
    var dt = DateTime.fromMillisecondsSinceEpoch(membershipJoinDate!);
    return DateFormat('dd/MM/yyyy').format(dt);
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
        this.address,
        this.membershipPoints,
        this.membershipLevel,
        this.totalSpent,
        this.totalOrders,
        this.membershipJoinDate,
        this.collectedVouchers
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
    membershipPoints = json['membershipPoints'] ?? 0;
    membershipLevel = json['membershipLevel'];
    totalSpent = json['totalSpent'] ?? 0;
    totalOrders = json['totalOrders'] ?? 0;
    membershipJoinDate = json['membershipJoinDate'];
    if(json['listPaper'] != null){
      listPaper = (json['listPaper'] as List).map((item) => item as String).toList();
    }
    if(json['collectedVouchers'] != null){
      collectedVouchers = (json['collectedVouchers'] as List).map((item) => item as String).toList();
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
    data['membershipPoints'] = this.membershipPoints;
    data['membershipLevel'] = this.membershipLevel;
    data['totalSpent'] = this.totalSpent;
    data['totalOrders'] = this.totalOrders;
    data['membershipJoinDate'] = this.membershipJoinDate;
    data['collectedVouchers'] = this.collectedVouchers;
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