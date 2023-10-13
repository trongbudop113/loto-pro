import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/models/user_login.dart';
import 'package:loto/page/chat/chat_list_controller.dart';
import 'package:loto/src/style_resource.dart';

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
                        child: Obx(() => Container(
                          width: 40,
                          height: 40,
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: Text(
                              controller.nameUser.value.substring(0, 1),
                              style: TextStyleResource.textStyleBlack(context)
                          ),
                        )),
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
                          child: Text(
                              "T", style: TextStyleResource.textStyleBlack(context),
                          ),
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
                      child: StreamBuilder<QuerySnapshot>(
                        stream: controller.streamGetListUser(),
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            return ListView.separated(
                                padding: EdgeInsets.zero.copyWith(bottom: 70),
                                itemBuilder: (c, i){
                                  UserLogin user = UserLogin.fromJson(snapshot.data!.docs[i].data() as Map<String, dynamic>);
                                  return GestureDetector(
                                    onTap: (){
                                      controller.goToChatDetail(user);
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
                                              child: Text(
                                                  (user.name ?? "U").substring(0, 1).toUpperCase(), style: TextStyleResource.textStyleBlack(context)
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(user.name.toString(), style: TextStyleResource.textStyleBlack(context).copyWith(fontWeight: FontWeight.bold)),
                                              const SizedBox(height: 5),
                                              _getContentChatUser(user, context)
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
                                itemCount: snapshot.data!.docs.length
                            );
                          }else{
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
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

  Widget _getContentChatUser(UserLogin user, BuildContext context){
    return StreamBuilder<QuerySnapshot>(
      stream: controller.streamGetContentListUser(user.uuid ?? ''),
      builder: (c, snapshot){
        if(snapshot.hasData){
          String content = "";
          String whoChat = "";
          if(snapshot.data!.docs.isNotEmpty){
            var chatUser = controller.parseChatData(snapshot.data!.docs[0].data() as Map<String, dynamic>);
            content = chatUser.content ?? '';
            if(chatUser.fromId == controller.currentUserID){
              whoChat = "Bạn: ";
            }else{
              whoChat = "${user.name ?? ''}: ";
            }
          }
          return Text("$whoChat ${content.toString()}", style: TextStyleResource.textStyleBlack(context));
        }else{
          return Text("...", style: TextStyleResource.textStyleBlack(context));
        }
      },
    );
  }
}