import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loto/common/common.dart';
import 'package:loto/page/shopping/about_us/about_controller.dart';
import 'package:loto/page/shopping/cart/cart_controller.dart';
import 'package:loto/page/shopping/contact/contact_controller.dart';
import 'package:loto/page/shopping/home/home_controller.dart';
import 'package:loto/page/shopping/shop_product/shop_product_controller.dart';
import 'package:loto/page/shopping/shop_product_detail/shop_product_detail_controller.dart';
import 'package:get/get.dart';
import 'package:loto/page_config.dart';

class HomeMainBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeMainController());
    Get.lazyPut(() => AboutController());
    Get.lazyPut(() => ContactController());
    Get.lazyPut(() => ShopProductController());
    Get.lazyPut(() => BlogDetailController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => CartController());
  }
}

class HomeMainController extends GetxController{

  List<String> headerMenu = ["Trang Chủ", "Câu Chuyện", "Cửa Hàng", "Đánh Giá", "Liên Hệ"];

  var scaffoldKey = GlobalKey<ScaffoldState>();

  final RxInt currentIndexPage = 0.obs;
  int previousPage = 0;

  final box = GetStorage();

  void onChangeTap(int i) {
    if(currentIndexPage.value != i){
      previousPage = currentIndexPage.value;
      currentIndexPage.value = i;
      box.write("tab", i);
    }
  }

  @override
  void onInit() {
    initRoutePage();
    super.onInit();
  }

  void goToCart() {
    Get.toNamed(PageConfig.CART);
  }

  void initRoutePage(){
    int currentTab = box.read("tab") ?? 0;
    currentIndexPage.value = currentTab;
    //
    // 0.1.delay((){
    //   Get.nestedKey(1)?.currentState?.pushNamed(
    //     Destination.shop_product_detail.route,
    //   );
    // });
  }

  void onBackPage(BuildContext context){
    if(currentIndexPage.value == 2){
      if(AppCommon.singleton.shopRoute == "/shop_product_detail"){
        Get.nestedKey(1)?.currentState?.pop();
        return;
      }
    }
    if(currentIndexPage.value == 3){
      if(AppCommon.singleton.blogRoute == "/blog_detail"){
        Get.nestedKey(2)?.currentState?.pop();
      }
    }
    print("aasdasdasdasdasd....");
    if(previousPage != currentIndexPage.value){
      currentIndexPage.value = previousPage;
      box.write("tab", previousPage);
    }
  }
}