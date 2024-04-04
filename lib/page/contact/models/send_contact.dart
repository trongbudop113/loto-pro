import 'package:cloud_firestore/cloud_firestore.dart';

class SendContact {
  String? name;
  String? email;
  String? content;
  bool? isRead;
  DateTime? createTime;

  SendContact(
      {this.name,
        this.email,
        this.content,
        this.isRead,
        this.createTime
      });

  Timestamp get convertCreateDate {
    createTime ??= DateTime.now();
    return Timestamp.fromDate(createTime!);
  }

  SendContact.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    content = json['content'];
    isRead = json['isRead'];
    if(json['createTime'] != null){
      createTime = (json['createTime'] as Timestamp).toDate();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = this.email;
    data['name'] = this.name;
    data['content'] = this.content;
    data['isRead'] = this.isRead;
    data['createTime'] = this.createTime;
    return data;
  }
}