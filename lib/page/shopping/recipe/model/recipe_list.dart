class RecipeList {
  List<ListCake>? listCake;

  RecipeList({this.listCake});

  RecipeList.fromJson(Map<String, dynamic> json) {
    if (json['listCake'] != null) {
      listCake = <ListCake>[];
      json['listCake'].forEach((v) {
        listCake!.add(new ListCake.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listCake != null) {
      data['listCake'] = this.listCake!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListCake {
  String? name;
  List<int>? include;
  int? relateID;

  ListCake({this.name, this.include, this.relateID});

  ListCake.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    include = json['include'].cast<int>();
    relateID = json['relateID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['include'] = this.include;
    data['relateID'] = this.relateID;
    return data;
  }
}