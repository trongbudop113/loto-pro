import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/profile/models/voucher_model.dart';
import 'package:loto/page_config.dart';
import 'package:loto/src/color_resource.dart';

class VoucherManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VoucherManagerController());
  }
}

class VoucherManagerController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  final RxBool isLoading = false.obs;
  final RxList<VoucherModel> vouchers = <VoucherModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadVouchers();
  }

  Stream<QuerySnapshot<Object?>> streamGetVouchers() {
    CollectionReference voucherRef = firestore.collection(DataRowName.Cakes.name)
        .doc(DataCollection.Vouchers.name)
        .collection(DataCollection.Vouchers.name);
    return voucherRef.orderBy('createdAt', descending: true).snapshots();
  }

  Future<void> loadVouchers() async {
    try {
      isLoading.value = true;
      final snapshot = await firestore
          .collection(DataRowName.Cakes.name)
          .doc(DataCollection.Vouchers.name)
          .collection(DataCollection.Vouchers.name)
          .orderBy('createdAt', descending: true)
          .get();
      
      vouchers.value = snapshot.docs
          .map((doc) => VoucherModel.fromJson({
                ...doc.data(),
                'id': doc.id,
              }))
          .toList();
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Không thể tải danh sách voucher: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void onTapItem(VoucherModel voucher) {
    Get.toNamed(PageConfig.VOUCHER_DETAIL_MANAGER, arguments: voucher);
  }

  void onAddNewVoucher() {
    Get.toNamed(PageConfig.VOUCHER_DETAIL_MANAGER);
  }

  Future<void> deleteVoucher(String voucherId) async {
    try {
      await firestore.collection(DataRowName.Cakes.name)
          .doc(DataCollection.Vouchers.name)
          .collection(DataCollection.Vouchers.name).doc(voucherId).delete();
      Get.snackbar(
        'Thành công',
        'Đã xóa voucher thành công',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      loadVouchers();
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Không thể xóa voucher: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void showDeleteConfirmDialog(VoucherModel voucher) {
    Get.dialog(
      AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: Text('Bạn có chắc chắn muốn xóa voucher "${voucher.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              deleteVoucher(voucher.id);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }

  Color getStatusColor(VoucherModel voucher) {
    if (voucher.isExpired) {
      return Colors.red;
    }
    return Colors.green;
  }

  String getStatusText(VoucherModel voucher) {
    if (voucher.isExpired) {
      return 'Hết hạn';
    }
    return 'Còn hiệu lực';
  }
}