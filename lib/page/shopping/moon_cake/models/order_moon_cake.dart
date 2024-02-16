import 'package:get/get.dart';
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
  List<CakeProduct>? productMoonCakeList;
  CakeProduct? boxCake;
  RxInt quantity = 1.obs;
  int productType = 2;

  int get limitQuantityCanBuy {
    if (boxCake == null) return 0;
    return boxCake!.productType ?? 0;
  }

  double get productPrice {
    if (productType == 2) return (boxCake!.productPrice ?? 0).toDouble();

    double price = 0.0;
    price = price + (boxCake!.productPrice ?? 0).toDouble();

    for (CakeProduct element in (productMoonCakeList ?? [])) {
      price = price + (element.productPrice ?? 0).toDouble();
    }

    return price;
  }

  ProductOrder({this.productMoonCakeList, this.boxCake});

  ProductOrder.fromJson(Map<String, dynamic> json) {
    productMoonCakeList = json['products'];
    boxCake = json['box_cake'];
    productType = json['product_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.productMoonCakeList != null) {
      data['products'] = this.productMoonCakeList!.map((v) => v.toJson()).toList();
    }
    if(this.boxCake != null){
      data['box_cake'] = this.boxCake!.toJson();
    }
    data['quantity'] = quantity.value;
    data['product_type'] = productType;
    return data;
  }
}
