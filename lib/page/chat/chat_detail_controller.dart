import 'package:get/get.dart';
import 'package:loto/page/select/models/select_paper.dart';


class ChatDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ChatDetailController());
  }
}

class ChatDetailController extends GetxController {

  final RxList<SelectPaper> listData = <SelectPaper>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

}