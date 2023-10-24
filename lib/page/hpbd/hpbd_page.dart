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
      appBar: AppBar(
        title: Text("Tèn tén ten"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Obx((){
          return Visibility(
            visible: !controller.isLoading.value,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 15),
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
                  SizedBox(height: 25),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "Tiết mục nhận quà nè, hehe",
                        style: TextStyleResource.textStyleBlack(context).copyWith(fontSize: 20, fontWeight: FontWeight.bold)
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: (){

                          },
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                controller.mainData.value.image != null ?
                                Image.network(controller.mainData.value.image ?? '') : Container(),
                                SizedBox(height: 15),
                                Text(
                                    "Nhận quà 1",
                                    style: TextStyleResource.textStyleBlack(context).copyWith(fontSize: 18)
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){

                          },
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                controller.mainData.value.image != null ?
                                Image.network(controller.mainData.value.image ?? '') : Container(),
                                SizedBox(height: 15),
                                Text(
                                    "Nhận quà 2",
                                    style: TextStyleResource.textStyleBlack(context).copyWith(fontSize: 18)
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
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