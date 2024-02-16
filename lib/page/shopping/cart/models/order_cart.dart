import 'package:loto/models/user_login.dart';
import 'package:loto/page/shopping/moon_cake/models/order_moon_cake.dart';

class OrderCart{
  String? orderID;
  List<ProductOrder>? listProductItem;
  double? cartPrice;
  double? discountCart;
  double? totalPrice;
  DateTime? orderTime;
  int? statusOrder;
  UserLogin? userOrder;

  OrderCart({this.statusOrder, this.totalPrice, this.orderTime, this.cartPrice, this.discountCart, this.listProductItem, this.orderID, this.userOrder,});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = this.orderID;
    data['cart_price'] = this.cartPrice;
    data['discount_cart'] = this.discountCart;
    data['total_price'] = this.totalPrice;
    data['order_time'] = this.orderTime;
    data['status_order'] = this.statusOrder;
    if (this.listProductItem != null) {
      data['product_items'] = this.listProductItem!.map((v) => v.toJson()).toList();
    }
    if(this.userOrder != null){
      data['user_order'] = this.userOrder!.toOrderJson();
    }
    return data;
  }
}