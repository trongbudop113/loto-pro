import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/common.dart';
import 'package:loto/page/shopping/cart/cart_controller.dart';
import 'package:loto/page/shopping/cart/items/item_product_no_box.dart';
import 'package:loto/page/shopping/cart/items/item_product_with_box.dart';
import 'package:loto/src/color_resource.dart';

import '../moon_cake/models/order_moon_cake.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<ProductOrder> currentProductInCart =
        AppCommon.singleton.currentProductInCart;

    return Scaffold(
      appBar: AppBar(
        title: Text("Giỏ hàng"),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(15),
        itemBuilder: (c, i) {
          return Container(
            decoration: BoxDecoration(
              color: ColorResource.color_main_light,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: EdgeInsets.all(10),
            child: Visibility(
              visible: currentProductInCart[i].productType == 1,
              replacement: ItemProductNoBox(
                productItem: currentProductInCart[i],
              ),
              child: ItemProductWithBox(
                productItem: currentProductInCart[i],
              ),
            ),
          );
        },
        separatorBuilder: (c, i) {
          return Container(height: 15);
        },
        itemCount: currentProductInCart.length,
      ),
    );
  }
}
