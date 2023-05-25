class SendContact {
  String? name;
  String? email;
  String? content;
  bool? isRead;
  int? createTime;

  SendContact(
      {this.name,
        this.email,
        this.content,
        this.isRead,
        this.createTime
      });

  SendContact.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    content = json['content'];
    isRead = json['isRead'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['content'] = this.content;
    data['isRead'] = this.isRead;
    data['createTime'] = this.createTime;
    return data;
  }
}