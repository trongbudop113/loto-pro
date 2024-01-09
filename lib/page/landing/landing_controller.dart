import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/core/custom_get_controller.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/landing/models/block_menu.dart';
import 'package:loto/page/landing/provider/banner_provider.dart';
import 'package:loto/page/landing/provider/block_body_provider.dart';
import 'package:loto/page/landing/provider/block_left_provider.dart';
import 'package:loto/page/landing/provider/block_right_provider.dart';
import 'package:loto/page/landing/provider/game_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:loto/page_config.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

class LandingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LandingController());
  }
}

class LandingController extends CustomGetController with BlockLeftProvider, BlockRightProvider, GameMenuProvider, BannerMenuProvider, BlockBodyProvider {

  final Color bgColor = Colors.deepPurple[200]!;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  String get textAppbar => "H O M E";

  @override
  void onInit() {
    loadMenuData();
    //onClickBlockBody();
    super.onInit();
  }

  Future<void> loadMenuData() async {
    CollectionReference menuRef = firestore.collection(DataRowName.Menus.name);
    var blockLeft = await menuRef.doc("Blocks").collection('BlockLeft').get();
    print(blockLeft);
  }

  void onClickItemBlock(BlockMenu menu, {required String argument, String? image}){
    var isLogin = FirebaseAuth.instance.currentUser == null;
    print(isLogin);
    if((menu.isRequireLogin ?? false) && isLogin){
      Get.toNamed(PageConfig.LOGIN);
      return;
    }
    Get.toNamed(menu.page ?? '', arguments: {
      "blockID" : argument,
      "documentID" : menu.documentID,
      "image" :  image
    });
  }

  void onClickBlockBody(){
    final docRef = firestore.collection("Test").doc("hoJMIvPyCEbDP4jBiTbS");
    docRef.snapshots().listen((event) {
        if(event.data()!["isDone"] == true){
          showDialogCong(Get.context!);
        }
      },
      onError: (error) => print("Listen failed: $error"),
    );

  }

  void showDialogCong(BuildContext context){
    Dialogs.materialDialog(
      color: Colors.white,
      msg: 'Congratulations, you won 500 points',
      title: 'Congratulations',
      lottieBuilder: Lottie.asset(
        'assets/cong_example.json',
        fit: BoxFit.contain,
      ),
      barrierDismissible: false,
      dialogWidth: kIsWeb ? 0.3 : null,
      context: context,
      actions: [
        IconsButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          text: 'Claim',
          iconData: Icons.done,
          color: Colors.blue,
          textStyle: TextStyle(color: Colors.white),
          iconColor: Colors.white,
        ),
      ],
    );
  }
}