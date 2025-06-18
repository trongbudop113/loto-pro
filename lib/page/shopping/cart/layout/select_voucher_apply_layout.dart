import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/profile/models/voucher_model.dart';
import 'package:loto/page/shopping/cart/cart_controller.dart';
import 'package:loto/src/color_resource.dart';
import 'package:loto/src/style_resource.dart';

class SelectVoucherApplyLayout extends StatelessWidget {
  final CartController controller;
  const SelectVoucherApplyLayout({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: Get.width * 0.9,
        constraints: const BoxConstraints(maxWidth: 500),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ColorResource.color_main_light.withOpacity(0.1),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.local_offer,
                    color: ColorResource.color_main_light,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Chọn voucher',
                      style: TextStyleResource.textStyleBlack(context).copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorResource.color_main_light,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.close,
                      color: ColorResource.color_main_light,
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Flexible(
              child: Container(
                constraints: const BoxConstraints(maxHeight: 400),
                child: Obx(() {
                  if (controller.userVouchers.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.local_offer_outlined,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Bạn chưa có voucher nào',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Hãy thu thập voucher để nhận ưu đãi!',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Option không sử dụng voucher
                        _buildVoucherOption(
                          context: context,
                          voucher: null,
                          isSelected: controller.selectedVoucher.value == null,
                          onTap: () {
                            controller.selectVoucher(null);
                            Get.back();
                          },
                        ),
                        const SizedBox(height: 12),
                        // Danh sách voucher
                        ...controller.userVouchers.map((voucher) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildVoucherOption(
                            context: context,
                            voucher: voucher,
                            isSelected: controller.selectedVoucher.value?.id == voucher.id,
                            onTap: () {
                              controller.selectVoucher(voucher);
                              Get.back();
                            },
                          ),
                        )),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoucherOption({
    required BuildContext context,
    required VoucherModel? voucher,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    if (voucher == null) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? ColorResource.color_main_light.withOpacity(0.1) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? ColorResource.color_main_light : Colors.grey[300]!,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? ColorResource.color_main_light : Colors.grey[400]!,
                    width: 2,
                  ),
                  color: isSelected ? ColorResource.color_main_light : Colors.transparent,
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        size: 14,
                        color: Colors.white,
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Không sử dụng voucher',
                  style: TextStyleResource.textStyleBlack(context).copyWith(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? ColorResource.color_main_light : Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? ColorResource.color_main_light.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? ColorResource.color_main_light : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? ColorResource.color_main_light : Colors.grey[400]!,
                    width: 2,
                  ),
                  color: isSelected ? ColorResource.color_main_light : Colors.transparent,
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        size: 14,
                        color: Colors.white,
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: ColorResource.color_main_light.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    voucher.discountText,
                    style: const TextStyle(
                      color: ColorResource.color_main_light,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      voucher.name,
                      style: TextStyleResource.textStyleBlack(context).copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: isSelected ? ColorResource.color_main_light : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Giảm: ${voucher.discountText}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    if (voucher.minOrderAmount != null)
                      Text(
                        'Đơn tối thiểu: ${controller.formatCurrency(voucher.minOrderAmount!)}',
                        style: TextStyle(
                          color: Colors.orange[600],
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    Text(
                      'HSD: ${voucher.expireDate}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: voucher.isValid 
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  voucher.isValid ? 'Có thể dùng' : 'Hết hạn',
                  style: TextStyle(
                    color: voucher.isValid ? Colors.green : Colors.red,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
