import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page_config.dart';

abstract class GameMenuProvider{

  Stream<QuerySnapshot<Object?>> streamGetGame() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference menuRef = firestore.collection(DataRowName.Menus.name);
    var gameMenu = menuRef.doc("Games").collection('AllGame');

    return gameMenu.snapshots();
  }

  void goToRoomPage(String page){
    // print("page....." + page);
    // Get.toNamed(page);
    if(FirebaseAuth.instance.currentUser != null){
      Get.toNamed(page);
    }else{
      Get.toNamed(PageConfig.LOGIN);
    }
  }
}