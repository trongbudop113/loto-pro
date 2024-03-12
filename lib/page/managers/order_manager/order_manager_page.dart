import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/managers/order_manager/order_manager_controller.dart';
import 'package:loto/page/shopping/cart/models/order_cart.dart';
import 'package:loto/src/style_resource.dart';

class OrderManagerPage extends GetView<OrderManagerController> {
  const OrderManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: controller.a,
        appBar: AppBar(),
        body: StreamBuilder<DocumentSnapshot<Object?>>(
            stream: controller.getDateOrder(),
            builder: (context, snapShot) {
              if (snapShot.hasData) {
                LsOrderTime lsOrderTime = LsOrderTime.fromJson(
                    snapShot.data!.data() as Map<String, dynamic>);

                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Đơn ngày ${lsOrderTime.lsOrderTime[index].orderDateTitle ?? ''}",
                            style: TextStyleResource.textStyleBlack(context),
                          ),
                        ),
                        Divider(),
                        Container(
                          height: 120,
                          child: StreamBuilder<QuerySnapshot<Object?>>(
                              stream: controller.getDateOrderByDate(lsOrderTime.lsOrderTime[index].orderDateID ?? ''),
                              builder: (context, snapShot) {
                                if(snapShot.hasData){
                                  return ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapShot.data!.docs.length,
                                    itemBuilder: (c, x){
                                      return Container(
                                        color: Colors.amberAccent,
                                        width: 200,
                                        child: Column(
                                          children: [
                                            Text(
                                              controller.convertToOrderItem(snapShot.data!.docs[x].data()).userOrder?.name ?? '',
                                              style: TextStyleResource.textStyleBlack(context),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (BuildContext context, int index) {
                                      return SizedBox(width: 15,);
                                    },
                                  );
                                }
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                          ),
                        )
                      ],
                    );
                  },
                  itemCount: lsOrderTime.lsOrderTime.length,
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
