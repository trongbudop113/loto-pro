import 'package:loto/page/shopping/moon_cake/models/egg_data.dart';

class CakeProduct {
  String? productID;
  String? productName;
  int? productType;
  String? productImage;
  String? productColor;
  double? productPrice;
  bool? isShow;

  int numberEggs = 1;
  int quantity = 1;

  CakeProduct(
      {this.productID,
        this.productColor,
        this.productImage,
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
    productImage = json['product_image'];
    productID = json['product_id'];
    isShow = json['is_show'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_price'] = productPrice;
    data['product_type'] = productType;
    data['product_name'] = productName;
    data['product_image'] = productImage;
    data['product_id'] = productID;
    data['product_color'] = productColor;
    data['is_show'] = isShow;
    data['number_eggs'] = numberEggs;
    data['quantity_order'] = quantity;
    return data;
  }
}