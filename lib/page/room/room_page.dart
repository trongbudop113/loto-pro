import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:loto/page/room/room_controller.dart';

class RoomPage extends GetView<RoomController>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Spacer(flex: 1),
          Row(
            children: [
              Container(
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
              )
            ],
          ),
          SizedBox(width: 20)
        ],
      ),
      body: Container(),
    );
  }

}