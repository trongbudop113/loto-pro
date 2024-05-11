import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loto/page/shopping/moon_cake/models/egg_data.dart';

class CakeProduct {
  String? productID;
  String? productName;
  int? productType;
  List<String>? productImages;
  String? productColor;
  double? productPrice;
  bool? isShow;

  int numberEggs = 1;
  int quantity = 1;

  DateTime? createDate;
  DateTime? updateDate;

  Timestamp get convertCreateDate {
    createDate ??= DateTime.now();
    return Timestamp.fromDate(createDate!);
  }

  Timestamp get convertUpdateDate {
    createDate ??= DateTime.now();
    return Timestamp.fromDate(createDate!);
  }

  CakeProduct(
      {this.productID,
        this.productColor,
        this.productImages,
        this.productName,
        this.productPrice,
        this.productType,
        this.isShow
      });

  CakeProduct.fromJson(Map<String, dynamic> json) {
    productPrice = double.parse(json['product_price'].toString());
    productType = json['product_type'];
    productName = json['product_name'];
    productColor = json['product_color'];
    productImages = json['product_images'].cast<String>();
    productID = json['product_id'];
    isShow = json['is_show'];

    if(json['create_date'] != null){
      createDate = (json['create_date'] as Timestamp).toDate();
    }
    if(json['update_date'] != null){
      updateDate = (json['update_date'] as Timestamp).toDate();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_price'] = productPrice;
    data['product_type'] = productType;
    data['product_name'] = productName;
    data['product_images'] = productImages;
    data['product_id'] = productID;
    data['product_color'] = productColor;
    data['is_show'] = isShow;
    data['number_eggs'] = numberEggs;
    data['quantity_order'] = quantity;

    data['create_date'] = this.convertCreateDate;
    data['update_date'] = this.convertUpdateDate;
    return data;
  }
}