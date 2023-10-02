import 'package:loto/page/moon_cake/models/moon_cake_product.dart';

class OrderMoonCake {
  List<MoonCakeProduct>? productList;
  String? userName;
  String? phoneNumber;
  double? totalPrice;
  double? discountPrice;
  String? discountCode;
  int? orderDate;
  int? receiveDate;

  int? statusOrder;

  OrderMoonCake(
      {this.productList,
        this.userName,
        this.phoneNumber,
        this.totalPrice,
        this.discountCode,
        this.discountPrice,
        this.orderDate,
        this.statusOrder,
        this.receiveDate
      });

  OrderMoonCake.fromJson(Map<String, dynamic> json) {
    productList = json['product_price'];
    userName = json['user_name'];
    totalPrice = json['total_price'];
    discountPrice = json['discount_price'];
    discountCode = json['discount_code'];
    orderDate = json['order_date'];
    receiveDate = json['receive_date'];
    statusOrder = json['status_order'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productList;
    data['product_type'] = userName;
    data['product_name'] = totalPrice;
    data['product_image'] = discountPrice;
    data['product_id'] = discountCode;
    data['product_color'] = orderDate;
    data['is_show'] = receiveDate;
    data['number_eggs'] = statusOrder;
    data['number_eggs'] = phoneNumber;
    return data;
  }
}