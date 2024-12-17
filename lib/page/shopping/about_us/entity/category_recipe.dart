class CategoryRecipe {
  int? categoryId;
  String? categoryIcon;
  String? categoryName;
  String? categoryColor;

  CategoryRecipe(
      {this.categoryId,
        this.categoryIcon,
        this.categoryName,
        this.categoryColor});

  CategoryRecipe.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryIcon = json['category_icon'];
    categoryName = json['category_name'];
    categoryColor = json['category_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_icon'] = this.categoryIcon;
    data['category_name'] = this.categoryName;
    data['category_color'] = this.categoryColor;
    return data;
  }
}