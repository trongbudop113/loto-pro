import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/hpbd/hpbd_controller.dart';
import 'package:loto/page/hpbd/models/hpbd_data.dart';
import 'package:loto/src/style_resource.dart';

class HPBDPage extends GetView<HPBDController>{
  const HPBDPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Obx((){
          return Visibility(
            visible: !controller.isLoading.value,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  controller.mainData.value.title ?? '',
                  style: TextStyleResource.textStyleBlack(context).copyWith(fontSize: 25, fontWeight: FontWeight.bold)
                ),
                SizedBox(height: 10),
                (controller.mainData.value.contents?? []).isNotEmpty ?
                Column(
                  children: (controller.mainData.value.contents ?? []).map((e){
                    return Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Visibility(
                        visible: e.type == 1,
                        child: Text(
                            e.text ?? '',
                            style: TextStyleResource.textStyleBlack(context).copyWith(fontSize: 18, height: 1.3)
                        ),
                        replacement: Image.network(
                          e.text ?? '',
                          width: 200,
                          height: 200,
                        )
                      ),
                    );
                  }).toList(),
                ) : Container(),
              ],
            ),
            replacement: Center(
              child: Container(
                width: 300,
                height: 300,
                child: controller.imageWaiting,
              ),
            ),
          );
        }),
      )
    );
  }

}