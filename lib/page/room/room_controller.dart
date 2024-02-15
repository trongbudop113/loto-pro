import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:loto/common/common.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/models/user_login.dart';
import 'package:loto/page/room/model/room_model.dart';
import 'package:loto/page_config.dart';

class RoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RoomController());
  }
}

class RoomController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    checkLogin();
    super.onInit();
  }

  Future<void> checkLogin() async {
    if (AppCommon.singleton.isLogin) {
      checkExistedInRoom();
    } else {
      await Get.toNamed(PageConfig.LOGIN);
      checkExistedInRoom();
    }
  }

  Future<void> checkExistedInRoom() async {
    String userEmail = FirebaseAuth.instance.currentUser?.email ?? '';
    if (userEmail.isEmpty) {
      Get.offAllNamed(PageConfig.LANDING);
      return;
    }
    CollectionReference userCollection =
        firestore.collection(DataRowName.Users.name);
    var userData = await userCollection.doc(userEmail).get();
    UserLogin userLogin =
        UserLogin.fromJson(userData.data() as Map<String, dynamic>);
    if ((userLogin.joinRoomID ?? '').isNotEmpty) {
      Get.toNamed(PageConfig.SELECT, arguments: userLogin.joinRoomID);
    }
  }

  Stream<QuerySnapshot<Object?>> streamGetRoom() {
    CollectionReference roomRef = firestore.collection(DataRowName.Rooms.name);

    return roomRef.snapshots();
  }

  RoomModel covertData(Map<String, dynamic> data) {
    return RoomModel.fromJson(data);
  }

  Future<void> createRoom() async {
    try {
      CollectionReference roomCollection =
          firestore.collection(DataRowName.Rooms.name);
      var docID = DateTime.now().millisecondsSinceEpoch;
      var user = FirebaseAuth.instance.currentUser;

      RoomModel roomModel = RoomModel();
      roomModel.createDate = docID;
      roomModel.passWordRoom = "";
      roomModel.roomName = "Phòng của ${user?.displayName ?? ''}";
      roomModel.roomID = docID;
      roomModel.adMinID = user?.uid;
      roomModel.listUser = [];

      await roomCollection
          .doc(docID.toString())
          .set(roomModel.toJson())
          .then((value) {
        joinRoom(roomModel);
      });
    } catch (e) {
      e.printInfo(info: "createRoom");
    }
  }

  Future<void> joinRoom(RoomModel roomModel) async {
    try {
      CollectionReference roomCollection =
          firestore.collection(DataRowName.Rooms.name);
      CollectionReference userCollection =
          firestore.collection(DataRowName.Users.name);
      String userID = FirebaseAuth.instance.currentUser!.uid;
      String userEmail = FirebaseAuth.instance.currentUser!.email!;
      var room = roomCollection.doc(roomModel.roomID.toString());
      List<String> listUser = roomModel.listUser ?? [];
      if (!listUser.contains(userID)) {
        listUser.add(userID);
      }

      await room.update({"listUser": listUser});

      await userCollection
          .doc(userEmail)
          .update({"joinRoomID": roomModel.roomID.toString()});

      Get.toNamed(PageConfig.SELECT, arguments: roomModel.roomID.toString());
    } catch (e) {
      e.printInfo(info: "joinRoom");
    }
  }
}
