import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/utils.dart';
import 'package:loto/page/shopping/cart/models/order_cart.dart';
import 'package:loto/page/shopping/view_order/view_order_controller.dart';

class ViewOrderPage extends GetView<ViewOrderController> {
  const ViewOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1440, minWidth: 600),
          child: LayoutBuilder(
            builder: (c, constraint) {
              return Column(
                children: [
                  _buildAppBar(context),
                  _buildBody(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFFFF8E25),
            ),
          );
        }

        if (controller.listOrderTime.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  size: 64,
                  color: Colors.grey.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  "Chưa có đơn hàng nào",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: controller.listOrderTime.length,
          itemBuilder: (BuildContext context, int index) {
            var orderTimeItem = controller.listOrderTime[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF7A00), Color(0xFFFF8E25)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Đơn ngày ${orderTimeItem.orderDateTitle ?? ''}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListView.separated(
                    itemCount: orderTimeItem.lisOrderCart.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (c, x) {
                      OrderCart item = orderTimeItem.lisOrderCart[x];
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            controller.goToOrderDetail(
                              item,
                              orderTimeItem.orderDateID ?? '',
                            );
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: _buildOrderCard(item),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF7A00), Color(0xFFFF8E25),],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 97,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildMenuButton(),
            _buildTitle(),
            const SizedBox(width: 77, height: 44),
          ],
        ),
      ),
    );
  }

  Text _buildTitle() {
    return const Text(
      "Đơn hàng của tôi",
      style: TextStyle(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildMenuButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Get.back();
        },
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: 70,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white.withOpacity(0.2),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard(OrderCart order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: const BoxDecoration(
              color: Color(0xFFFF8E25),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Đơn hàng #${order.orderID}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    FormatUtils.formatOrderStatus(order.statusOrder ?? 1),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFFF8E25),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow("Ngày đặt:", order.orderTime.toString()),
                const SizedBox(height: 12),
                _buildInfoRow("Địa chỉ:", order.userOrder?.address ?? ''),
                const SizedBox(height: 12),
                _buildInfoRow("Số điện thoại:", order.userOrder?.phoneNumber ?? ''),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(height: 1),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: order.listProductItem?.length ?? 0,
                  separatorBuilder: (c, i) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = (order.listProductItem ?? [])[index];
                    return Row(
                      children: [
                        Text(
                          "${item.quantity}x",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFF666666),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            item.boxCake?.productName ?? '',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ),
                        Text(
                          controller.formatCurrency(item.boxCake?.productPrice ?? 0),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFFF8E25),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(height: 1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Tổng tiền:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    Text(
                      controller.formatCurrency(order.totalPrice ?? 0),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF8E25),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF666666),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF333333),
            ),
          ),
        ),
      ],
    );
  }
}