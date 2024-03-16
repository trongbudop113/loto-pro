import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/custom_icon_icons.dart';
import 'package:loto/common/utils.dart';
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
                          color: Colors.blueAccent,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Đơn ngày ${lsOrderTime.lsOrderTime[index].orderDateTitle ?? ''}",
                            style: TextStyleResource.textStyleBlack(context),
                          ),
                        ),
                        SizedBox(width: 15),
                        Container(
                          height: 170,
                          child: StreamBuilder<QuerySnapshot<Object?>>(
                              stream: controller.getDateOrderByDate(lsOrderTime.lsOrderTime[index].orderDateID ?? ''),
                              builder: (context, snapShot) {
                                if(snapShot.hasData){
                                  return ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapShot.data!.docs.length,
                                    padding: EdgeInsets.symmetric(horizontal: 15,),
                                    itemBuilder: (c, x){
                                      OrderCart item = controller.convertToOrderItem(snapShot.data!.docs[x].data());
                                      return Container(
                                        color: Colors.amberAccent,
                                        width: 280,
                                        padding: EdgeInsets.all(15),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  item.userOrder?.name ?? '',
                                                  style: TextStyleResource.textStyleBlack(context),
                                                ),
                                                const Icon(
                                                  Icons.keyboard_double_arrow_right
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Row(
                                              children: [
                                                Icon(Icons.shopping_bag,),
                                                SizedBox(width: 8,),
                                                Text("${(item.listProductItem ?? []).length} sản phẩm")
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Row(
                                              children: [
                                                Text("Tổng tiền:"),
                                                SizedBox(width: 8,),
                                                Text(controller.formatCurrency(item.totalPrice ?? 0))
                                              ],
                                            ),
                                            Spacer(flex: 1,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text("Trạng thái: ${FormatUtils.formatOrderStatus(item.statusOrder ?? 1)}")
                                              ],
                                            ),
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
