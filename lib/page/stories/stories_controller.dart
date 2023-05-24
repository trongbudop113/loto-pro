import 'package:get/get.dart';
import 'package:loto/page/select/models/select_paper.dart';


class StoriesBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => StoriesController());
  }
}

class StoriesController extends GetxController {

  final RxList<SelectPaper> listData = <SelectPaper>[].obs;

  @override
  void onInit() {
    getArgument();
    super.onInit();
  }

  void getArgument(){
    var arguments = Get.arguments as List<SelectPaper>;
    listData.addAll(arguments);
  }

}