import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/models/user_login.dart';
import 'package:loto/page/room/model/room_model.dart';
import 'package:loto/page/select/models/select_paper.dart';
import 'package:loto/page_config.dart';

class SelectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SelectController());
  }
}

class SelectController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isModeManager = false;

  CollectionReference userCollection =
      FirebaseFirestore.instance.collection(DataRowName.Users.name);
  CollectionReference paperCollection =
      FirebaseFirestore.instance.collection(DataRowName.Papers.name);

  //String userID = FirebaseAuth.instance.currentUser!.uid;
  String userEmail = FirebaseAuth.instance.currentUser!.email ?? '';

  List<SelectPaper> listSelected = [];

  UserLogin? userLogin;

  final RxBool isAdmin = false.obs;

  SelectPaper covertData(Map<String, dynamic> data) {
    return SelectPaper.fromJson(data);
  }

  int convertColor(String color) {
    return int.parse(color);
  }

  Stream<QuerySnapshot<Object?>> streamGetPapers() {
    CollectionReference roomRef = firestore.collection(DataRowName.Papers.name);

    return roomRef.snapshots();
  }

  void onPlayGame() {
    Get.toNamed(PageConfig.HOME, arguments: [listSelected, roomID]);
  }

  void goToManager() {
    isModeManager = !isModeManager;
  }

  void goToAddPaper() {
    Get.toNamed(PageConfig.MANAGER);
  }

  void goToCallNumber() {
    if (roomID.isEmpty) return;
    Get.toNamed(PageConfig.CALL, arguments: roomID);
  }

  List<String> yourPicked = [];

  Future<void> onSelectPaper(SelectPaper selectPaper) async {
    String userID = userLogin?.uuid ?? '';
    String userName = userLogin?.name ?? '';
    if (yourPicked.length == 2 && !yourPicked.contains(selectPaper.paperID)) {
      print("ko dc add thêm");
      return;
    }
    if ((selectPaper.selectedName ?? "").isNotEmpty &&
        userID != selectPaper.selectedUserID) {
      return;
    }

    if ((userLogin?.listPaper ?? []).isEmpty) {
      userLogin?.listPaper = [];
    }
    if ((selectPaper.selectedUserID ?? '').isNotEmpty) {
      if (selectPaper.selectedUserID == userID) {
        await paperCollection
            .doc(selectPaper.paperID)
            .update({"selectedName": "", "selectedUserID": ""});
      }

      yourPicked.remove(selectPaper.paperID ?? '');
      listSelected
          .removeWhere((element) => element.paperID == selectPaper.paperID);
      if (userLogin!.listPaper!.contains(selectPaper.paperID ?? '')) {
        userLogin!.listPaper!.remove(selectPaper.paperID ?? '');
      }

      print(userLogin!.toJson());
      await userCollection.doc(userEmail).update(userLogin!.toJson());
    } else {
      yourPicked.add(selectPaper.paperID ?? '');
      listSelected.add(selectPaper);
      userLogin!.listPaper!.add(selectPaper.paperID ?? '');

      await paperCollection
          .doc(selectPaper.paperID)
          .update({"selectedName": userName, "selectedUserID": userID});
      print(userLogin!.toJson());
      await userCollection.doc(userEmail).update(userLogin!.toJson());
    }
  }

  void onEditPaper(SelectPaper data) {
    if (isModeManager) {
      Get.toNamed(PageConfig.MANAGER, arguments: data);
    }
  }

  @override
  void onInit() {
    checkAndRemovePaper();
    getRoomData();
    super.onInit();
  }

  late String roomID;

  void getRoomData() {
    roomID = Get.arguments as String;
  }

  checkAndRemovePaper() async {
    var userCollect = await userCollection.doc(userEmail).get();
    var userData = userCollect.data() as Map<String, dynamic>;
    userLogin = UserLogin.fromJson(userData);
    if (userLogin?.isAdmin ?? false) {
      isAdmin.value = true;
    }

    List<String> listPaper = userLogin?.listPaper ?? [];
    if (listPaper.isEmpty) {
      return;
    }
    for (String item in listPaper) {
      if (userLogin!.listPaper!.contains(item)) {
        //userLogin!.listPaper!.remove(item);
        await paperCollection
            .doc(item)
            .update({"selectedName": "", "selectedUserID": ""});
      }
    }
    userLogin?.listPaper = [];
    await userCollection.doc(userEmail).update(userLogin!.toJson());
  }

  @override
  void onClose() {
    removeCurrentRoom();
    super.onClose();
  }

  Future<void> removeCurrentRoom() async {
    CollectionReference userCollection =
        firestore.collection(DataRowName.Users.name);
    CollectionReference roomCollection =
        firestore.collection(DataRowName.Rooms.name);
    String userEmail = FirebaseAuth.instance.currentUser?.email ?? '';
    String userID = FirebaseAuth.instance.currentUser?.uid ?? '';

    var room = roomCollection.doc(roomID);

    var roomData = await room.get();
    RoomModel roomModel =
        RoomModel.fromJson(roomData.data() as Map<String, dynamic>);
    if ((roomModel.listUser ?? []).contains(userID)) {
      roomModel.listUser!.remove(userID);
    }

    await userCollection.doc(userEmail).update({"joinRoomID": ""});

    await room.update({"listUser": roomModel.listUser});
    checkAndRemovePaper();
  }
}
