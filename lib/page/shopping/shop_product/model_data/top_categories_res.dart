import 'package:get/get.dart';

class TopCategoriesRes {
  List<LsCategory>? lsCategory;

  TopCategoriesRes({this.lsCategory});

  TopCategoriesRes.fromJson(Map<String, dynamic> json) {
    if (json['ls_category'] != null) {
      lsCategory = <LsCategory>[];
      json['ls_category'].forEach((v) {
        lsCategory!.add(LsCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (lsCategory != null) {
      data['ls_category'] = lsCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LsCategory {
  int? categoryId;
  String? categoryImage;
  String? categoryName;
  int? categoryType;

  final RxBool isSelected = false.obs;

  LsCategory(
      {this.categoryId,
        this.categoryImage,
        this.categoryName,
        this.categoryType});

  LsCategory.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryImage = json['category_image'];
    categoryName = json['category_name'];
    categoryType = json['category_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['category_image'] = categoryImage;
    data['category_name'] = categoryName;
    data['category_type'] = categoryType;
    return data;
  }
}