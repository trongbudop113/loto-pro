import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/admin/mixin/appbar_mixin.dart';
import 'package:loto/page/profile/voucher_manager/voucher_detail_manager_controller.dart';
import 'package:loto/src/color_resource.dart';

class VoucherDetailManagerPage extends GetView<VoucherDetailManagerController> with AppbarMixin {
  const VoucherDetailManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResource.color_background_light,
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: boxConstraints,
          child: LayoutBuilder(builder: (context, constraint) {
            return _buildBody(context, constraint);
          }),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, BoxConstraints constraint){
    return Column(
      children: [
        buildAppBar(context, constraint, title: controller.pageTitle,),
        Expanded(
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Thông tin cơ bản'),
                  const SizedBox(height: 16),
                  _buildNameField(),
                  const SizedBox(height: 16),
                  _buildCodeField(),
                  const SizedBox(height: 16),
                  _buildDescriptionField(),
                  const SizedBox(height: 24),

                  _buildSectionTitle('Giá trị giảm giá'),
                  const SizedBox(height: 16),
                  _buildDiscountTypeSelector(),
                  const SizedBox(height: 16),
                  _buildDiscountField(),
                  const SizedBox(height: 24),

                  _buildSectionTitle('Điều kiện áp dụng'),
                  const SizedBox(height: 16),
                  _buildMinOrderAmountField(),
                  const SizedBox(height: 16),
                  _buildExpireDateField(),
                  const SizedBox(height: 32),

                  _buildSaveButton(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFF8E25),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: controller.nameController,
      decoration: InputDecoration(
        labelText: 'Tên voucher *',
        hintText: 'Nhập tên voucher',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: const Icon(Icons.card_giftcard),
      ),
      validator: controller.validateName,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildCodeField() {
    return TextFormField(
      controller: controller.codeController,
      decoration: InputDecoration(
        labelText: 'Mã voucher *',
        hintText: 'Nhập mã voucher (VD: SALE20)',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: const Icon(Icons.qr_code),
      ),
      validator: controller.validateCode,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.characters,
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: controller.descriptionController,
      decoration: InputDecoration(
        labelText: 'Mô tả',
        hintText: 'Nhập mô tả voucher (tùy chọn)',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: const Icon(Icons.description),
      ),
      maxLines: 3,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildDiscountTypeSelector() {
    return Obx(() => Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                if (!controller.isDiscountPercent.value) {
                  controller.toggleDiscountType();
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: controller.isDiscountPercent.value 
                      ? const Color(0xFFFF8E25) 
                      : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.percent,
                      color: controller.isDiscountPercent.value 
                          ? Colors.white 
                          : Colors.grey[600],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Phần trăm (%)',
                      style: TextStyle(
                        color: controller.isDiscountPercent.value 
                            ? Colors.white 
                            : Colors.grey[600],
                        fontWeight: controller.isDiscountPercent.value 
                            ? FontWeight.bold 
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                if (controller.isDiscountPercent.value) {
                  controller.toggleDiscountType();
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: !controller.isDiscountPercent.value 
                      ? const Color(0xFFFF8E25) 
                      : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.attach_money,
                      color: !controller.isDiscountPercent.value 
                          ? Colors.white 
                          : Colors.grey[600],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Số tiền (đ)',
                      style: TextStyle(
                        color: !controller.isDiscountPercent.value 
                            ? Colors.white 
                            : Colors.grey[600],
                        fontWeight: !controller.isDiscountPercent.value 
                            ? FontWeight.bold 
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildDiscountField() {
    return Obx(() => TextFormField(
      controller: controller.discountController,
      decoration: InputDecoration(
        labelText: controller.isDiscountPercent.value 
            ? 'Phần trăm giảm giá *' 
            : 'Số tiền giảm giá *',
        hintText: controller.isDiscountPercent.value 
            ? 'Nhập phần trăm (VD: 20)' 
            : 'Nhập số tiền (VD: 50000)',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: Icon(
          controller.isDiscountPercent.value 
              ? Icons.percent 
              : Icons.attach_money,
        ),
        suffixText: controller.isDiscountPercent.value ? '%' : 'đ',
      ),
      validator: controller.validateDiscount,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
    ));
  }

  Widget _buildMinOrderAmountField() {
    return TextFormField(
      controller: controller.minOrderAmountController,
      decoration: InputDecoration(
        labelText: 'Đơn hàng tối thiểu',
        hintText: 'Nhập số tiền tối thiểu (tùy chọn)',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: const Icon(Icons.shopping_cart),
        suffixText: 'đ',
      ),
      validator: controller.validateMinOrderAmount,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildExpireDateField() {
    return Obx(() => InkWell(
      onTap: controller.selectExpireDate,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[400]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, color: Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                controller.formattedExpireDate,
                style: TextStyle(
                  fontSize: 16,
                  color: controller.selectedExpireDate.value != null 
                      ? Colors.black87 
                      : Colors.grey[600],
                ),
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.grey),
          ],
        ),
      ),
    ));
  }

  Widget _buildSaveButton() {
    return Obx(() => SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: controller.isLoading.value 
            ? null 
            : controller.saveVoucher,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF8E25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: controller.isLoading.value
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                controller.saveButtonText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    ));
  }
}