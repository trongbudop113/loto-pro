import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/profile/models/voucher_model.dart';
import 'package:loto/page/profile/profile_controller.dart';
import 'package:loto/src/color_resource.dart';
import 'package:loto/src/style_resource.dart';

class VoucherLayout extends StatelessWidget {
  final ProfileController controller;
  const VoucherLayout({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text(
                      'Voucher của tôi',
                      style: TextStyleResource.textStyleBlack(Get.context!).copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton.icon(
                       onPressed: () {
                         Get.back();
                         Get.toNamed('/voucher-collection');
                       },
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: ColorResource.color_main_light,
                        size: 20,
                      ),
                      label: Text(
                        'Thu thập',
                        style: TextStyleResource.textStyleWhite(context).copyWith(
                          color: ColorResource.color_main_light,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoadingVouchers.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              
              if (controller.listVouchers.isEmpty) {
                return Center(
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
                        'Chưa có voucher nào',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Hãy tích điểm để nhận voucher!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                );
              }
              
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: controller.listVouchers.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final voucher = controller.listVouchers[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: ColorResource.color_main_light.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    voucher.discountText,
                                    style: const TextStyle(
                                      color: ColorResource.color_main_light,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
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
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    if (voucher.description != null)
                                      Text(
                                        voucher.description!,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                        ),
                                      ),
                                    const SizedBox(height: 4),
                                    Text(
                                       'Hết hạn: ${voucher.expireDate}',
                                       style: TextStyle(
                                         color: Colors.grey[600],
                                         fontSize: 12,
                                       ),
                                     ),
                                     if (voucher.minOrderAmount != null)
                                       Text(
                                         'Đơn tối thiểu: ${voucher.minOrderAmount!.toInt()}đ',
                                         style: TextStyle(
                                           color: Colors.orange[600],
                                           fontSize: 11,
                                           fontWeight: FontWeight.w500,
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
                                   borderRadius: BorderRadius.circular(12),
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
                         Container(
                           padding: const EdgeInsets.all(16),
                           decoration: BoxDecoration(
                             color: Colors.grey[50],
                             borderRadius: const BorderRadius.vertical(
                               bottom: Radius.circular(12),
                             ),
                           ),
                           child: Row(
                             children: [
                               Expanded(
                                 child: Container(
                                   padding: const EdgeInsets.symmetric(
                                     horizontal: 12,
                                     vertical: 8,
                                   ),
                                   decoration: BoxDecoration(
                                     color: Colors.white,
                                     borderRadius: BorderRadius.circular(8),
                                     border: Border.all(
                                       color: Colors.grey[300]!,
                                     ),
                                   ),
                                   child: Text(
                                     voucher.code,
                                     style: const TextStyle(
                                       fontWeight: FontWeight.w500,
                                       letterSpacing: 1,
                                     ),
                                   ),
                                 ),
                               ),
                               const SizedBox(width: 8),
                               GestureDetector(
                                 onTap: () => controller.copyVoucherCode(voucher.code),
                                 child: Container(
                                   padding: const EdgeInsets.symmetric(
                                     horizontal: 12,
                                     vertical: 8,
                                   ),
                                   decoration: BoxDecoration(
                                     color: ColorResource.color_main_light,
                                     borderRadius: BorderRadius.circular(8),
                                   ),
                                   child: const Text(
                                     'Sao chép',
                                     style: TextStyle(
                                       color: Colors.white,
                                       fontWeight: FontWeight.w500,
                                       fontSize: 12,
                                     ),
                                   ),
                                 ),
                               ),
                               const SizedBox(width: 8),
                               GestureDetector(
                                 onTap: voucher.isValid 
                                     ? () => _showUseVoucherDialog(context, voucher)
                                     : null,
                                 child: Container(
                                   padding: const EdgeInsets.symmetric(
                                     horizontal: 12,
                                     vertical: 8,
                                   ),
                                   decoration: BoxDecoration(
                                     color: voucher.isValid 
                                         ? Colors.green
                                         : Colors.grey[400],
                                     borderRadius: BorderRadius.circular(8),
                                   ),
                                   child: const Text(
                                     'Sử dụng',
                                     style: TextStyle(
                                       color: Colors.white,
                                       fontWeight: FontWeight.w500,
                                       fontSize: 12,
                                     ),
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ],
                     ),
                   );
                 },
               );
             }),
          ),
        ],
      ),
    );
  }

  void _showUseVoucherDialog(BuildContext context, VoucherModel voucher) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận sử dụng voucher'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bạn có chắc chắn muốn sử dụng voucher này?'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      voucher.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Mã: ${voucher.code}'),
                    Text('Giảm: ${voucher.discountText}'),
                    if (voucher.minOrderAmount != null)
                      Text('Đơn tối thiểu: ${voucher.minOrderAmount!.toInt()}đ'),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Lưu ý: Voucher sẽ được đánh dấu là đã sử dụng sau khi xác nhận.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.orange[600],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.useVoucher(voucher.id);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Sử dụng'),
            ),
          ],
        );
      },
    );
  }
}
