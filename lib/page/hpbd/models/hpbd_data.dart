class HPBDData {
  String? id;
  String? title;
  List<HPBDContent>? contents;
  String? image;
  String? contentGif;

  HPBDData(
      {this.title,
        this.contents,
        this.image,
        this.id,
        this.contentGif
      });

  HPBDData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    id = json['id'];
    contentGif = json['content_gif'];
    if (json['content'] != null) {
      contents = <HPBDContent>[];
      json['content'].forEach((v) {
        contents?.add(HPBDContent.fromJson(v));
      });
    }
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