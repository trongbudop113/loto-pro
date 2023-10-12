class ChatContentData {
  String? fromId;
  String? toId;
  String? content;
  int? type;
  int? timestamp;

  ChatContentData(
      {this.fromId, this.toId, this.content, this.type, this.timestamp});

  ChatContentData.fromJson(Map<String, dynamic> json) {
    fromId = json['from_id'];
    toId = json['to_id'];
    content = json['content'];
    type = json['type'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['from_id'] = this.fromId;
    data['to_id'] = this.toId;
    data['content'] = this.content;
    data['type'] = this.type;
    data['timestamp'] = this.timestamp;
    return data;
  }
}