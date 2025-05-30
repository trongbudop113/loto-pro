import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/utils.dart';
import 'package:loto/page/profile/order_manager/order_detail_manager/order_detail_manager_controller.dart';
import 'package:loto/page/shopping/cart/items/item_product_no_box.dart';
import 'package:loto/page/shopping/cart/items/item_product_with_box.dart';

class OrderDetailManagerPage extends GetView<OrderDetailManagerController> {
  const OrderDetailManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildAppBar(context),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildBody(){
    return Expanded(
      child: SingleChildScrollView(
        child: Obx((){
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildOrderStatus(),
                const SizedBox(height: 16),
                _buildCustomerInfo(),
                const SizedBox(height: 16),
                _buildPaymentInfo(),
                const SizedBox(height: 16),
                _buildProductsList(),
              ],
            ),
          );
        }),
      ),
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

  Widget _buildTitle() {
    return Obx((){
      return Text(
        "Đơn hàng #${controller.titleAppbar.value}",
        style: const TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      );
    });
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

  Widget _buildOrderStatus() {
    return _buildSection(
      title: "Trạng thái đơn hàng",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(
            "Thời gian đặt:",
            controller.orderCartData.value.orderTime.toString(),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildInfoRow(
                  "Trạng thái:",
                  FormatUtils.formatOrderStatus(
                    controller.statusOrderData.value.statusID ?? 1,
                  ),
                  valueColor: FormatUtils.orderStatusColor(
                    controller.statusOrderData.value.statusID ?? 1,
                  ),
                ),
              ),
              _buildEditStatusButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerInfo() {
    final user = controller.orderCartData.value.userOrder!;
    return _buildSection(
      title: "Thông tin khách hàng",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow("Tên khách hàng:", user.name ?? ''),
          const SizedBox(height: 12),
          _buildInfoRow(
            user.phoneNumber?.isNotEmpty == true ? "Số điện thoại:" : "Email:",
            user.phoneNumber?.isNotEmpty == true ? user.phoneNumber! : user.email ?? '',
          ),
          const SizedBox(height: 12),
          _buildInfoRow("Địa chỉ:", user.address ?? ''),
        ],
      ),
    );
  }

  Widget _buildPaymentInfo() {
    final order = controller.orderCartData.value;
    return _buildSection(
      title: "Thông tin thanh toán",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(
            "Tạm tính:",
            FormatUtils.formatCurrency(order.cartPrice ?? 0),
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            "Giảm giá:",
            FormatUtils.formatCurrency(order.discountCart ?? 0),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1),
          ),
          _buildInfoRow(
            "Tổng tiền:",
            FormatUtils.formatCurrency(order.totalPrice ?? 0),
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
            valueStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF8E25),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsList() {
    return _buildSection(
      title: "Danh sách sản phẩm",
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.orderCartData.value.listProductItem?.length ?? 0,
        separatorBuilder: (c, i) => const SizedBox(height: 12),
        itemBuilder: (c, i) {
          final item = controller.orderCartData.value.listProductItem![i];
          return item.productType == 1
              ? ItemProductWithBox(
                  productItem: item,
                  itemModel: ItemMode.view,
                )
              : ItemProductNoBox(
                  productItem: item,
                  itemMode: ItemMode.view,
                );
        },
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value, {
    Color? valueColor,
    TextStyle? labelStyle,
    TextStyle? valueStyle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: labelStyle ??
              const TextStyle(
                fontSize: 15,
                color: Color(0xFF666666),
              ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: valueStyle ??
                TextStyle(
                  fontSize: 15,
                  color: valueColor ?? const Color(0xFF333333),
                  fontWeight: valueColor != null ? FontWeight.w600 : null,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildEditStatusButton() {
    return Material(
      color: FormatUtils.orderStatusColor(
        controller.statusOrderData.value.statusID ?? 1,
      ),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: () => controller.onChangeStatusOrder(Get.context!),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          child: const Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
