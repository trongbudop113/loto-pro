import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/utils.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/shopping/cart/models/order_cart.dart';

class OrderManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderManagerController());
  }
}

class OrderManagerController extends GetxController{

  Color a = Colors.red;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
  }

  Stream<DocumentSnapshot<Object?>> getDateOrder() {
    CollectionReference collectionRef = firestore.collection(DataRowName.Cakes.name);
    return collectionRef.doc(DataCollection.Orders.name).snapshots();
  }

  Stream<QuerySnapshot<Object?>> getDateOrderByDate(String orderDateID) {
    CollectionReference collectionRef = firestore.collection(DataRowName.Cakes.name);
    return collectionRef.doc(DataCollection.Orders.name).collection(orderDateID).snapshots();
  }

  OrderCart convertToOrderItem(Object? data) {
    return OrderCart.fromJson(data as Map<String, dynamic>);
  }

  String formatCurrency(double d) {
    return "${FormatUtils.oCcy.format(d)}đ";
  }

}