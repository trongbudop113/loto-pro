import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/landing/blocks/block_item_base.dart';
import 'package:loto/page/landing/body/border_widget.dart';
import 'package:loto/page/landing/landing_controller.dart';
import 'package:loto/page/landing/models/block_menu.dart';
import 'package:loto/responsive/dimensions.dart';

class BlockLeft extends GetView<LandingController> with BlockItemBase {
  final LayoutEnum layout;
  BlockLeft({Key? key, required this.layout}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: controller.streamGetBlockLeft(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            layoutDesign = layout;
            if(layout == LayoutEnum.mobile){
              return GridView.builder(
                shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    BlockMenu menu = BlockMenu.fromJson(snapshot.data?.docs[index].data() as Map<String, dynamic>);
                    return BorderWidget(
                      onTap: (){
                        controller.onClickItemBlock(menu.page ?? '', argument: menu.blockID!);
                      },
                      color: Colors.amber,
                      margin: EdgeInsets.zero,
                      child: Container(
                        alignment: Alignment.center,
                        child: buildBlockItem(context, menu),
                      ),
                    );
                  });
            }
            List<Widget> list = [];
            snapshot.data!.docs.map((e) {
              BlockMenu menu = BlockMenu.fromJson(e.data() as Map<String, dynamic>);
              if(!(menu.isShow ?? false)){
                list.add(const SizedBox());
              }
              if(menu.blockType == 2){
                list.add(
                    AspectRatio(
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
                    )
                );
              }else{
                list.add(
                    AspectRatio(
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
                    )
                );
              }
            }).toList();
            return Column(
              children: list,
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