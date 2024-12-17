import 'package:cloud_firestore/cloud_firestore.dart';

class CakeProduct {
  String? productID;
  String? productName;
  int? productType;
  List<String>? productImages;
  String? productColor;
  double? productPrice;
  String? productDescription;
  double? productDiscount;
  bool? isShow;
  int? sortOrder;
  int? limitCart;

  int? productCategory;
  bool? isFeature;

  int numberEggs = 1;
  int quantity = 1;

  DateTime? createDate;
  DateTime? updateDate;

  String get productImageMain {
    if ((productImages ?? []).isEmpty) return '';
    return productImages!.first;
  }

  Timestamp get convertCreateDate {
    createDate ??= DateTime.now();
    return Timestamp.fromDate(createDate!);
  }

  Timestamp get convertUpdateDate {
    createDate ??= DateTime.now();
    return Timestamp.fromDate(createDate!);
  }

  CakeProduct({
    this.productID,
    this.productColor,
    this.productImages,
    this.productName,
    this.productPrice,
    this.productType,
    this.isShow,
    this.sortOrder,
    this.isFeature,
    this.productCategory,
    this.limitCart,
  });

  CakeProduct.fromJson(Map<String, dynamic> json) {
    productPrice = double.parse(json['product_price'].toString());
    productDiscount = json['product_discount'];
    productType = json['product_type'];
    productName = json['product_name'];
    productColor = json['product_color'];
    productDescription = json['product_description'];
    isFeature = json['is_feature'];
    productCategory = json['product_category'];
    limitCart = json['limit_cart'];
    if (json['product_images'] != null) {
      productImages = json['product_images'].cast<String>();
    }
    productID = json['product_id'];
    isShow = json['is_show'];
    sortOrder = json['sort_order'];

    if (json['create_date'] != null) {
      createDate = (json['create_date'] as Timestamp).toDate();
    }
    if (json['update_date'] != null) {
      updateDate = (json['update_date'] as Timestamp).toDate();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_price'] = productPrice;
    data['product_discount'] = productDiscount;
    data['product_type'] = productType;
    data['product_name'] = productName;
    data['product_images'] = productImages;
    data['product_id'] = productID;
    data['product_color'] = productColor;
    data['is_show'] = isShow;
    data['number_eggs'] = numberEggs;
    data['quantity_order'] = quantity;
    data['product_description'] = productDescription;
    data['limit_cart'] = limitCart;

    data['create_date'] = convertCreateDate;
    data['update_date'] = convertUpdateDate;
    return data;
  }
}
