import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/chat/models/chat_content_data.dart';
import 'package:loto/page/select/models/select_paper.dart';


class ChatDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ChatDetailController());
  }
}

class ChatDetailController extends GetxController {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final RxList<SelectPaper> listData = <SelectPaper>[].obs;
  final RxBool isShowChatMenu = false.obs;
  final RxString groupChatID = "".obs;
  String peerID = "";
  String peerAvatar = "";
  String peerName = "";

  final RxBool isShowSticker = false.obs;
  final RxInt limit = 20.obs;
  int limitIncrement = 20;

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  late String imageUrl;

  String get currentUserID => FirebaseAuth.instance.currentUser!.uid;

  List<QueryDocumentSnapshot> listMessage = List.from([]);

  @override
  void onInit() {
    getArgument();
    super.onInit();
  }

  Stream<QuerySnapshot<Object?>> getListChatStream(){
    return firestore.collection(DataRowName.Chats.name).doc(groupChatID.value).collection(groupChatID.value)
        .orderBy('timestamp', descending: true).limit(limit.value).snapshots();
  }

  void initScroll(){
    focusNode.addListener(onFocusChange);
    listScrollController.addListener(_scrollListener);
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      isShowSticker.value = false;
    }
  }


  _scrollListener() {
    if (listScrollController.offset >= listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      limit.value += limitIncrement;
    }
  }

  void getSticker() {
    // Hide keyboard when sticker appear
    focusNode.unfocus();
    isShowSticker.value = !isShowSticker.value;
  }

  void getArgument(){
    var argument = Get.arguments as Map<String, dynamic>;
    peerID = argument['peerID'];
    peerAvatar = argument['peerAvatar'];
    peerName = argument['peerName'];

    List<String> listUUID = [FirebaseAuth.instance.currentUser!.uid ?? '', peerID];
    listUUID.sort((a, b) => a.compareTo(b));
    groupChatID.value = '${listUUID[0]}-${listUUID[1]}';

    String emailUser = FirebaseAuth.instance.currentUser!.email ?? '';
    firestore.collection(DataRowName.Users.name).doc(emailUser).update({'chattingWith': peerID});
  }

  void onTapMenu(){
    isShowChatMenu.value = !isShowChatMenu.value;
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();

    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery, maxHeight: 500, maxWidth: 500);
    var imageFile = File(pickedFile!.path);
    imageFile.printError(info: "aaaaa");
    uploadFile(imageFile);
  }

  Future uploadFile(File imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child("chats/" + fileName);
    UploadTask uploadTask = reference.putFile(imageFile, SettableMetadata(
      contentType: "image/jpeg",
    ));
    TaskSnapshot storageTaskSnapshot = await uploadTask.snapshot;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      imageUrl = downloadUrl;
      onSendMessage(imageUrl, 1);
    }, onError: (err) {
      err.toString().printError(info: "bbbbb-----");
    });
  }

  void onSendMessage(String content, int type) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      textEditingController.clear();

      var documentReference = FirebaseFirestore.instance
          .collection(DataRowName.Chats.name)
          .doc(groupChatID.value)
          .collection(groupChatID.value)
          .doc(DateTime.now().millisecondsSinceEpoch.toString()
      );

      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          {
            'from_id': currentUserID,
            'to_id': peerID,
            'timestamp': DateTime.now().millisecondsSinceEpoch,
            'content': content,
            'type': type
          },
        );
      });
      listScrollController.animateTo(0.0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {

    }
  }

  ChatContentData parseChatData(Map<String, dynamic> inputData){
    return ChatContentData.fromJson(inputData);
  }

  bool isLastMessageLeft(int index) {
    if(index == 0) return true;
    ChatContentData data = parseChatData(listMessage[index - 1].data() as Map<String, dynamic>);
    if ((index > 0 && data.toId == peerID)) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if(index == 0) return true;
    ChatContentData data = parseChatData(listMessage[index - 1].data() as Map<String, dynamic>);
    if ((index > 0 && data.fromId == currentUserID)) {
      return true;
    } else {
      return false;
    }
  }

}