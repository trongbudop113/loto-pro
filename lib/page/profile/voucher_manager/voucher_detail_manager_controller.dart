import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/profile/models/voucher_model.dart';
import 'package:intl/intl.dart';

class VoucherDetailManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VoucherDetailManagerController());
  }
}

class VoucherDetailManagerController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final codeController = TextEditingController();
  final discountController = TextEditingController();
  final minOrderAmountController = TextEditingController();
  final descriptionController = TextEditingController();
  
  final RxBool isLoading = false.obs;
  final RxBool isDiscountPercent = true.obs;
  final Rx<DateTime?> selectedExpireDate = Rx<DateTime?>(null);
  
  VoucherModel? editingVoucher;
  bool get isEditing => editingVoucher != null;
  
  @override
  void onInit() {
    super.onInit();
    
    // Kiểm tra nếu có voucher được truyền vào để chỉnh sửa
    if (Get.arguments != null && Get.arguments is VoucherModel) {
      editingVoucher = Get.arguments as VoucherModel;
      _fillFormWithVoucherData();
    }
  }
  
  void _fillFormWithVoucherData() {
    if (editingVoucher == null) return;
    
    nameController.text = editingVoucher!.name;
    codeController.text = editingVoucher!.code;
    descriptionController.text = editingVoucher!.description ?? '';
    
    // Xử lý discount
    if (editingVoucher!.discount >= 1) {
      // Discount là số tiền
      isDiscountPercent.value = false;
      discountController.text = editingVoucher!.discount.toInt().toString();
    } else {
      // Discount là phần trăm
      isDiscountPercent.value = true;
      discountController.text = (editingVoucher!.discount * 100).toInt().toString();
    }
    
    if (editingVoucher!.minOrderAmount != null) {
      minOrderAmountController.text = editingVoucher!.minOrderAmount!.toInt().toString();
    }
    
    if (editingVoucher!.expiredAt != null) {
      selectedExpireDate.value = editingVoucher!.expiredAt;
    }
  }
  
  @override
  void onClose() {
    nameController.dispose();
    codeController.dispose();
    discountController.dispose();
    minOrderAmountController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
  
  String get pageTitle => isEditing ? 'Chỉnh sửa Voucher' : 'Tạo Voucher mới';
  String get saveButtonText => isEditing ? 'Cập nhật' : 'Tạo mới';
  
  void toggleDiscountType() {
    isDiscountPercent.value = !isDiscountPercent.value;
    discountController.clear();
  }
  
  Future<void> selectExpireDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: selectedExpireDate.value ?? DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    
    if (picked != null) {
      selectedExpireDate.value = picked;
    }
  }
  
  String get formattedExpireDate {
    if (selectedExpireDate.value == null) {
      return 'Chọn ngày hết hạn';
    }
    return DateFormat('dd/MM/yyyy').format(selectedExpireDate.value!);
  }
  
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập tên voucher';
    }
    if (value.trim().length < 3) {
      return 'Tên voucher phải có ít nhất 3 ký tự';
    }
    return null;
  }
  
  String? validateCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập mã voucher';
    }
    if (value.trim().length < 3) {
      return 'Mã voucher phải có ít nhất 3 ký tự';
    }
    // Kiểm tra mã chỉ chứa chữ cái, số và dấu gạch ngang
    if (!RegExp(r'^[A-Za-z0-9-_]+$').hasMatch(value.trim())) {
      return 'Mã voucher chỉ được chứa chữ cái, số và dấu gạch ngang';
    }
    return null;
  }
  
  String? validateDiscount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập giá trị giảm giá';
    }
    
    final discount = double.tryParse(value.trim());
    if (discount == null || discount <= 0) {
      return 'Giá trị giảm giá phải là số dương';
    }
    
    if (isDiscountPercent.value && discount > 100) {
      return 'Phần trăm giảm giá không được vượt quá 100%';
    }
    
    return null;
  }
  
  String? validateMinOrderAmount(String? value) {
    if (value != null && value.trim().isNotEmpty) {
      final amount = double.tryParse(value.trim());
      if (amount == null || amount < 0) {
        return 'Số tiền đơn hàng tối thiểu phải là số không âm';
      }
    }
    return null;
  }
  
  Future<void> saveVoucher() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    
    if (selectedExpireDate.value == null) {
      Get.snackbar(
        'Lỗi',
        'Vui lòng chọn ngày hết hạn',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    
    try {
      isLoading.value = true;
      
      // Tính toán giá trị discount
      double discountValue = double.parse(discountController.text.trim());
      if (isDiscountPercent.value) {
        discountValue = discountValue / 100; // Chuyển phần trăm thành decimal
      }
      
      final voucherData = {
        'name': nameController.text.trim(),
        'code': codeController.text.trim().toUpperCase(),
        'discount': discountValue,
        'description': descriptionController.text.trim().isEmpty 
            ? null 
            : descriptionController.text.trim(),
        'minOrderAmount': minOrderAmountController.text.trim().isEmpty 
            ? null 
            : double.parse(minOrderAmountController.text.trim()),
        'expireDate': DateFormat('dd/MM/yyyy').format(selectedExpireDate.value!),
        'expiredAt': selectedExpireDate.value!.millisecondsSinceEpoch,
        'updatedAt': DateTime.now().millisecondsSinceEpoch,
      };
      
      if (isEditing) {
        // Cập nhật voucher
        await firestore
            .collection('vouchers')
            .doc(editingVoucher!.id)
            .update(voucherData);
        
        Get.snackbar(
          'Thành công',
          'Đã cập nhật voucher thành công',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        // Kiểm tra mã voucher đã tồn tại chưa
        final existingVoucher = await firestore
            .collection('vouchers')
            .where('code', isEqualTo: voucherData['code'])
            .get();
        
        if (existingVoucher.docs.isNotEmpty) {
          Get.snackbar(
            'Lỗi',
            'Mã voucher đã tồn tại, vui lòng chọn mã khác',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }
        
        // Tạo voucher mới
        voucherData['createdAt'] = DateTime.now().millisecondsSinceEpoch;
        await firestore.collection('vouchers').add(voucherData);
        
        Get.snackbar(
          'Thành công',
          'Đã tạo voucher mới thành công',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
      
      Get.back();
      
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Có lỗi xảy ra: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}