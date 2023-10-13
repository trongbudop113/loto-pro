import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loto/page/chat/chat_detail_controller.dart';
import 'package:loto/page/chat/models/chat_content_data.dart';
import 'package:loto/src/color_resource.dart';
import 'package:loto/src/style_resource.dart';

class ChatDetailPage extends GetView<ChatDetailController>{
  const ChatDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: _buildListMessage(),
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
                      child: TextField(
                        onSubmitted: (value) {
                          controller.textEditingController.text = value;
                          controller.onSendMessage(value, 0);
                        },
                        controller: controller.textEditingController,
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Type your message...',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        focusNode: controller.focusNode,
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }


  Widget _buildListMessage() {
    return Obx(() => Visibility(
      visible: controller.groupChatID.value != "",
      replacement: const Center(child: CircularProgressIndicator()),
      child: StreamBuilder<QuerySnapshot>(
        stream: controller.getListChatStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator()
            );
          } else {
            controller.listMessage.addAll(snapshot.data!.docs);
            return ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemBuilder: (context, index) {
                return _buildItem(index, snapshot.data!.docs[index], context);
              },
              itemCount: snapshot.data!.docs.length,
              reverse: true,
              controller: controller.listScrollController,
            );
          }
        },
      )
    ));
  }

  Widget _buildItem(int index, DocumentSnapshot document, BuildContext context) {
    ChatContentData chatData = controller.parseChatData(document.data() as Map<String, dynamic>);
    return Visibility(
      visible: chatData.fromId == controller.currentUserID,
      replacement: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                controller.isLastMessageLeft(index) ?
                Container(width: 35.0, height: 35, color: Colors.amber,) : Container(width: 35.0),
                chatData.type == 0 ?
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200.0,
                  decoration: BoxDecoration(color: ColorResource.color_background_dark, borderRadius: BorderRadius.circular(8.0)),
                  margin: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    chatData.content ?? '',
                    style: const TextStyle(color: Colors.white),
                  ),
                ) : chatData.type == 1 ?
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: GestureDetector(
                    child: Container(
                      width: 200,
                      height: 200,
                      child: Image.network(chatData.content ?? ''),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => FullPhoto(url: document.data()['content'], heightAppbar: heightAppbar)));
                    },
                  ),
                ) : Container(
                  margin: EdgeInsets.only(bottom: controller.isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
                  child: Image.asset(
                    'images/${chatData.content}.gif',
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            controller.isLastMessageLeft(index) ?
            Container(
              margin: const EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
              child: Text(
                DateFormat('dd MMM kk:mm')
                    .format(DateTime.fromMillisecondsSinceEpoch((chatData.timestamp ?? 0))),
                style: const TextStyle(color: Colors.grey, fontSize: 12.0, fontStyle: FontStyle.italic),
              ),
            ): Container()
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          chatData.type == 0 ?
          Container(
            padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            width: 200.0,
            decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(8.0)),
            margin: EdgeInsets.only(bottom: controller.isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
            child: Text(
              chatData.content ?? '',
              style: TextStyleResource.textStyleBlack(context),
            ),
          ) : chatData.type == 1 ?
          Container(
            margin: EdgeInsets.only(bottom: controller.isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
            child: Container(
              width: 200,
              height: 200,
              child: Image.network(chatData.content ?? ''),
            ),
          ) : Container(
            margin: EdgeInsets.only(bottom: controller.isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
            child: Image.asset(
              'images/${chatData.content ?? ''}.gif',
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}