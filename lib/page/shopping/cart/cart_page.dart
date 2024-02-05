import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/cart/cart_controller.dart';
import 'package:loto/page/shopping/cart/items/item_product_with_box.dart';
import 'package:loto/src/color_resource.dart';
import 'package:loto/src/style_resource.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text("Giỏ hàng")
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(15),
        itemBuilder: (c, i){
          return Container(
            decoration: BoxDecoration(
              color: ColorResource.color_main_light
            ),
            padding: EdgeInsets.all(10),
            child: ItemProductWithBox(),
          );
        },
        separatorBuilder: (c, i){
          return Container(height: 15);
        },
        itemCount: 5
      ),
    );
  }
}