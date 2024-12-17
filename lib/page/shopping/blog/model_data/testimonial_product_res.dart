import 'package:cloud_firestore/cloud_firestore.dart';

class TestimonialProductRes {
  String? userContent;
  String? userPhone;
  int? rating;
  String? userAvatar;
  String? userName;
  DateTime? createDate;

  Timestamp get convertCreateDate {
    createDate ??= DateTime.now();
    return Timestamp.fromDate(createDate!);
  }

  TestimonialProductRes(
      {this.userContent,
        this.userPhone,
        this.rating,
        this.userAvatar,
        this.userName,
        this.createDate});

  TestimonialProductRes.fromJson(Map<String, dynamic> json) {
    userContent = json['user_content'];
    userPhone = json['user_phone'];
    rating = json['rating'];
    userAvatar = json['user_avatar'];
    userName = json['user_name'];
    if(json['create_date'] != null){
      createDate = (json['create_date'] as Timestamp).toDate();
    }else{
      createDate = DateTime.now();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_content'] = this.userContent;
    data['user_phone'] = this.userPhone;
    data['rating'] = this.rating;
    data['user_avatar'] = this.userAvatar;
    data['user_name'] = this.userName;
    data['create_date'] = this.createDate;
    return data;
  }
}