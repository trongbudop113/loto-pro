import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/common.dart';
import 'package:loto/common/mesage_util.dart';
import 'package:loto/common/utils.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/models/user_login.dart';
import 'package:loto/page/profile/models/voucher_model.dart';
import 'package:loto/page/shopping/cart/layout/pick_user_layout.dart';
import 'package:loto/page/shopping/cart/layout/select_voucher_apply_layout.dart';
import 'package:loto/page/shopping/cart/models/order_cart.dart';
import 'package:loto/page/shopping/home_main/home_main_controller.dart';
import 'package:loto/page/shopping/moon_cake/models/order_moon_cake.dart';
import 'package:loto/page_config.dart';
import 'package:loto/services/membership_service.dart';
import 'package:loto/src/color_resource.dart';
import 'package:loto/widget/loading/loading_overlay.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController());
  }
}

class CartController extends GetxController {
  final RxDouble finalPrice = 0.0.obs;
  final RxDouble cartPrice = 0.0.obs;
  final RxDouble discountAmount = 0.0.obs;
  final Rx<VoucherModel?> selectedVoucher = Rx<VoucherModel?>(null);
  final RxList<VoucherModel> userVouchers = <VoucherModel>[].obs;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference cakeRef = FirebaseFirestore.instance.collection(DataRowName.Cakes.name);
  final TextEditingController textNoteController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    countTotalPrice();
    if (AppCommon.singleton.isLogin) {
      loadUserVouchers();
    }
  }

  double countTotalPrice() {
    double price = 0.0;
    for (ProductOrder element in currentProductInCart) {
      price = price + (element.productPrice * element.quantity.value);
    }
    cartPrice.value = price;
    
    // Tính toán giảm giá từ voucher
    double discount = 0.0;
    if (selectedVoucher.value != null) {
      VoucherModel voucher = selectedVoucher.value!;
      if (voucher.minOrderAmount == null || price >= voucher.minOrderAmount!) {
        if (voucher.discount >= 1) {
          // Giảm giá theo số tiền cố định
          discount = voucher.discount;
        } else {
          // Giảm giá theo phần trăm
          discount = price * voucher.discount;
        }
      }
    }
    
    discountAmount.value = discount;
    finalPrice.value = price - discount;
    return finalPrice.value;
  }

  String formatCurrency(double d) {
    return "${FormatUtils.oCcy.format(d)}đ";
  }

  List<ProductOrder> get currentProductInCart =>
      AppCommon.singleton.currentProductInCart;

  Future<void> onTapRemoveProductItem(ProductOrder productItem) async {
    AppCommon.singleton.currentProductInCart.remove(productItem);
    await AppCommon.singleton.onUpdateCartToServer();
    countTotalPrice();
  }

  Future<void> onTapSubtract(ProductOrder productItem) async {
    if (productItem.quantity.value == 1) return;
    productItem.quantity.value--;
    await 0.5.delay();
    await AppCommon.singleton.onUpdateCartToServer();
    countTotalPrice();
  }

  Future<void> onTapPlus(ProductOrder productItem) async {
    productItem.quantity.value++;
    await 0.5.delay();
    await AppCommon.singleton.onUpdateCartToServer();
    countTotalPrice();
  }

  Future<UserLogin?> showDialogPickUser() async {
    var user = await Get.dialog(Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: PickUserLayout(controller: this),
    ));

    return user;
  }

  Color getBackgroundColor(String? color, BuildContext context) {
    if (color == null) return ColorResource.color_background_light;
    return Color(int.parse("0xFF$color"));
  }

  Future<void> onTapOrder(BuildContext context) async {
    if (!AppCommon.singleton.isLogin) {
      Get.toNamed(PageConfig.LOGIN);
      return;
    }
    if (currentProductInCart.isEmpty) return;

    UserLogin currentUserLogin;

    if(AppCommon.singleton.userLoginData.isAdmin ?? false){
      var result = await showDialogPickUser();
      if(result == null){
        return;
      }
      currentUserLogin = result;
    }else{
      currentUserLogin = await AppCommon.singleton.getCurrentUserLogin();
    }

    LoadingOverlay.instance().show(context: context);
    DateTime current = DateTime.now();
    String month =
        current.month < 10 ? "0${current.month}" : "${current.month}";
    String day = current.day < 10 ? "0${current.day}" : "${current.day}";
    String orderOfDay = "${current.year}$month$day";
    String orderOfDayTitle = "$day-$month-${current.year}";

    OrderCart orderCart = OrderCart();
    orderCart.orderTime = current;
    orderCart.orderID = current.millisecondsSinceEpoch.toString();
    orderCart.listProductItem = AppCommon.singleton.currentProductInCart;
    orderCart.totalPrice = finalPrice.value;
    orderCart.discountCart = discountAmount.value;
    orderCart.statusOrder = 1;
    orderCart.cartPrice = cartPrice.value;

    orderCart.userOrder = currentUserLogin;
    orderCart.note = textNoteController.text.trim();

    await handleSaveOrderDate(orderOfDay : orderOfDay, orderOfDayTitle: orderOfDayTitle,);

    await cakeRef
        .doc(DataCollection.Orders.name)
        .collection(orderOfDay)
        .doc(current.millisecondsSinceEpoch.toString())
        .set(orderCart.toJson());

    // Đánh dấu voucher đã sử dụng nếu có
    if (selectedVoucher.value != null) {
      await _markVoucherAsUsed(selectedVoucher.value!.id);
      selectedVoucher.value = null;
      discountAmount.value = 0.0;
    }

    // Cập nhật điểm thành viên sau khi đặt hàng thành công
    await _updateMembershipPoints(
      userId: currentUserLogin.uuid ?? '',
      orderAmount: finalPrice.value,
      userLogin: currentUserLogin,
    );

    AppCommon.singleton.currentProductInCart.clear();
    MessageUtil.show(
      msg: "Mua hàng thành công",
      duration: 1,
    );
    LoadingOverlay.instance().hide();
    Get.find<HomeMainController>().onBackPage(context);
  }

  Future<void> onRemoveAllCart() async {
    AppCommon.singleton.currentProductInCart.clear();
    await AppCommon.singleton.onUpdateCartToServer();
    countTotalPrice();
  }

  Future<void> handleSaveOrderDate({required String orderOfDay, required String orderOfDayTitle}) async {

    DocumentSnapshot<Object?> data = await cakeRef.doc(DataCollection.Orders.name).get();
    LsOrderTime lsOrderTime = LsOrderTime.fromJson(data.data() as Map<String, dynamic>);

    var filterData = lsOrderTime.lsOrderTime.firstWhereOrNull((e) => e.orderDateID == orderOfDay);
    if(filterData != null){
      return;
    }

    lsOrderTime.lsOrderTime.add(OrderTime(
      orderDateID: orderOfDay,
      orderDateTitle: orderOfDayTitle,
    ));
    await cakeRef.doc(DataCollection.Orders.name).set(lsOrderTime.toJson());
  }

  Stream<QuerySnapshot<Object?>> getListUser() {
    CollectionReference userRef = firestore.collection(DataRowName.Users.name);


    return userRef.snapshots();
  }

  void onPickUser(UserLogin user) {
    Get.back(result: user);
  }

  /// Load voucher đã thu thập của user
  Future<void> loadUserVouchers() async {
    try {
      if (!AppCommon.singleton.isLogin) return;
      
      final userId = AppCommon.singleton.userLoginData.uuid;
      if (userId == null) return;
      
      final userDoc = await firestore
          .collection(DataRowName.Users.name)
          .doc(userId)
          .get();
      
      if (!userDoc.exists) return;
      
      final userData = userDoc.data() as Map<String, dynamic>;
      final collectedVouchers = List<String>.from(userData['collectedVouchers'] ?? []);
      
      if (collectedVouchers.isEmpty) {
        userVouchers.clear();
        return;
      }
      
      // Load thông tin chi tiết của các voucher đã thu thập
      final voucherSnapshot = await cakeRef
          .doc(DataCollection.Vouchers.name)
          .collection(DataCollection.Vouchers.name)
          .get();
      
      List<VoucherModel> vouchers = [];
      for (var doc in voucherSnapshot.docs) {
        if (collectedVouchers.contains(doc.id)) {
          var data = doc.data();
          data['id'] = doc.id;
          VoucherModel voucher = VoucherModel.fromJson(data);
          
          // Chỉ thêm voucher còn hiệu lực và chưa sử dụng
          if (voucher.isValid && !(data['isUsed'] ?? false)) {
            vouchers.add(voucher);
          }
        }
      }
      
      userVouchers.value = vouchers;
    } catch (e) {
      print('Error loading user vouchers: $e');
    }
  }

  /// Chọn voucher để áp dụng
  void selectVoucher(VoucherModel? voucher) {
    selectedVoucher.value = voucher;
    countTotalPrice();
  }

  /// Hiển thị dialog chọn voucher
  Future<void> showVoucherSelectionDialog() async {
    await loadUserVouchers();
    
    Get.dialog(
      SelectVoucherApplyLayout(controller: this),
    );
  }

  /// Đánh dấu voucher đã sử dụng
  Future<void> _markVoucherAsUsed(String voucherId) async {
    try {
      await cakeRef
          .doc(DataCollection.Vouchers.name)
          .collection(DataCollection.Vouchers.name)
          .doc(voucherId)
          .update({'isUsed': true});
    } catch (e) {
      print('Error marking voucher as used: $e');
    }
  }
 
    /// Cập nhật điểm thành viên sau khi đặt hàng
  Future<void> _updateMembershipPoints({
    required String userId,
    required double orderAmount,
    required UserLogin userLogin,
  }) async {
    try {
      if (userId.isEmpty) return;
      
      // Kiểm tra xem đây có phải đơn hàng đầu tiên không
      bool isFirstOrder = (userLogin.totalOrders ?? 0) == 0;
      
      // Cập nhật điểm thành viên
      await MembershipService.updatePointsForOrder(
        userId: userId,
        orderAmount: orderAmount,
        isFirstOrder: isFirstOrder,
      );
      
      // Kiểm tra và cập nhật cấp độ thành viên
      bool tierChanged = await MembershipService.checkAndUpdateMembershipTier(userId);
      
      // Hiển thị thông báo nếu có thay đổi cấp độ
      if (tierChanged) {
        final updatedUser = await MembershipService.getUserMembershipInfo(userId);
        if (updatedUser != null) {
          _showTierUpgradeNotification(updatedUser);
        }
      }
    } catch (e) {
      print('Error updating membership points: $e');
    }
  }
  
  /// Hiển thị thông báo nâng cấp cấp độ thành viên
  void _showTierUpgradeNotification(UserLogin user) {
    Get.snackbar(
      'Chúc mừng! 🎉',
      'Bạn đã được nâng cấp lên ${user.membershipDisplayName}!',
      backgroundColor: Color(user.membershipColor).withOpacity(0.9),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      icon: Text(
        user.membershipIcon,
        style: const TextStyle(fontSize: 24),
      ),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }
}
