import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/landing/body/border_widget.dart';
import 'package:loto/page/landing/landing_controller.dart';
import 'package:loto/page/landing/models/block_menu.dart';

class BlockLeft extends GetView<LandingController> {
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
                if(menu.blockType == 2){
                  return AspectRatio(
                    aspectRatio: 4,
                    child: BorderWidget(
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

  Widget test(){
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: BorderWidget(
            color: Colors.amber,
            child: Container(),
          ),
        ),
        SizedBox(height: 16),
        AspectRatio(
          aspectRatio: 2,
          child: Row(
            children: [
              Expanded(
                child: BorderWidget(
                  color: Colors.greenAccent,
                  child: Container(),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: BorderWidget(
                  color: Colors.black,
                  child: Container(),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        AspectRatio(
            aspectRatio: 2,
            child: BorderWidget(
              color: Colors.white,
              child: Container(),
            )
        ),
        SizedBox(height: 16),
        AspectRatio(
            aspectRatio: 2,
            child: BorderWidget(
              color: Colors.white,
              child: Container(),
            )
        )
      ],
    );
  }
}