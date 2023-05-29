import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/chat/chat_detail_controller.dart';

class ChatDetailPage extends GetView<ChatDetailController>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.black,
              ),
            ),
            Column(
              children: [
                Obx(() => AnimatedOpacity(
                  opacity: controller.isShowChatMenu.value ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    height: controller.isShowChatMenu.value ? 30 : 0,
                    color: Colors.amber,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (c, i){
                        return Container(
                          width: Get.width / 4,
                          height: 30,
                          child: Icon(Icons.add),
                        );
                      },
                      separatorBuilder: (c, i){
                        return Container(width: 1, color: Colors.black);
                      },
                      itemCount: 5
                    ),
                  ),
                )),
                Container(
                  height: 50,
                  child: Row(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.pink,
                          alignment: Alignment.center,
                          child: Icon(Icons.add),
                        ),
                        onTap: (){
                          controller.onTapMenu();
                        },
                      ),
                      Expanded(
                        child: TextField(),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}