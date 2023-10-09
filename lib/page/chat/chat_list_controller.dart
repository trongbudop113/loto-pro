import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/models/user_login.dart';
import 'package:loto/page_config.dart';


class ChatListBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ChatListController());
  }
}

class ChatListController extends GetxController {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String get nameUser => FirebaseAuth.instance.currentUser!.displayName ?? 'U';

  @override
  void onInit() {
    super.onInit();
  }

  void goToChatDetail(UserLogin user){
    List<String> listUUID = [FirebaseAuth.instance.currentUser!.uid ?? '', user.uuid ?? ''];
    listUUID.sort((a, b) => a.compareTo(b));
    String iDConversation = '${listUUID[0]}-${listUUID[1]}';

    Get.toNamed(PageConfig.CHAT_DETAIL, arguments: iDConversation);
  }

  Stream<QuerySnapshot<Object?>> streamGetListUser() {
    CollectionReference cakeRef = firestore.collection(DataRowName.Users.name);

    return cakeRef.snapshots();
  }

}