import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/hpbd/hpbd_controller.dart';
import 'package:loto/src/style_resource.dart';

class GiftLayout extends StatelessWidget {
  final HPBDController controller;
  const GiftLayout({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 370,
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
        child: Column(
          children: [
            Image.network(controller.mainData.value.image ?? '', width: 120, height: 120),
            SizedBox(height: 25),
            Text(
              controller.content,
              textAlign: TextAlign.center,
              style: TextStyleResource.textStyleBlack(context).copyWith(
                  decoration: TextDecoration.none,
                  height: 1.5,
                  fontSize: 19
              ),
            ),
            Spacer(flex: 1),

            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Container(
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.amber
                ),
                child: Text(
                  controller.contentButton,
                  style: TextStyleResource.textStyleWhite(context).copyWith(
                      decoration: TextDecoration.none
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
