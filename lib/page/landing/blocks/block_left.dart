import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/landing/blocks/block_item_base.dart';
import 'package:loto/page/landing/body/border_widget.dart';
import 'package:loto/page/landing/landing_controller.dart';
import 'package:loto/page/landing/models/block_menu.dart';

class BlockLeft extends GetView<LandingController> with BlockItemBase {
  const BlockLeft({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: controller.streamGetBlockLeft(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return Column(
              children: snapshot.data!.docs.map((e) {
                BlockMenu menu = BlockMenu.fromJson(e.data() as Map<String, dynamic>);
                if(!(menu.isShow ?? false)){
                  return const SizedBox();
                }
                if(menu.blockType == 2){
                  return AspectRatio(
                    aspectRatio: 4,
                    child: BorderWidget(
                      onTap: (){
                        controller.onClickItemBlock(menu.page ?? '', argument: menu.blockID!);
                      },
                      color: Colors.amber,
                      child: Container(
                        alignment: Alignment.center,
                        child: buildBlockItem(context, menu),
                      ),
                    ),
                  );
                }
                return AspectRatio(
                  aspectRatio: 2,
                  child: BorderWidget(
                    onTap: (){
                      controller.onClickItemBlock(menu.page ?? '', argument: menu.blockID!);
                    },
                    color: Colors.amber,
                    child: Container(
                      alignment: Alignment.center,
                      child: buildBlockItem(context, menu),
                    ),
                  ),
                );
              }).toList(),
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