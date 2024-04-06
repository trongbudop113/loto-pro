import 'package:get/get.dart';
import 'package:loto/page/shopping/cart/models/order_cart.dart';

class OrderDetailManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderDetailManagerController());
  }
}

class OrderDetailManagerController extends GetxController{

  final Rx<OrderCart> orderCartData = OrderCart().obs;
  final RxString titleAppbar = "".obs;

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  void initData() {
    orderCartData.value = Get.arguments as OrderCart;
    titleAppbar.value = orderCartData.value.orderID ?? '';
  }
}