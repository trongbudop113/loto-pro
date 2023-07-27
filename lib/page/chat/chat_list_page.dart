import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/chat/chat_list_controller.dart';

class ChatListPage extends GetView<ChatListController>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(360),
                          child: Container(
                            width: 40,
                            height: 40,
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: const Icon(Icons.arrow_back_ios),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(360),
                        child: Container(
                          width: 40,
                          height: 40,
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: Text("T"),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 60,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (c, i){
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(360),
                        child: Container(
                          width: 60,
                          height: 60,
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: Text("T"),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width: 10);
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                    ),
                    child: Container(
                      color: Colors.white,
                      child: ListView.separated(
                        padding: EdgeInsets.zero.copyWith(bottom: 70),
                        itemBuilder: (c, i){
                          return GestureDetector(
                            onTap: (){
                              controller.goToChatDetail();
                            },
                            child: Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(360),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      color: Colors.grey,
                                      alignment: Alignment.center,
                                      child: Text("T"),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Title", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                      SizedBox(height: 5),
                                      Text("Content", style: TextStyle(fontSize: 16))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (c, i){
                          return Container(
                            margin: EdgeInsets.only(left: 60),
                            height: 1,
                            color: Colors.grey,
                          );
                        },
                        itemCount: 20
                      ),
                    )
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 10,
              left: 5,
              right: 5,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: Colors.black
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}