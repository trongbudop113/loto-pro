import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/models/user_login.dart';
import 'package:loto/page/room/model/room_model.dart';
import 'package:loto/page_config.dart';

class RoomBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => RoomController());
  }
}

class RoomController extends GetxController {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    checkExistedInRoom();
    super.onInit();
  }

  Future<void> checkExistedInRoom() async {
    CollectionReference userCollection = firestore.collection(DataRowName.Users.name);
    String userEmail = FirebaseAuth.instance.currentUser!.email!;
    var userData = await userCollection.doc(userEmail).get();
    UserLogin userLogin = UserLogin.fromJson(userData.data() as Map<String, dynamic>);
    if((userLogin.joinRoomID ?? '').isNotEmpty){
      Get.toNamed(PageConfig.SELECT);
    }
  }

  Stream<QuerySnapshot<Object?>> streamGetRoom() {
    CollectionReference roomRef = firestore.collection(DataRowName.Rooms.name);

    return roomRef.snapshots();
  }

  RoomModel covertData(Map<String, dynamic> data){
    return RoomModel.fromJson(data);
  }

  Future<void> createRoom() async {
    try{
      CollectionReference roomCollection = firestore.collection(DataRowName.Rooms.name);
      var docID = DateTime.now().millisecondsSinceEpoch;
      var user = FirebaseAuth.instance.currentUser;

      RoomModel roomModel = RoomModel();
      roomModel.createDate = docID;
      roomModel.passWordRoom = "";
      roomModel.roomName = "Phòng của ${user?.displayName ?? ''}";
      roomModel.roomID = docID;
      roomModel.adMinID = user?.uid;
      roomModel.listUser = [];

      await roomCollection.doc(docID.toString()).set(roomModel.toJson()).then((value) {
        joinRoom(roomModel);
      });
    }catch(e){
      e.printInfo(info: "createRoom");
    }
  }

  Future<void> joinRoom(RoomModel roomModel) async {
    try{
      CollectionReference roomCollection = firestore.collection(DataRowName.Rooms.name);
      CollectionReference userCollection = firestore.collection(DataRowName.Users.name);
      String userID = FirebaseAuth.instance.currentUser!.uid;
      String userEmail = FirebaseAuth.instance.currentUser!.email!;
      await roomCollection.doc(roomModel.roomID.toString()).update({
        "listUser" : [userID]
      });

      await userCollection.doc(userEmail).update({
        "joinRoomID" : roomModel.roomID.toString()
      });

      Get.toNamed(PageConfig.SELECT);
    }catch(e){
      e.printInfo(info: "joinRoom");
    }
  }

}