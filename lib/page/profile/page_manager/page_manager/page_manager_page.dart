import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/landing/models/block_menu.dart';
import 'package:loto/page/profile/model/block_page.dart';
import 'package:loto/page/profile/page_manager/page_manager/page_manager_controller.dart';
import 'package:loto/src/style_resource.dart';

class PageManagerPage extends GetView<PageManagerController> {
  const PageManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("page_manager".tr),
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
          GestureDetector(

            child: Container(
              width: 55,
              color: Colors.transparent,
              child: Icon(Icons.add,),
            ),
          )
        ],
      ),

      body:  StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.getAllMenu(),
        builder: (c, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.separated(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (c, i){

              BlockPage blockPage = BlockPage.fromJson(
                  snapshot.data!.docs[i].data() as Map<String, dynamic>);

              return Column(
                children: [
                  Container(
                    color: Colors.tealAccent,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 15,
                    ),
                    child: Text(
                      "${blockPage.idBlock} - ${blockPage.nameBlock}",
                      style: TextStyleResource.textStyleBlack(context),
                    ),
                  ),
                  SizedBox(height: 10,),
                  ...blockPage.listChildMenu.map((blockChild){
                    return StreamBuilder<QuerySnapshot<Object?>>(
                      stream: blockChild.childMenuStream,
                      builder: (context, snapshotChild) {
                        if (!snapshotChild.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return ListView.separated(
                          itemCount: snapshotChild.data!.docs.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(bottom: 10),
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (c, i){
                            //print(snapshotChild.data!.docs[i].data());
                            BlockMenu blockMenu = BlockMenu.fromJson(
                                snapshotChild.data!.docs[i].data() as Map<String, dynamic>);

                            return GestureDetector(
                              onTap: (){
                                controller.goToEditPage(
                                    snapshotChild : snapshotChild.data!.docs[i],
                                  idBlock: blockPage.idBlock ?? '',
                                  idCollection: blockChild.collectionID ?? ''
                                );
                              },
                              child: Container(
                                  color: Colors.brown,
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${blockMenu.blockName}".tr,
                                        style: TextStyleResource.textStyleBlack(context),
                                      ),
                                      Spacer(flex: 1,),
                                      Switch(
                                        value: blockMenu.isShow ?? false,
                                        onChanged: (value){
                                          controller.onHideShowBlockQuick(
                                              value,
                                              docName: blockPage.idBlock ?? '',
                                              collectionName: blockChild.collectionID ?? '',
                                              docChild: snapshotChild.data!.docs[i].reference.id
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(Icons.arrow_forward_ios_rounded, size: 20,)
                                    ],
                                  )
                              ),
                            );
                          },
                          separatorBuilder: (c, i){
                            return SizedBox(height: 10,);
                          },
                        );
                      },
                    );
                  }).toList()
                ],
              );
            },
            separatorBuilder: (c, i){
              return SizedBox(height: 10,);
            },
          );
        },
      )
    );
  }
}