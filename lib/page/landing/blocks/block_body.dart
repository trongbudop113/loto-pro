import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loto/page/landing/blocks/block_item_base.dart';
import 'package:loto/page/landing/landing_controller.dart';
import 'package:get/get.dart';
import 'package:loto/page/landing/models/block_menu.dart';
import 'package:loto/src/style_resource.dart';

class BlockBody extends GetView<LandingController> with BlockItemBase {
  BlockBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40),
        Text("Tiện Ích", style: TextStyleResource.textStyleBlack(context).copyWith(fontSize: 25, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        StreamBuilder<QuerySnapshot>(
            stream: controller.streamGetBlockBody(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    BlockMenu menu = BlockMenu.fromJson(snapshot.data!.docs[index].data() as Map<String, dynamic>);
                    return GestureDetector(
                      onTap: (){
                        controller.onClickBlockBody();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.deepPurple[300],
                          height: 120,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text((menu.blockName ?? '').tr)
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }else{
                return CircularProgressIndicator();
              }
            }
        )
      ],
    );;
  }
}
