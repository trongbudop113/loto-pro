import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/models/user_login.dart';
import 'package:loto/page/profile/order_manager/order_detail_manager/order_detail_manager_controller.dart';
import 'package:loto/page/shopping/cart/items/item_product_no_box.dart';
import 'package:loto/page/shopping/cart/items/item_product_with_box.dart';
import 'package:loto/page/shopping/cart/models/order_cart.dart';
import 'package:loto/page/shopping/moon_cake/models/order_moon_cake.dart';
import 'package:loto/src/style_resource.dart';

class OrderDetailManagerPage extends GetView<OrderDetailManagerController> {
  const OrderDetailManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text("ĐH: ${controller.titleAppbar.value}")),
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          return Column(
            children: [
              _orderUserWidget(
                context,
                user: controller.orderCartData.value.userOrder!,
              ),
              SizedBox(
                height: 20,
              ),
              _orderPackageWidget(
                context,
                listProductItem:
                    controller.orderCartData.value.listProductItem ?? [],
              ),
              SizedBox(
                height: 20,
              ),
              _orderPaymentWidget(
                context,
                orderCart: controller.orderCartData.value,
              )
            ],
          );
        }),
      ),
    );
  }

  Widget _orderUserWidget(BuildContext context, {required UserLogin user}) {
    return Column(
      children: [
        Text(
          "Khách hàng:",
          style: TextStyleResource.textStyleBlack(context),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          user.name ?? '',
          style: TextStyleResource.textStyleBlack(context),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          user.phoneNumber ?? '',
          style: TextStyleResource.textStyleBlack(context),
        ),
      ],
    );
  }

  Widget _orderPackageWidget(BuildContext context,
      {required List<ProductOrder> listProductItem}) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listProductItem.length,
      itemBuilder: (c, i) {
        if (listProductItem[i].productType == 1) {
          return ItemProductWithBox(
            productItem: listProductItem[i],
            itemModel: ItemMode.view,
          );
        }
        return ItemProductNoBox(
          productItem: listProductItem[i],
          itemMode: ItemMode.view,
        );
      },
      separatorBuilder: (c, i) {
        return SizedBox(
          height: 10,
        );
      },
    );
  }

  Widget _orderPaymentWidget(BuildContext context,
      {required OrderCart orderCart}) {
    return Column(
      children: [
        Text(
          "Thanh toán:",
          style: TextStyleResource.textStyleBlack(context),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Tạm tính: ${orderCart.cartPrice ?? 0}",
          style: TextStyleResource.textStyleBlack(context),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Giảm giá: ${orderCart.discountCart}",
          style: TextStyleResource.textStyleBlack(context),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Tổng tiền: ${orderCart.totalPrice}",
          style: TextStyleResource.textStyleBlack(context),
        ),
      ],
    );
  }
}
