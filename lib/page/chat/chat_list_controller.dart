import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/models/user_login.dart';
import 'package:loto/page/chat/models/chat_content_data.dart';
import 'package:loto/page_config.dart';


class ChatListBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ChatListController());
  }
}

class ChatListController extends GetxController {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String get nameUser {
    if(FirebaseAuth.instance.currentUser!= null && (FirebaseAuth.instance.currentUser!.displayName ?? '').isNotEmpty){
      return FirebaseAuth.instance.currentUser!.displayName!;
    }
    return "U";
  }

  String get currentUserID => FirebaseAuth.instance.currentUser!.uid;

  @override
  void onInit() {
    super.onInit();
  }

  void goToChatDetail(UserLogin user){
    Get.toNamed(PageConfig.CHAT_DETAIL, arguments: {
      "peerID" : user.uuid ?? '',
      "peerAvatar" : user.avatar ?? ''
    });
  }

  Stream<QuerySnapshot<Object?>> streamGetListUser() {
    CollectionReference cakeRef = firestore.collection(DataRowName.Users.name);

    return cakeRef.snapshots();
  }

  Stream<QuerySnapshot<Object?>> streamGetContentListUser(String peerID) {
    List<String> listUUID = [FirebaseAuth.instance.currentUser!.uid ?? '', peerID];
    listUUID.sort((a, b) => a.compareTo(b));
    String groupChatID = '${listUUID[0]}-${listUUID[1]}';

    return firestore.collection(DataRowName.Chats.name).doc(groupChatID).collection(groupChatID)
        .orderBy('timestamp', descending: true).limit(2).snapshots();
  }

  ChatContentData parseChatData(Map<String, dynamic> inputData){
    return ChatContentData.fromJson(inputData);
  }
}