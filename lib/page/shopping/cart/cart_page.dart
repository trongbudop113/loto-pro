import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/cart/cart_controller.dart';
import 'package:loto/page/shopping/cart/items/item_product_no_box.dart';
import 'package:loto/page/shopping/cart/items/item_product_with_box.dart';
import 'package:loto/src/style_resource.dart';
import 'package:lottie/lottie.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Giỏ hàng"),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: 55,
            child: Icon(Icons.arrow_back),
            color: Colors.transparent,
          ),
        ),
        actions: [
          Obx(() => Visibility(
            visible: controller.currentProductInCart.isNotEmpty,
            child: GestureDetector(
              onTap: (){
                controller.onRemoveAllCart();
              },
              child: Container(
                width: 55,
                alignment: Alignment.center,
                child: Icon(Icons.delete),
                color: Colors.transparent,
              ),
            ),
          )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() => Visibility(
              visible: controller.currentProductInCart.isNotEmpty,
              replacement: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: Lottie.asset(
                      'assets/cart_empty.json',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Chưa có sản phẩm trong giỏ hàng",
                    style: TextStyleResource.textStyleBlack(context).copyWith(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
              child: ListView.separated(
                padding: EdgeInsets.all(15),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (c, i) {
                  return Visibility(
                    visible:
                    controller.currentProductInCart[i].productType == 1,
                    replacement: ItemProductNoBox(
                      productItem: controller.currentProductInCart[i],
                      controller: controller,
                    ),
                    child: ItemProductWithBox(
                      productItem: controller.currentProductInCart[i],
                      controller: controller,
                    ),
                  );
                },
                separatorBuilder: (c, i) {
                  return Container(height: 15);
                },
                itemCount: controller.currentProductInCart.length,
              ),
            )),
            Container(
              height: 2,
              color: Colors.black,
            ),
            Obx(() => Visibility(
              visible: controller.currentProductInCart.isNotEmpty,
              child: Container(
                margin: EdgeInsets.only(
                  right: 15,
                  top: 20,
                  bottom: 20,
                ),
                child: Column(
                  children: [
                    _buildRowPrice(context, title: "Tạm tính", price: 0),
                    SizedBox(
                      height: 15,
                    ),
                    _buildRowPrice(context, title: "Giảm giá", price: 0),
                    SizedBox(
                      height: 15,
                    ),
                    Obx(() => _buildRowPrice(
                      context,
                      title: "Tổng tiền",
                      price: controller.finalPrice.value,
                    )),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: GestureDetector(
          onTap: (){
            controller.onTapOrder();
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(60),
            ),
            alignment: Alignment.center,
            child: Text("Đặt hàng"),
          ),
        ),
      ),
    );
  }

  Widget _buildRowPrice(BuildContext context,
      {required String title, required double price}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '$title:',
          style: TextStyleResource.textStyleBlack(context),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: Get.width * 0.3,
          child: Text(
            controller.formatCurrency(price),
            textAlign: TextAlign.end,
            style: TextStyleResource.textStyleBlack(context),
          ),
        ),
      ],
    );
  }
}
