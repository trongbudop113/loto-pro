import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page_config.dart';

class PageManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PageManagerController());
  }
}

class PageManagerController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> getAllMenu() {
    CollectionReference collectionRef =
        firestore.collection(DataRowName.Menus.name);
    return collectionRef.snapshots();
  }

  Future<void> onHideShowBlockQuick(bool value,
      {required String docName,
      required String collectionName,
      required String docChild}) async {
    CollectionReference collectionRef =
        firestore.collection(DataRowName.Menus.name);
    await collectionRef
        .doc(docName)
        .collection(collectionName)
        .doc(docChild)
        .update({
      "is_show": value,
    });
  }

  void onAddNewPage(){
    Get.toNamed(PageConfig.EDIT_PAGE_MANAGER, arguments: {"isAdd" : true});
  }

  void goToEditPage({
    required QueryDocumentSnapshot<Object?> snapshotChild,
    required String idBlock,
    required String idCollection,
  }) {
    Get.toNamed(PageConfig.EDIT_PAGE_MANAGER, arguments: {
      "snapshotChild" : snapshotChild,
      "idBlock" : idBlock,
      "idCollection" : idCollection,
      "isAdd" : false,
    });
  }
}
