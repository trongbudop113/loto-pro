import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/utils.dart';
import 'package:loto/page/profile/order_manager/order_detail_manager/order_detail_manager_controller.dart';
import 'package:loto/page/shopping/moon_cake/controller/moon_cake_controller.dart';
import 'package:loto/src/style_resource.dart';

class SelectFilterLayout extends StatelessWidget {
  final MoonCakeController controller;
  const SelectFilterLayout({super.key, required this.controller});

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
                    "Chọn Loại",
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
        itemCount: controller.listFilter.length,
        itemBuilder: (c, i) {
          return GestureDetector(
            onTap: (){
              controller.onSelectFilter(controller.listFilter[i]);
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Text(
                    controller.listFilter[i].statusName ?? '',
                    style: TextStyleResource.textStyleBlack(context),
                  ),
                  const Spacer(flex: 1,),
                  Obx((){
                    return Visibility(
                      visible: controller.listFilter[i].isSelected.value,
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
