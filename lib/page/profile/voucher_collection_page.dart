import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/profile/profile_controller.dart';
import 'package:loto/src/color_resource.dart';
import 'package:loto/src/style_resource.dart';

class VoucherCollectionPage extends StatelessWidget {
  const VoucherCollectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();

    // Tải tất cả voucher công khai khi vào trang
    controller.loadAllVouchers();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thu thập voucher'),
        backgroundColor: ColorResource.color_main_light,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.isLoadingVouchers.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: ColorResource.color_main_light,
            ),
          );
        }

        if (controller.listVouchersAll.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.card_giftcard,
                  size: 64,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  'Không có voucher nào để thu thập',
                  style: TextStyleResource.textStyleBlack(context).copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.listVouchersAll.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final voucher = controller.listVouchersAll[index];
            final isCollected = controller.isVoucherCollected(voucher.id);

            return Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header với tên voucher và trạng thái
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color:
                                ColorResource.color_main_light.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            voucher.discountText,
                            style: TextStyleResource.textStyleBlack(context)
                                .copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: ColorResource.color_main_light,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            voucher.name,
                            style: TextStyleResource.textStyleBlack(context)
                                .copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        if (isCollected)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Đã thu thập',
                              style: TextStyleResource.textStyleWhite(context)
                                  .copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),

                    SizedBox(height: 12),

                    // Mô tả voucher
                    if ((voucher.description ?? '').isNotEmpty)
                      Text(
                        voucher.description ?? '',
                        style:
                            TextStyleResource.textStyleBlack(context).copyWith(
                          color: Colors.grey[600],
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                    SizedBox(height: 8),

                    // Thông tin chi tiết
                    Row(
                      children: [
                        Icon(Icons.code, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          'Mã: ${voucher.code}',
                          style: TextStyleResource.textStyleBlack(context)
                              .copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.access_time, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          'HSD: ${voucher.expireDate}',
                          style: TextStyleResource.textStyleBlack(context)
                              .copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    if ((voucher.minOrderAmount ?? 0) > 0) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.shopping_cart,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            'Đơn tối thiểu: ${(voucher.minOrderAmount ?? 0).toStringAsFixed(0)}đ',
                            style: TextStyleResource.textStyleBlack(context)
                                .copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],

                    const SizedBox(height: 12),

                    // Nút thu thập
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isCollected
                            ? null
                            : () =>
                                controller.showCollectVoucherDialog(voucher),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isCollected
                              ? Colors.grey
                              : ColorResource.color_main_light,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          isCollected ? 'Đã thu thập' : 'Thu thập voucher',
                          style: TextStyleResource.textStyleBlack(context)
                              .copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
