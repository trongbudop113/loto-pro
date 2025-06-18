import 'package:flutter/material.dart';
import 'package:loto/page/profile/profile_controller.dart';

class MemberInfoLayout extends StatelessWidget {
  final ProfileController controller;
  const MemberInfoLayout({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                controller.userLogin.value.membershipIcon,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.userLogin.value.membershipDisplayName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${controller.userLogin.value.membershipPoints ?? 0} điểm',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (controller.userLogin.value.pointsToNextTier > 0)...[
            Text(
              'Cần thêm ${controller.userLogin.value.pointsToNextTier} điểm để lên cấp tiếp theo',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: (controller.userLogin.value.membershipPoints ?? 0) /
                  (controller.userLogin.value.membershipPoints! + controller.userLogin.value.pointsToNextTier),
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(controller.userLogin.value.membershipColor),
              ),
            ),
          ] else...[
            const Text(
              'Bạn đã đạt cấp độ cao nhất!',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('Tổng chi tiêu', '${controller.userLogin.value.totalSpent ?? 0}đ'),
              _buildStatItem('Tổng đơn hàng', '${controller.userLogin.value.totalOrders ?? 0}'),
            ],
          ),
          const SizedBox(height: 20),
          if (controller.userLogin.value.membershipJoinDateFormatted.isNotEmpty)
            Text(
              'Thành viên từ: ${controller.userLogin.value.membershipJoinDateFormatted}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

}
