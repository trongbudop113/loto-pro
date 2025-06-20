import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/home/models/item_model.dart';
import 'package:loto/page/select/models/select_paper.dart';


class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class HomeController extends GetxController {
  final RxList<SelectPaper> listData = <SelectPaper>[].obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late String roomID;

  int indexPaper = 0;
  int indexRow = 0;
  bool isWin = false;

  @override
  void onInit() {
    getArgument();
    onListenWinPlay();
    super.onInit();
  }

  void onListenWinPlay() {
    CollectionReference roomRef = firestore.collection(DataRowName.Rooms.name);

    final docRef = roomRef.doc(roomID).collection(roomID).doc(roomID);
    docRef.snapshots().listen(
      (event) {
        if (event.data()!["isWin"] == true) {
          showDialogCong(Get.context!);
        }
      },
      onError: (error) => print("Listen failed: $error"),
    );
  }

  void showDialogCong(BuildContext context) {
    // Dialogs.materialDialog(
    //   color: Colors.white,
    //   msg: 'Congratulations, you won 500 points',
    //   title: 'Congratulations',
    //   lottieBuilder: Lottie.asset(
    //     'assets/cong_example.json',
    //     fit: BoxFit.contain,
    //   ),
    //   barrierDismissible: false,
    //   dialogWidth: kIsWeb ? 0.3 : null,
    //   context: context,
    //   actions: [
    //     IconsButton(
    //       onPressed: () {
    //         Navigator.of(context).pop();
    //       },
    //       text: 'Claim',
    //       iconData: Icons.done,
    //       color: Colors.blue,
    //       textStyle: TextStyle(color: Colors.white),
    //       iconColor: Colors.white,
    //     ),
    //   ],
    // );
  }

  Stream<DocumentSnapshot<Object?>> streamGetDataRoom() {
    CollectionReference roomRef = firestore.collection(DataRowName.Rooms.name);

    return roomRef.doc(roomID).collection(roomID).doc(roomID).snapshots();
  }

  void getArgument() {
    var arguments = Get.arguments;

    listData.addAll(arguments[0] as List<SelectPaper>);
    roomID = arguments[1] as String ?? '';
  }

  Future<void>  setWinUser(bool isWin) async {
    try{
      CollectionReference roomCollection = firestore.collection(DataRowName.Rooms.name);
      await roomCollection.doc(roomID).collection(roomID).doc(roomID).update(
          {"isWin" : isWin}
      );
    }catch(e){
      e.printInfo(info: "setDefaultData");
    }
  }

  Future<void> onTapNumber(int i, int j, int k) async {
    int number = listData[i].papers![j].items![k].number ?? 0;
    if (number == 0) {
      return;
    }
    listData[i].papers![j].items![k].isCheck.value =
        !listData[i].papers![j].items![k].isCheck.value;

    int count = 0;
    for (ItemModel data in listData[i].papers![j].items ?? []) {
      if ((data.number ?? 0) > 0 && data.isCheck.value) {
        count++;
      }
    }

    if (count == 4) {
      print('wait wait wait wait');
      isWin = false;
      return;
    }

    if (count == 5) {
      indexPaper = i;
      indexRow = j;
      isWin = true;
      await setWinUser(isWin);
      return;
    }
  }

  Future<void> onHotReset() async {
    isWin = false;
    await setWinUser(isWin);
  }

  void onRefreshData() {
    for (var parent in listData) {
      for (ItemRowModel element in parent.papers ?? []) {
        if (!(element.typeFull ?? false)) {
          for (ItemModel child in element.items ?? []) {
            child.isCheck.value = false;
          }
        }
      }
    }
    isWin = false;
    indexRow = 0;
    indexPaper = 0;
  }

  RxBool get isHasData {
    return (listData.isNotEmpty).obs;
  }

  int convertColor(String color) {
    return int.parse(color);
  }

  @override
  void onClose() {
    onRefreshData();
    super.onClose();
  }

  void onCheckResult() {
    if (!isWin) {
      return;
    }
    //listData[indexPaper].papers![indexRow].items
  }
}
