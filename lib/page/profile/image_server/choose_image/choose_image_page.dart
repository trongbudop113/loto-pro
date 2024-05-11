import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/profile/image_server/choose_image/choose_image_controller.dart';
import 'package:loto/page/profile/image_server/choose_image/widget/image_view.dart';
import 'package:loto/src/style_resource.dart';

class ChooseImagePage extends GetView<ChooseImageController> {
  const ChooseImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("from_server".tr),
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Container(
            color: Colors.transparent,
            child: Icon(Icons.arrow_back),
          ),
        ),
        actions: [
          Obx(() => Visibility(
            visible: controller.listChooseTemp.isNotEmpty,
            child: GestureDetector(
              onTap: (){
                controller.selectDone();
              },
              child: Container(
                width: 55,
                color: Colors.transparent,
                child: const Icon(Icons.check, color: Colors.green,),
              ),
            ),
          ))
        ],
      ),
      body: _loadBody(context),
    );
  }

  Widget _loadBody(BuildContext context) {
    return Obx(
      () {
        if (controller.listImageServer.isEmpty) {
          return Center(
            child: Text(
              "Không có dữ liệu",
              style: TextStyleResource.textStyleBlack(context),
            ),
          );
        }

        return GridView.builder(
          itemCount: controller.listImageServer.length,
          itemBuilder: (context, index) {
            return ImageView(
              getFullImage: controller.listImageServer[index].imageFullPath,
              onSelectData: (value) {
                controller.onAddImageToList(value, controller.listImageServer[index]);
              },
              onRemoveSelect: (value) {
                controller.handleRemoveImage(controller.listImageServer[index]);
              },
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
          ),
        );
      },
    );
  }
}
