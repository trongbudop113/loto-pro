
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/profile/page_manager/edit_page_manager/edit_page_manager_controller.dart';
import 'package:loto/src/style_resource.dart';

class EditPageManagerPage extends GetView<EditPageManagerController> {
  const EditPageManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            visible: !controller.isModeAddNew.value,
            child: GestureDetector(
              onTap: (){
                controller.deleteDocument();
              },
              child: Container(
                width: 55,
                color: Colors.transparent,
                child: Icon(Icons.delete, color: Colors.red,),
              ),
            ),
          ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                _loadBlockIcon(),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: (){
                      controller.onChangeBlockIcon();
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.black45,
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Kích thước 128 x 128",
                style: TextStyleResource.textStyleBlack(context),
              ),
            ),
            SizedBox(height: 15,),
            Obx((){
              return Visibility(
                visible: controller.isModeAddNew.value,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  height: 50,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.listBlockPage.length,
                    itemBuilder: (c, i){
                      return GestureDetector(
                        onTap: (){
                          controller.onSelectBlockName(i);
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.amber,
                            border: Border.all(
                              width: 1.5,
                              color: controller.currentIndex.value == i ? Colors.black : Colors.transparent,
                            )
                          ),
                          child: Text(
                            controller.listBlockPage[i].nameBlock ?? '',
                            style: TextStyleResource.textStyleBlack(context),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (c, i){
                      return SizedBox(width: 10,);
                    },
                  ),
                ),
              );
            }),
            SizedBox(height: 15,),
            Obx((){
              if((controller.currentBlockPage.value.idCollection ?? []).isEmpty){
                return const SizedBox();
              }
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                height: 50,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount:(controller.currentBlockPage.value.idCollection ?? []).length,
                  itemBuilder: (c, i){
                    return GestureDetector(
                      onTap: (){
                        controller.onSelectCollectionID(i);
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.teal,
                            border: Border.all(
                              width: 1.5,
                              color: controller.currentCollectionIndex.value == i ? Colors.black : Colors.transparent,
                            )
                        ),
                        child: Text(
                          (controller.currentBlockPage.value.idCollection ?? [])[i],
                          style: TextStyleResource.textStyleBlack(context),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (c, i){
                    return const SizedBox(width: 10,);
                  },
                ),
              );
            }),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Obx(() => Column(
                children: [
                  SizedBox(height: 15,),
                  Container(
                    height: 50,
                    child: TextField(
                      controller: controller.blockNameController,
                      decoration: const InputDecoration(
                          labelText: "Tên màn hình",
                          labelStyle: TextStyle(
                              height: 1.5
                          ),
                          contentPadding: EdgeInsets.only(top: 10)
                      ),
                      onChanged: (text) {

                      },
                    ),
                  ),
                  SizedBox(height: 15,),
                  TextField(
                    controller: controller.blockPageController,
                    decoration: const InputDecoration(
                        labelText: "Tên đường dẫn",
                        labelStyle: TextStyle(
                            height: 1.5
                        ),
                        contentPadding: EdgeInsets.only(top: 10)
                    ),
                    onChanged: (text) {

                    },
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
                          controller.onChangShowHideBlock(value);
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
                          controller.onChangRequireLogin(value);
                        },
                      ),
                    ],
                  ),
                ],
              )),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: GestureDetector(
          onTap: (){
            controller.onCreateOrUpdateBlockPage();
          },
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(60,)
            ),
            alignment: Alignment.center,
            child: Obx(() => Text(controller.isModeAddNew.value ? "Tạo mới" : "Cập nhật")),
          ),
        ),
      ),
    );
  }

  Widget _loadBlockIcon(){
    return AspectRatio(
      aspectRatio: 1,
      child: Obx((){
        if(controller.imageUserPick.value.type == null){
          return Container(
            color: Colors.grey,
          );
        }
        if(controller.imageUserPick.value.type == 1){
          return Image.network(controller.imageUserPick.value.imagePath ?? '');
        }else{
          return Image.memory(controller.imageUserPick.value.localPath!);
        }
      }),
    );
  }

}