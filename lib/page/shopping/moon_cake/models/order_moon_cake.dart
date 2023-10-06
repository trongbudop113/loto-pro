import 'package:loto/page/shopping/moon_cake/models/cake_product.dart';

class OrderMoonCake {
  List<CakeProduct>? productMoonCakeList;
  CakeProduct? boxCake;
  String? userName;
  String? phoneNumber;
  double? totalPrice;
  double? discountPrice;
  String? discountCode;
  int? orderDate;
  int? receiveDate;
  int? typeOrder;

  int? statusOrder;

  OrderMoonCake(
      {this.productMoonCakeList,
        this.boxCake,
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
    productMoonCakeList = json['products'];
    boxCake = json['box_cake'];
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
    data['products'] = productMoonCakeList;
    data['box_cake'] = boxCake;
    data['user_name'] = userName;
    data['total_price'] = totalPrice;
    data['discount_price'] = discountPrice;
    data['discount_code'] = discountCode;
    data['order_date'] = orderDate;
    data['receive_date'] = receiveDate;
    data['status_order'] = statusOrder;
    data['phone_number'] = phoneNumber;
    return data;
  }
}