import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/hpbd/models/hpbd_data.dart';
import 'package:loto/page/hpbd/widgets/gift_layout.dart';

class HPBDBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HPBDController());
  }
}

class HPBDController extends GetxController {

  final Color bgColor = Colors.deepPurple[200]!;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Rx<HPBDData> mainData = HPBDData().obs;

  RxBool isLoading = true.obs;
  Widget imageWaiting = Container();
  late String documentID;

  final box = GetStorage();
  bool get isOpenBox => box.read('isOpenBox') ?? false;
  bool get isBackGift => box.read('isBackGift') ?? false;
  int get selectGift => box.read('selectGift') ?? 0;

  String content = "";
  String contentButton = "Nhận nè, cảm ơn ny";

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  initData() async {
    documentID = Get.arguments["documentID"];
    String image = Get.arguments["image"];
    imageWaiting = Image.network(image);
    await streamGetListHPBD(documentID);
  }

  Future<void> streamGetListHPBD(String id) async {
    Future.delayed(Duration(seconds: 5), () async {
      CollectionReference bdRef = firestore.collection(DataRowName.Menus.name);
      var data = await bdRef.doc("Blocks").collection('BlockRight').doc(id).collection("2023").get();
      mainData.value = HPBDData.fromJson(data.docs[0].data());
      mainData.refresh();
      isLoading.value = false;
    });
  }

  Future<void> onSelectGift(BuildContext context, int index) async {
    if(isOpenBox){
      contentButton = "Đóng";
      int selectIndex = box.read("selectGift") ?? 0;
      if(isBackGift){
        content = "Biết ngay là thoát ra rồi dô lại mà, chọn được 1 lần thôi nha Gấu heo.";
        showCustomDialog(context);
        return;
      }
      content = "Quà được chọn 1 lần hoi nha.";
      if(selectIndex == index){
        content = mainData.value.contentGif ?? '';
      }
      showCustomDialog(context);
      return;
    }
    box.write("isOpenBox", true);
    box.write("selectGift", index);
    content = mainData.value.contentGif ?? '';
    contentButton = "Nhận nè, cảm ơn ny";
    showCustomDialog(context);
    //Show Dialog
  }

  @override
  void onClose() {
    if(isOpenBox && !isBackGift){
      box.write("isBackGift", true);
    }
    super.onClose();
  }

  void showCustomDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return GiftLayout(controller: this);
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
}