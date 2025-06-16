import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/models/user_login.dart';
import 'package:loto/page/shopping/cart/cart_controller.dart';

class PickUserLayout extends StatelessWidget {
  final CartController controller;
  const PickUserLayout({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width < 650
        ? MediaQuery.of(context).size.width
        : 450;
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          _buildUserList(),
          _buildCloseButton(),
        ],
      ),
    );
  }

  Widget _buildUserList() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 400),
      child: StreamBuilder<QuerySnapshot>(
        stream: controller.getListUser(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFFF8E25),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            itemBuilder: (c, i) {
              var user = UserLogin.fromJson(
                snapshot.data?.docs[i].data() as Map<String, dynamic>
              );
              return _buildUserItem(user);
            },
            separatorBuilder: (c, i) => const Divider(height: 1),
            itemCount: snapshot.data!.size,
          );
        },
      ),
    );
  }

  Widget _buildUserItem(UserLogin user) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => controller.onPickUser(user),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF8E25).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  ((user.name ?? "").isNotEmpty ? user.name! : "No Name").substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                    color: Color(0xFFFF8E25),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (user.name ?? "").isNotEmpty ? user.name! : "No Name",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      (user.phoneNumber ?? '').isNotEmpty
                          ? user.phoneNumber!
                          : user.email ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
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
          bottom: BorderSide(color: Color(0xFFEEEEEE)),
        ),
      ),
      alignment: Alignment.center,
      child: const Text(
        "Chọn tài khoản đặt hàng",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFF333333),
        ),
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
              top: BorderSide(color: Color(0xFFEEEEEE)),
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
