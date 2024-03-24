
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/profile/page_manager/edit_page_manager/edit_page_manager_controller.dart';
import 'package:loto/src/style_resource.dart';

class EditPageManagerPage extends GetView<EditPageManagerController> {
  const EditPageManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Image.network(controller.blockPage.value.blockIcon ?? ''),
          ),
          SizedBox(height: 15,),
          Text(
            (controller.blockPage.value.blockName ?? '').tr,
            style: TextStyleResource.textStyleBlack(context)?.copyWith(
              fontSize: 30,
            ),
          ),
          SizedBox(height: 15,),
          Row(
            children: [
              Text(
                "Hiện trên menu:",
                style: TextStyleResource.textStyleBlack(context),
              ),
              SizedBox(width: 10,),
              Switch(
                value: controller.blockPage.value.isShow ?? false,
                onChanged: (value){

                },
              ),
            ],
          ),
          SizedBox(height: 15,),
          Row(
            children: [
              Text(
                "Yêu cầu đăng nhập:",
                style: TextStyleResource.textStyleBlack(context),
              ),
              SizedBox(width: 10,),
              Switch(
                value: controller.blockPage.value.isRequireLogin ?? false,
                onChanged: (value){

                },
              ),
            ],
          ),
        ],
      )),
    );
  }

}