import 'package:loto/page/shopping/moon_cake/models/cake_product.dart';

class OrderMoonCake {
  String? orderCakeID;
  List<ProductOrder> listProduct = [];
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
      {this.orderCakeID,
      this.userName,
      this.phoneNumber,
      this.totalPrice,
      this.discountCode,
      this.discountPrice,
      this.orderDate,
      this.statusOrder,
      this.receiveDate});

  OrderMoonCake.fromJson(Map<String, dynamic> json) {
    orderCakeID = json['order_cake_id'];
    listProduct = json['products'];
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
    data['order_cake_id'] = orderCakeID;
    data['products'] = listProduct;
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

class ProductOrder {
  String? productOrderID;
  List<CakeProduct>? productMoonCakeList;
  CakeProduct? boxCake;
  int quantity = 1;

  int get limitQuantityCanBuy {
    if (boxCake == null) return 0;
    return boxCake!.productType ?? 0;
  }

  int get productType => boxCake == null ? 1 : 2;

  ProductOrder({this.productOrderID, this.productMoonCakeList, this.boxCake});

  ProductOrder.fromJson(Map<String, dynamic> json) {
    productOrderID = json['product_order_id'];
    productMoonCakeList = json['products'];
    boxCake = json['box_cake'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_order_id'] = productOrderID;
    data['products'] = productMoonCakeList;
    data['box_cake'] = boxCake;
    data['quantity'] = quantity;
    return data;
  }
}
