import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/utils.dart';
import 'package:loto/models/user_login.dart';
import 'package:loto/page/profile/order_manager/order_detail_manager/order_detail_manager_controller.dart';
import 'package:loto/page/shopping/cart/items/item_product_no_box.dart';
import 'package:loto/page/shopping/cart/items/item_product_with_box.dart';
import 'package:loto/page/shopping/cart/models/order_cart.dart';
import 'package:loto/page/shopping/moon_cake/models/order_moon_cake.dart';
import 'package:loto/src/style_resource.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              _orderStatusWidget(
                context,
                orderCart: controller.orderCartData.value,
              ),
              SizedBox(
                height: 20,
              ),
              _orderUserWidget(
                context,
                user: controller.orderCartData.value.userOrder!,
              ),
              SizedBox(
                height: 20,
              ),
              _orderPaymentWidget(
                context,
                orderCart: controller.orderCartData.value,
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
            ],
          );
        }),
      ),
    );
  }

  Widget _orderUserWidget(BuildContext context, {required UserLogin user}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Khách hàng:",
            style: TextStyleResource.textStyleBlack(context).copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Tên KH: ${user.name ?? ''}",
            style: TextStyleResource.textStyleBlack(context),
          ),
          SizedBox(
            height: 10,
          ),
          Visibility(
            visible: (user.phoneNumber ?? '').isNotEmpty,
            replacement: Text(
              "Email: ${user.email ?? ''}",
              style: TextStyleResource.textStyleBlack(context),
            ),
            child: Text(
              "SĐT: ${user.phoneNumber ?? ''}",
              style: TextStyleResource.textStyleBlack(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _orderPackageWidget(
    BuildContext context, {
    required List<ProductOrder> listProductItem,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sản phẩm:",
            style: TextStyleResource.textStyleBlack(context).copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListView.separated(
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
          ),
        ],
      ),
    );
  }

  Widget _orderStatusWidget(
    BuildContext context, {
    required OrderCart orderCart,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Trạng thái:",
            style: TextStyleResource.textStyleBlack(context).copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Thời gian đặt hàng: ${orderCart.orderTime ?? 0}",
            style: TextStyleResource.textStyleBlack(context),
          ),
          SizedBox(
            height: 10,
          ),
          Obx((){
            return Row(
              children: [
                Text(
                  "Trạng thái: ",
                  style: TextStyleResource.textStyleBlack(context),
                ),
                Text(
                  FormatUtils.formatOrderStatus(controller.statusOrderData.value.statusID ?? 1),
                  style: TextStyleResource.textStyleBlack(context).copyWith(
                    color: FormatUtils.orderStatusColor(controller.statusOrderData.value.statusID ?? 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(flex: 1,),
                GestureDetector(
                  onTap: (){
                    controller.onChangeStatusOrder(context);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    color: FormatUtils.orderStatusColor(controller.statusOrderData.value.statusID ?? 1),
                    child: const Icon(Icons.edit, color: Colors.black,),
                  ),
                )
              ],
            );
          })
        ],
      ),
    );
  }

  Widget _orderPaymentWidget(
    BuildContext context, {
    required OrderCart orderCart,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Thanh toán:",
            style: TextStyleResource.textStyleBlack(context).copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Tạm tính: ${FormatUtils.formatCurrency(orderCart.cartPrice ?? 0)}",
            style: TextStyleResource.textStyleBlack(context),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Giảm giá: ${FormatUtils.formatCurrency(orderCart.discountCart ?? 0)}",
            style: TextStyleResource.textStyleBlack(context),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Tổng tiền: ${FormatUtils.formatCurrency(orderCart.totalPrice ?? 0)}",
            style: TextStyleResource.textStyleBlack(context),
          ),
        ],
      ),
    );
  }
}
