import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/landing/body/border_widget.dart';
import 'package:loto/page/landing/landing_controller.dart';
import 'package:loto/page/landing/models/block_menu.dart';
import 'package:loto/src/style_resource.dart';

class BlockGame extends GetView<LandingController> {
  const BlockGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: controller.streamGetGame(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "game".tr,
                      style: TextStyleResource.textStyleCaption(context).copyWith(fontSize: 25),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: (snapshot.data?.size ?? 0) + (8 - (snapshot.data?.size ?? 0)),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 1
                    ),
                    itemBuilder: (BuildContext context, int index) {

                      if(index <= (snapshot.data!.size - 1)){
                        final BlockMenu gameMenu = BlockMenu.fromJson(snapshot.data?.docs[index].data() as Map<String, dynamic>);
                        return GestureDetector(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: BorderWidget(
                              margin: EdgeInsets.zero,
                              child: Image.network(gameMenu.blockIcon ?? '', fit: BoxFit.fill),
                            ),
                          ),
                          onTap: (){
                            controller.goToRoomPage(gameMenu.page ?? "");
                          },
                        );
                      }
                      return const BorderWidget(
                        margin: EdgeInsets.zero,
                        child: Icon(Icons.add, size: 50),
                      );
                    },
                  )
                ],
              ),
            );
          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
    );
  }
}