import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/utils.dart';
import 'package:loto/page/profile/order_manager/order_detail_manager/order_detail_manager_controller.dart';
import 'package:loto/src/style_resource.dart';

class ChangeStatusLayout extends StatelessWidget {
  final OrderDetailManagerController controller;
  const ChangeStatusLayout({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          constraints: const BoxConstraints(maxWidth: 400),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              _buildStatusList(),
              _buildCloseButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFEEEEEE),
            width: 1,
          ),
        ),
      ),
      child: const Text(
        "Chọn trạng thái đơn hàng",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF333333),
        ),
      ),
    );
  }

  Widget _buildStatusList() {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 400,
        minHeight: 200,
      ),
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: controller.listStatus.length,
        separatorBuilder: (c, i) => const Divider(height: 1),
        itemBuilder: (c, i) {
          final status = controller.listStatus[i];
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => controller.onSelectStatus(status),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: FormatUtils.orderStatusColor(status.statusID ?? 1),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        status.statusName ?? '',
                        style: TextStyle(
                          fontSize: 16,
                          color: FormatUtils.orderStatusColor(status.statusID ?? 1),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Obx(() {
                      return AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: status.isSelected.value ? 1 : 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 20,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCloseButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Get.back(),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color(0xFFEEEEEE),
                width: 1,
              ),
            ),
          ),
          child: const Text(
            "Đóng",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFFFF8E25),
            ),
          ),
        ),
      ),
    );
  }
}
