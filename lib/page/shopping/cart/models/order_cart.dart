import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:loto/models/user_login.dart';
import 'package:loto/page/shopping/moon_cake/models/order_moon_cake.dart';

class OrderCart {
  String? orderID;
  List<ProductOrder>? listProductItem;
  double? cartPrice;
  double? discountCart;
  double? totalPrice;
  DateTime? orderTime;
  int? statusOrder;
  UserLogin? userOrder;
  String? note;

  OrderCart(
      {this.statusOrder,
      this.totalPrice,
      this.orderTime,
      this.cartPrice,
      this.discountCart,
      this.listProductItem,
      this.orderID,
      this.userOrder,
      this.note});

  Timestamp get convertCreateDate {
    orderTime ??= DateTime.now();
    return Timestamp.fromDate(orderTime!);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = this.orderID;
    data['cart_price'] = this.cartPrice;
    data['discount_cart'] = this.discountCart;
    data['total_price'] = this.totalPrice;
    data['order_time'] = this.orderTime;
    data['status_order'] = this.statusOrder;
    data['note'] = this.note;
    if (this.listProductItem != null) {
      data['product_items'] =
          this.listProductItem!.map((v) => v.toJson()).toList();
    }
    if (this.userOrder != null) {
      data['user_order'] = this.userOrder!.toOrderJson();
    }
    return data;
  }

  OrderCart.fromJson(Map<String, dynamic> json) {
    orderID = json['order_id'];
    if(json['cart_price'] != null){
      cartPrice = double.tryParse(json['cart_price'].toString());
    }
    if(json['discount_cart'] != null){
      discountCart = double.tryParse(json['discount_cart'].toString());
    }
    if(json['total_price'] != null){
      totalPrice = double.tryParse(json['total_price'].toString());
    }
    orderTime = (json['order_time'] as Timestamp).toDate();
    statusOrder = json['status_order'];
    note = json['note'];
    if (json['product_items'] != null) {
      listProductItem = <ProductOrder>[];
      json['product_items'].forEach((v) {
        listProductItem!.add(ProductOrder.fromJson(v));
      });
    }
    if (json['user_order'] != null) {
      userOrder = UserLogin.fromJson(json['user_order']);
    }
  }
}

class LsOrderTime{
  List<OrderTime> lsOrderTime = [];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ls_order_time'] = lsOrderTime.map((v) => v.toJson()).toList();
    return data;
  }

  LsOrderTime.fromJson(Map<String, dynamic> json) {
    if (json['ls_order_time'] != null) {
      lsOrderTime = <OrderTime>[];
      json['ls_order_time'].forEach((v) {
        lsOrderTime.add(OrderTime.fromJson(v));
      });

      lsOrderTime.sort((a, b) => (a.orderDateID ?? '').compareTo(b.orderDateID ?? ''));
    }
  }
}

class OrderTime{
  String? orderDateID;
  String? orderDateTitle;
  final List<OrderCart> lisOrderCart = [];

  OrderTime({this.orderDateID, this.orderDateTitle});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_date_id'] = this.orderDateID;
    data['order_date_title'] = this.orderDateTitle;
    return data;
  }

  OrderTime.fromJson(Map<String, dynamic> json) {
    orderDateID = json['order_date_id'];
    orderDateTitle = json['order_date_title'];
  }
}
