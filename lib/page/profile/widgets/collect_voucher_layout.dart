import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/profile/models/voucher_model.dart';
import 'package:loto/page/profile/profile_controller.dart';

class CollectVoucherLayout extends StatelessWidget {
  final ProfileController controller;
  final VoucherModel voucher;
  const CollectVoucherLayout({
    super.key,
    required this.controller,
    required this.voucher,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Thu thập voucher'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tên voucher: ${voucher.name}'),
          const SizedBox(height: 8),
          Text('Mã: ${voucher.code}'),
          const SizedBox(height: 8),
          Text('Giảm giá: ${voucher.discountText}'),
          if ((voucher.minOrderAmount ?? 0) > 0) ...[
            const SizedBox(height: 8),
            Text(
              'Đơn tối thiểu: ${(voucher.minOrderAmount ?? 0).toStringAsFixed(0)}đ',
            ),
          ],
          const SizedBox(height: 8),
          Text('Hạn sử dụng: ${voucher.expireDate}'),
          if ((voucher.description ?? '').isNotEmpty) ...[
            const SizedBox(height: 8),
            Text('Mô tả: ${voucher.description}'),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back();
            controller.collectVoucher(voucher.id);
          },
          child: const Text('Thu thập'),
        ),
      ],
    );
  }
}
