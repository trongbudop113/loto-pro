import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loto/page/landing/models/block_menu.dart';
import 'package:loto/page/profile/model/block_page.dart';

class EditPageManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditPageManagerController());
  }
}

class EditPageManagerController extends GetxController {

  Rx<BlockMenu> blockPage = BlockMenu().obs;
  String idDocumentChild = "";
  String idCollection = "";
  String idBlock = "";

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  initData(){
    var data = Get.arguments;
    var mapChild = data["snapshotChild"] as QueryDocumentSnapshot<Object?>;
    blockPage.value = BlockMenu.fromJson(mapChild.data() as Map<String, dynamic>);
    idDocumentChild = mapChild.id;
    idCollection = data["idCollection"];
    idBlock = data["idBlock"];
  }
}