import 'package:get/get.dart';
import 'package:loto/page_config.dart';


class ChatListBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ChatListController());
  }
}

class ChatListController extends GetxController {

  @override
  void onInit() {
    super.onInit();
  }

  void goToChatDetail(){
    Get.toNamed(PageConfig.CHAT_DETAIL);
  }

}