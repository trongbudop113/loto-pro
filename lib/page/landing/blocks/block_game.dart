import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/landing/body/border_widget.dart';
import 'package:loto/page/landing/landing_controller.dart';

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
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: (snapshot.data?.size ?? 0) + (8 - (snapshot.data?.size ?? 0)),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 1
                ),
                itemBuilder: (BuildContext context, int index) {
                  if(index <= (snapshot.data!.size - 1)){
                    return BorderWidget(
                      margin: EdgeInsets.zero,
                      child: Icon(Icons.abc, size: 50),
                    );
                  }
                  return BorderWidget(
                    margin: EdgeInsets.zero,
                    child: Icon(Icons.add, size: 50),
                  );
                },
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