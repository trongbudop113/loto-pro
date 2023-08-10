import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:loto/page/room/room_controller.dart';
import 'package:loto/src/style_resource.dart';

class RoomPage extends GetView<RoomController>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Spacer(flex: 1),
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  controller.createRoom();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Row(
                    children: [
                      Icon(Icons.add, color: Colors.blue),
                      SizedBox(width: 5),
                      Text("Tạo phòng", style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(width: 20)
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.streamGetRoom(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.active) {
            var roomList = snapShot.data?.docs ?? [];
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: roomList.length,
              itemBuilder: (c, i){
                var data = controller.covertData(roomList[i].data() as Map<String, dynamic>);
                return GestureDetector(
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        Visibility(
                          visible: (data.listUser ?? []).isNotEmpty,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Text(
                                "Số người ${(data.listUser ?? []).length}",
                                style: TextStyleResource.textStyleBlack(context)
                            ),
                          ),
                        ),
                        Text(
                            data.roomName ?? '',
                            style: TextStyleResource.textStyleCaption(context).copyWith(fontSize: 20)
                        ),
                        const SizedBox(height: 10),
                        const Divider(thickness: 2),
                      ],
                    ),
                  ),
                  onTap: (){
                    controller.joinRoom(data);
                  },
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

}