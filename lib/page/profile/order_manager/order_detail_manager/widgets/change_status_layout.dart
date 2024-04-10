import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/utils.dart';
import 'package:loto/page/profile/order_manager/order_detail_manager/order_detail_manager_controller.dart';
import 'package:loto/src/style_resource.dart';

class ChangeStatusLayout extends StatelessWidget {
  final OrderDetailManagerController controller;
  const ChangeStatusLayout({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 40,
                  child: Text(
                    "Chọn Trạng Thái",
                    style: TextStyleResource.textStyleBlack(context).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _listStatus(context),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(12),
                      ),
                    ),
                    height: 48,
                    alignment: Alignment.center,
                    child: Text("Đóng"),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _listStatus(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: controller.listStatus.length,
        itemBuilder: (c, i) {
          return GestureDetector(
            onTap: (){
              controller.onSelectStatus(controller.listStatus[i]);
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Text(
                    controller.listStatus[i].statusName ?? '',
                    style: TextStyleResource.textStyleBlack(context).copyWith(
                      color: FormatUtils.orderStatusColor(controller.listStatus[i].statusID ?? 1),
                    ),
                  ),
                  const Spacer(flex: 1,),
                  Obx((){
                    return Visibility(
                      visible: controller.listStatus[i].isSelected.value,
                      child: const Icon(Icons.check, color: Colors.green,),
                    );
                  })
                ],
              ),
            ),
          );
        },
        separatorBuilder: (c, i){
          return Divider();
        },
      ),
    );
  }
}
