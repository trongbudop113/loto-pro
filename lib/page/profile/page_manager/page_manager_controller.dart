import 'package:get/get.dart';
import 'package:loto/page/profile/model/block_page.dart';

class PageManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PageManagerController());
  }
}

class PageManagerController extends GetxController {
  final List<BlockPage> listBlock = [
    BlockPage(blockName: "Banner", blockCollection: "Banners"),
    BlockPage(blockName: "Menu Trái Phải", blockCollection: "Blocks"),
    BlockPage(blockName: "Footer", blockCollection: "Footer"),
    BlockPage(blockName: "Trò chơi", blockCollection: "Games"),
    BlockPage(blockName: "Tiện ích", blockCollection: "Utility"),
  ];
}
