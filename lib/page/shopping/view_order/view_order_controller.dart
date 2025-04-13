import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ViewOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ViewOrderController());
  }
}

class ViewOrderController extends GetxController {
  final orders = <OrderModel>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) return;

      final snapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .orderBy('orderDate', descending: true)
          .get();

      orders.value = snapshot.docs
          .map((doc) => OrderModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching orders: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

class OrderModel {
  final String orderId;
  final String status;
  final String orderDate;
  final String address;
  final String phone;
  final List<OrderItem> items;
  final double total;

  OrderModel({
    required this.orderId,
    required this.status,
    required this.orderDate,
    required this.address,
    required this.phone,
    required this.items,
    required this.total,
  });

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrderModel(
      orderId: doc.id,
      status: data['status'] ?? '',
      orderDate: data['orderDate']?.toDate()?.toString() ?? '',
      address: data['address'] ?? '',
      phone: data['phone'] ?? '',
      items: (data['items'] as List?)
          ?.map((item) => OrderItem.fromMap(item))
          .toList() ?? [],
      total: (data['total'] ?? 0).toDouble(),
    );
  }
}

class OrderItem {
  final String name;
  final int quantity;
  final double price;

  OrderItem({
    required this.name,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: (map['price'] ?? 0).toDouble(),
    );
  }
}