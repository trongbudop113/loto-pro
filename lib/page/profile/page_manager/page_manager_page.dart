import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/profile/page_manager/page_manager_controller.dart';
import 'package:loto/src/style_resource.dart';

class PageManagerPage extends GetView<PageManagerController> {
  const PageManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
        itemCount: controller.listBlock.length,
        itemBuilder: (c, i){
          return Column(
            children: [
              Container(
                color: Colors.tealAccent,
                padding: const EdgeInsets.symmetric(
                  vertical: 15, horizontal: 15,
                ),
                child: Text(
                  "${controller.listBlock[i].blockCollection} - ${controller.listBlock[i].blockName}",
                  style: TextStyleResource.textStyleBlack(context),
                ),
              ),

            ],
          );
        },
        separatorBuilder: (c, i){
          return SizedBox(height: 10,);
        },
      ),
    );
  }
}