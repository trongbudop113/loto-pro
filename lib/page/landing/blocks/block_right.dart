import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/landing/body/border_widget.dart';
import 'package:loto/page/landing/landing_controller.dart';
import 'package:loto/page/landing/models/block_menu.dart';

class BlockRight extends GetView<LandingController> {
  const BlockRight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: controller.streamGetBlockRight(),
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
                       child: Text(menu.blockName ?? ''),
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
                     child: Text(menu.blockName ?? ''),
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
