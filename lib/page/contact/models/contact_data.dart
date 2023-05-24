class ContactData {
  String? address;
  String? email;
  String? phone;
  String? content;

  ContactData(
      {this.address,
        this.email,
        this.phone,
        this.content
      });

  ContactData.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    email = json['email'];
    phone = json['phone'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['content'] = this.content;
    return data;
  }
}