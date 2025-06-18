import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/cart/cart_controller.dart';
import 'package:loto/page/shopping/cart/items/item_product_no_box.dart';
import 'package:loto/page/shopping/cart/items/item_product_with_box.dart';
import 'package:loto/page/shopping/cart/layout/confirm_delete_cart_layout.dart';
import 'package:loto/src/style_resource.dart';
import 'package:lottie/lottie.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width > 1440
        ? 1440
        : MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => Visibility(
            visible: controller.currentProductInCart.isNotEmpty,
            replacement: SizedBox(
              width: double.infinity,
              child: _buildEmptyCart(context),
            ),
            child: width > 1000
                ? Row(
                    children: [
                      Container(
                        width: width * .5,
                        alignment: Alignment.topCenter,
                        child: _buildListProduct(context, isScroll: true),
                      ),
                      Container(
                        width: (width * .5) - 10,
                        alignment: Alignment.topCenter,
                        child:
                            _buildPayment(context, isWeb: true, width: width),
                      )
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildDeleteCart(context),
                        _buildListProduct(context, isScroll: true),
                        Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        _buildPayment(context, isWeb: false, width: width),
                      ],
                    ),
                  ),
          )),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFF8E25).withOpacity(0.05),
            const Color(0xFFFFB067).withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(150),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF8E25).withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Lottie.asset(
              'assets/cart_empty.json',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF8E25).withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              "Chưa có sản phẩm trong giỏ hàng",
              style: TextStyleResource.textStyleBlack(context).copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFFF8E25),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeleteCart(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.dialog(
          Dialog(
            backgroundColor: Colors.transparent,
            child: ConfirmDeleteCartLayout(
              controller: controller,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF8E25), Color(0xFFFFB067)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF8E25).withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete_forever_outlined, size: 24, color: Colors.white),
            SizedBox(width: 12),
            Text(
              "Xóa tất cả",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPayment(BuildContext context,
      {required bool isWeb, required double width}) {
    return Obx(() => Visibility(
          visible: controller.currentProductInCart.isNotEmpty,
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF8E25).withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Thanh Toán",
                  style: TextStyleResource.textStyleBlack(context).copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFF8E25),
                  ),
                ),
                const SizedBox(height: 24),
                _buildVoucherSection(context),
                const SizedBox(height: 16),
                Obx(() => _buildRowPrice(
                      context,
                      title: "Tạm tính",
                      price: controller.cartPrice.value,
                      isWeb: isWeb,
                      width: width,
                    )),
                const SizedBox(height: 16),
                Obx(() => _buildRowPrice(
                      context,
                      title: "Giảm giá",
                      price: controller.discountAmount.value,
                      isWeb: isWeb,
                      width: width,
                    )),
                const SizedBox(height: 16),
                Container(
                  height: 1,
                  color: const Color(0xFFFF8E25).withOpacity(0.1),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                ),
                Obx(() => _buildRowPrice(
                      context,
                      title: "Tổng tiền",
                      price: controller.finalPrice.value,
                      isWeb: isWeb,
                      width: width,
                    )),
                const SizedBox(height: 24),
                _buildNote(context),
              ],
            ),
          ),
        ));
  }

  Widget _buildBottomBar(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: Colors.transparent,
      child: Obx(() => Visibility(
            visible: controller.currentProductInCart.isNotEmpty,
            child: GestureDetector(
              onTap: () => controller.onTapOrder(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF8E25), Color(0xFFFFB067)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(38),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF8E25).withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  "Đặt hàng",
                  style: TextStyleResource.textStyleBlack(context).copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )),
    );
  }

  Widget _buildVoucherSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFFF8E25).withOpacity(0.3),
        ),
      ),
      child: ListTile(
        leading: Icon(
          Icons.local_offer,
          color: const Color(0xFFFF8E25),
        ),
        title: Obx(() => Text(
              controller.selectedVoucher.value != null
                  ? controller.selectedVoucher.value!.name
                  : 'Chọn voucher',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: controller.selectedVoucher.value != null
                    ? const Color(0xFFFF8E25)
                    : Colors.grey[600],
              ),
            )),
        subtitle: Obx(() => controller.selectedVoucher.value != null
            ? Text(
                'Giảm ${controller.selectedVoucher.value!.discountText}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.green[600],
                ),
              )
            : const Text(
                'Nhấn để chọn voucher',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              )),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Color(0xFFFF8E25),
        ),
        onTap: () => controller.showVoucherSelectionDialog(),
      ),
    );
  }

  Widget _buildNote(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF8E25).withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        minLines: 6,
        maxLines: null,
        controller: controller.textNoteController,
        keyboardType: TextInputType.multiline,
        style: TextStyleResource.textStyleGrey(context).copyWith(
          fontSize: 16,
        ),
        decoration: InputDecoration(
          alignLabelWithHint: true,
          labelText: 'Ghi chú',
          labelStyle: TextStyle(
            color: const Color(0xFFFF8E25).withOpacity(0.8),
            fontSize: 16,
          ),
          contentPadding: const EdgeInsets.all(20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: const Color(0xFFFF8E25).withOpacity(0.2),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: const Color(0xFFFF8E25).withOpacity(0.2),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFFFF8E25),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListProduct(BuildContext context, {required bool isScroll}) {
    return ListView.separated(
      padding: const EdgeInsets.all(15),
      shrinkWrap: true,
      physics: isScroll
          ? const BouncingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      itemBuilder: (c, i) {
        controller.currentProductInCart[i].onTapPlus = () {
          controller.onTapPlus(controller.currentProductInCart[i]);
        };

        controller.currentProductInCart[i].onTapSubtract = () {
          controller.onTapSubtract(controller.currentProductInCart[i]);
        };

        controller.currentProductInCart[i].onTapRemoveProduct = () {
          controller.onTapRemoveProductItem(controller.currentProductInCart[i]);
        };

        return AnimatedOpacity(
          duration: Duration(milliseconds: 500 + (i * 100)),
          opacity: 1.0,
          curve: Curves.easeInOut,
          child: Visibility(
            visible: controller.currentProductInCart[i].productType == 1,
            replacement: ItemProductNoBox(
              productItem: controller.currentProductInCart[i],
            ),
            child: ItemProductWithBox(
              productItem: controller.currentProductInCart[i],
            ),
          ),
        );
      },
      separatorBuilder: (c, i) {
        return Container(height: 15);
      },
      itemCount: controller.currentProductInCart.length,
    );
  }

  Widget _buildRowPrice(
    BuildContext context, {
    required String title,
    required double price,
    required bool isWeb,
    required double width,
  }) {
    return Row(
      mainAxisAlignment:
          isWeb ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Text(
          '$title:',
          style: TextStyleResource.textStyleBlack(context).copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: width * 0.3,
          child: Text(
            controller.formatCurrency(price),
            textAlign: TextAlign.end,
            style: TextStyleResource.textStyleBlack(context).copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
