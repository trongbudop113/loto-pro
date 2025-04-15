import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/common.dart';
import 'package:loto/common/utils.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/shopping/cart/models/order_cart.dart';
import 'package:loto/page_config.dart';

class ViewOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ViewOrderController());
  }
}

class ViewOrderController extends GetxController {
  final isLoading = true.obs;
  final listOrderTime = <OrderTime>[].obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    getDateOrder();
    super.onInit();
  }

  Future<void> getDateOrder() async {
    try {
      isLoading.value = true;
      listOrderTime.clear();
      
      // Get orders document
      final ordersDoc = await firestore
          .collection(DataRowName.Cakes.name)
          .doc(DataCollection.Orders.name)
          .get();

      if (!ordersDoc.exists) {
        isLoading.value = false;
        return;
      }

      // Parse orders data
      final lsOrderTime = LsOrderTime.fromJson(ordersDoc.data() as Map<String, dynamic>);
      
      // Use Future.wait for parallel processing
      final futures = lsOrderTime.lsOrderTime.map((orderTime) async {
        final orders = await getDateOrderByDate(orderTime.orderDateID ?? '');
        if (orders.isNotEmpty) {
          var item = OrderTime(
            orderDateID: orderTime.orderDateID,
            orderDateTitle: orderTime.orderDateTitle,
          );
          item.lisOrderCart.addAll(orders);
          return item;
        }
        return null;
      });

      // Wait for all futures to complete and filter out null values
      final results = await Future.wait(futures);
      listOrderTime.assignAll(
        results.whereType<OrderTime>().toList()
      );

    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Không thể tải danh sách đơn hàng',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error in getDateOrder: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<OrderCart>> getDateOrderByDate(String orderDateID) async {
    try {
      final currentUser = AppCommon.singleton.userLoginData;
      if (currentUser.uuid == null) return [];

      final querySnapshot = await firestore
          .collection(DataRowName.Cakes.name)
          .doc(DataCollection.Orders.name)
          .collection(orderDateID)
          .where("user_id", isEqualTo: currentUser.uuid)
          .get();

      return querySnapshot.docs
          .map((doc) => OrderCart.fromJson(doc.data()))
          .toList();
          
    } catch (e) {
      print('Error in getDateOrderByDate: $e');
      return [];
    }
  }

  String formatCurrency(double d) {
    return "${FormatUtils.oCcy.format(d)}đ";
  }

  void goToOrderDetail(OrderCart orderCart, String orderDateID) {
    Get.toNamed(PageConfig.ORDER_DETAIL_MANAGER, arguments: {
      "order_cart" : orderCart,
      "order_date" : orderDateID
    });
  }
}