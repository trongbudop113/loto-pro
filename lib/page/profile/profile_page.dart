import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/profile/profile_controller.dart';
import 'package:loto/page/profile/widgets/membership_card_widget.dart';
import 'package:loto/src/color_resource.dart';
import 'package:loto/src/style_resource.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4E6F1),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1440, minWidth: 600),
          child: LayoutBuilder(builder: (context, constraint) {
            return _buildLoggedInView(context, constraint);
          }),
        ),
      ),
    );
  }

  Widget _buildLoggedInView(BuildContext context, BoxConstraints constraint) {
    return Column(
      children: [
        _buildAppBar(context, constraint),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  if (controller.userLogin.value.uuid != null) {
                    return MembershipCardWidget(
                      userLogin: controller.userLogin.value,
                      controller: controller,
                    );
                  }
                  return _buildMemberCard();
                }),
                const SizedBox(height: 24),
                _buildUserInfo(context),
                const SizedBox(height: 24),
                _buildMenu(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMemberCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFF7A00), Color(0xFFFF8E25)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF8E25).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Thẻ Thành Viên',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Obx(() => Text(
                        controller.userLogin.value.name ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber[300],
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'VIP',
                      style: TextStyle(
                        color: Colors.amber[300],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPointInfo('Điểm tích lũy', '2,500'),
              _buildPointInfo('Hạng', 'Vàng'),
              _buildPointInfo('Ưu đãi', '10%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPointInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorResource.color_white_light,
        borderRadius: BorderRadius.circular(16),
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
            'Thông tin cá nhân',
            style: TextStyleResource.textStyleBlack(context).copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildTextField('Họ và tên', controller.nameController),
          const SizedBox(height: 12),
          _buildTextField('Số điện thoại', controller.phoneController),
          const SizedBox(height: 12),
          _buildTextField('Email', controller.emailController),
          const SizedBox(height: 12),
          _buildTextField('Địa chỉ', controller.addressController),
          const SizedBox(height: 16),
          _buildGenderSelection(),
          const SizedBox(height: 20),
          _buildUpdateButton(),
        ],
      ),
    );
  }

  Widget _buildMenu(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorResource.color_white_light,
        borderRadius: BorderRadius.circular(16),
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
            'Menu',
            style: TextStyleResource.textStyleBlack(context).copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(
              Icons.shopping_bag_outlined,
              color: Color(0xFFFF8E25),
            ),
            title: Text(
              'Đơn hàng của tôi',
              style: TextStyleResource.textStyleBlack(context),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => controller.onMyOrdersTap(),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(
              Icons.card_giftcard,
              color: Color(0xFFFF8E25),
            ),
            title: Text(
              'Voucher của tôi',
              style: TextStyleResource.textStyleBlack(context),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => controller.showMyVoucher(),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: Text(
              'Đăng xuất',
              style: TextStyleResource.textStyleBlack(context).copyWith(
                color: Colors.red,
              ),
            ),
            onTap: () => controller.logOutApp(),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Giới tính',
          style: TextStyleResource.textStyleBlack(Get.context!).copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Obx(() => Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Nam'),
                    value: 'Nam',
                    groupValue: controller.selectedGender.value,
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectedGender.value = value;
                      }
                    },
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Nữ'),
                    value: 'Nữ',
                    groupValue: controller.selectedGender.value,
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectedGender.value = value;
                      }
                    },
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            )),
      ],
    );
  }

  Widget _buildUpdateButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () => controller.updateUserInfo(),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF8E25),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: const Text(
          'Cập nhật thông tin',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController textController) {
    return TextField(
      controller: textController,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, BoxConstraints constraint) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 1440,
        minWidth: 600,
      ),
      child: _buildAppBarWeb(context, constraint),
    );
  }

  Widget _buildAppBarWeb(BuildContext context, BoxConstraints constraint) {
    return Container(
      height: 97,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF7A00), Color(0xFFFF8E25)],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: (constraint.maxWidth * 0.03).clamp(15, 44),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildMenuButton(),
          _buildTitle(),
          const SizedBox(width: 70)
        ],
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

  Text _buildTitle() {
    return const Text(
      "Cá Nhân",
      style: TextStyle(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }
}
