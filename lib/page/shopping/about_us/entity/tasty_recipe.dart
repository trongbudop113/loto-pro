class TastyRecipes {
  int? id;
  String? image;
  String? name;
  int? type;
  String? categoryName;
  int? categoryId;
  int? time;
  bool? isLike;

  TastyRecipes(
      {this.id,
        this.image,
        this.name,
        this.type,
        this.categoryName,
        this.categoryId,
        this.time,
        this.isLike});

  TastyRecipes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    type = json['type'];
    categoryName = json['category_name'];
    categoryId = json['category_id'];
    time = json['time'];
    isLike = json['is_like'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['type'] = this.type;
    data['category_name'] = categoryName;
    data['category_id'] = categoryId;
    data['time'] = this.time;
    data['is_like'] = this.isLike;
    return data;
  }
}