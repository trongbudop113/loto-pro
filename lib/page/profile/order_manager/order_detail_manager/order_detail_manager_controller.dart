
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/mesage_util.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/profile/order_manager/order_detail_manager/models/status_order.dart';
import 'package:loto/page/profile/order_manager/order_detail_manager/widgets/change_status_layout.dart';
import 'package:loto/page/shopping/cart/models/order_cart.dart';

class OrderDetailManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderDetailManagerController());
  }
}

class OrderDetailManagerController extends GetxController{

  final Rx<OrderCart> orderCartData = OrderCart().obs;
  final RxString titleAppbar = "".obs;
  final List<StatusOrder> listStatus = StatusOrder.listStatusExample();
  String orderDateID = "";
  final Rx<StatusOrder> statusOrderData = StatusOrder(statusID: 1, statusName: "").obs;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  void initData() {
    orderCartData.value = Get.arguments['order_cart'] as OrderCart;
    orderDateID = Get.arguments['order_date'] as String;
    titleAppbar.value = orderCartData.value.orderID ?? '';

    var data = listStatus.firstWhereOrNull((e) => e.statusID == orderCartData.value.statusOrder);
    if(data != null){
      data.isSelected.value = true;
      statusOrderData.value = data;
    }
  }

  void onChangeStatusOrder(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Change Status",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) {
        return ChangeStatusLayout(controller: this,);
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(
            begin: Offset(-1, 0),
            end: Offset.zero,
          );
        } else {
          tween = Tween(
            begin: Offset(1, 0),
            end: Offset.zero,
          );
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  Future<void> onSelectStatus(StatusOrder statusOrder) async {
    for (var e in listStatus) {
      if(e.statusID == statusOrder.statusID){
        e.isSelected.value = true;
      }else{
        e.isSelected.value = false;
      }
    }

    CollectionReference collectionRef = firestore.collection(DataRowName.Cakes.name);
    await collectionRef.doc(DataCollection.Orders.name).collection(orderDateID).doc(orderCartData.value.orderID).update(
      {
        "status_order" : statusOrder.statusID
      }
    );
    statusOrderData.value = statusOrder;
    Get.back();

    MessageUtil.show(msg: "Cập nhật thành công");
  }
}