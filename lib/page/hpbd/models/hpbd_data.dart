class HPBDData {
  String? title;
  List<HPBDContent>? contents;

  HPBDData(
      {this.title,
        this.contents,
      });

  HPBDData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['content'] != null) {
      contents = <HPBDContent>[];
      json['content'].forEach((v) {
        contents?.add(HPBDContent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.contents;
    return data;
  }
}

class HPBDContent {
  String? text;
  int? type;

  HPBDContent(
      {this.text,
        this.type,
      });

  HPBDContent.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    type = json['type'];
  }
}