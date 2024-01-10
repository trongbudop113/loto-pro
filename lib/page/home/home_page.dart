import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/call_number/model/call_number_data.dart';
import 'package:loto/page/home/home_controller.dart';
import 'package:loto/src/style_resource.dart';

class HomePage extends GetView<HomeController>{

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            child: Container(
              width: 55,
              color: Colors.transparent,
              child: const Icon(Icons.info_outline, color: Colors.black),
            ),
            onTap: (){
              controller.onCheckResult();
            },
          ),
          SizedBox(width: 10,),
          GestureDetector(
            child: Container(
              width: 55,
              color: Colors.transparent,
              child: const Icon(Icons.refresh, color: Colors.black),
            ),
            onTap: (){
              controller.onRefreshData();
            },
          )
        ],
      ),
      body: Column(
        children: [
          buildCallNumber(context),
          Expanded(
            child: buildContent(context),
          )
        ],
      ),
    );
  }

  Widget buildCallNumber(BuildContext context){
    return StreamBuilder<DocumentSnapshot<Object?>>(
      stream: controller.streamGetDataRoom(),
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.active) {
          var numberData = CallNumberData.fromJson(snapShot.data?.data() as Map<String, dynamic>);
          return Container(
            height: 50,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(numberData.currentNumber ?? '', style: TextStyleResource.textStyleBlack(context).copyWith(fontSize: 20)
                )
              ],
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget buildContent(BuildContext context){
    return Obx(() => Visibility(
        visible: controller.isHasData.value,
        child: SingleChildScrollView(
          child: Column(
            children: controller.listData.asMap().entries.map((parent) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    color: Colors.black38,
                    alignment: Alignment.center,
                    child: Text(" Tờ ${parent.key + 1}", style: TextStyleResource.textStyleBlack(context).copyWith(fontSize: 15)),
                  ),
                  CustomScrollView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      slivers: (parent.value.papers ?? []).asMap().entries.map((e) {
                        if(e.value.typeFull ?? true){
                          return const SliverPadding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                          );
                        }else{
                          return SliverGrid.count(
                              crossAxisCount: 9,
                              childAspectRatio: 0.5,
                              children: (e.value.items ?? []).asMap().entries.map((child) {
                                return GestureDetector(
                                  onTap: (){
                                    controller.onTapNumber(parent.key, e.key, child.key);
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: child.value.number == 0 ? Color(controller.convertColor(parent.value.color ?? '')) : Colors.white,
                                            border: Border.all(width: 0.5)
                                        ),
                                        alignment: Alignment.center,
                                        child: Visibility(
                                          visible: (child.value.number ?? 0) > 0,
                                          child: Text(
                                              (child.value.number ?? 0).toString(),
                                            style: TextStyleResource.textStyleBlack(context),
                                          ),
                                        ),
                                      ),
                                      Obx(() => Visibility(
                                        visible: child.value.isCheck.value,
                                        child: Positioned(
                                          top: 0,
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(Radius.circular(360)),
                                                    border: Border.all(
                                                        width: 3,
                                                        color: Colors.red
                                                    )
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ))
                                    ],
                                  ),
                                );
                              }).toList()
                          );
                        }
                      }).toList()
                  )
                ],
              );
            }).toList(),
          ),
        )
    ));
  }
}

