import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/language/localization_service.dart';
import 'package:loto/models/user_login.dart';
import 'package:loto/page/profile/dialog/select_option_layout.dart';
import 'package:loto/page/profile/model/option_data.dart';
import 'package:loto/page/profile/model/profile_block.dart';
import 'package:loto/page/profile/models/voucher_model.dart';
import 'package:loto/page/profile/widgets/member_info_layout.dart';
import 'package:loto/page/profile/widgets/voucher_layout.dart';
import 'package:loto/page_config.dart';
import 'package:loto/theme/theme_provider.dart';
import 'package:loto/services/membership_service.dart';
import 'package:loto/models/membership_tier.dart';
import 'package:provider/provider.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}

class ProfileController extends GetxController {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final Rx<UserLogin> userLogin = UserLogin().obs;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  RxList<ProfileBlock> listBlock = <ProfileBlock>[].obs;

  List<OptionData> listLanguage = [
    OptionData(value: "vi"),
    OptionData(value: "en"),
    OptionData(value: "ja"),
  ];

  // Thêm các biến và phương thức hỗ trợ
  final RxList<VoucherModel> listVouchers = <VoucherModel>[].obs;
  final RxList<VoucherModel> listVouchersAll = <VoucherModel>[].obs;
  final RxBool isLoadingVouchers = false.obs;
  
  // Membership variables
  final RxBool isLoadingMembership = false.obs;
  final RxList<UserLogin> topMembers = <UserLogin>[].obs;


  List<OptionData> listThemeMode = [
    OptionData(value: "light_mode"),
    OptionData(value: "dark_mode"),
  ];

  void onChangeThemeMode(BuildContext context, String value){
    HapticFeedback.mediumImpact();
    bool mode = value == "dark_mode" ? true : false;
    Provider.of<ThemeProvider>(context, listen:false).toggleMode(mode);
    for (var e in listThemeMode) {
      if(e.value == value){
        e.isSelected.value = true;
      }else{
        e.isSelected.value = false;
      }
    }
  }

  RxBool get isDarkMode{
    String value = listThemeMode.firstWhere((e) => e.isSelected.value).value ?? '';
    return (value == "dark_mode").obs;
  }

  RxString get currentLanguage{
    String value = listLanguage.firstWhere((e) => e.isSelected.value).value ?? '';
    return value.toUpperCase().obs;
  }

  void onTapBlock(BuildContext context, ProfileBlock block){
    if(block.type == ProfileType.ThemeMode){
      showDialogSelectThemeMode(context, block.blockName!);
    }else if(block.type == ProfileType.Language){
      showDialogSelectLanguage(context, block.blockName!);
    }else if(block.type == ProfileType.Products){
      //Get.toNamed(PageConfig.STATISTIC);
      Get.toNamed(block.page ?? '/');
    }else if(block.type == ProfileType.Contacts){
      Get.toNamed(PageConfig.CONTACT_MANAGER);
    }else if(block.type == ProfileType.Footer){
      Get.toNamed(PageConfig.FOOTER_MANAGER);
    }else if(block.type == ProfileType.Page){
      Get.toNamed(block.page ?? '/');
    }else if(block.type == ProfileType.Order){
      Get.toNamed(block.page ?? '/');
    } else if(block.type == ProfileType.Products){
      Get.toNamed(block.page ?? '/');
    } else if(block.type == ProfileType.User){
      Get.toNamed(block.page ?? '/');
    }
  }

  Future<void> showDialogSelectLanguage(BuildContext context, String title) async {
    var result = await showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (builder){
          return SelectOptionLayout(title: title, listOption: listLanguage);
        }
    );
    if(result != null){
      for (var e in listLanguage) {
        if(e.value == result){
          e.isSelected.value = true;
        }else{
          e.isSelected.value = false;
        }
      }
      LocalizationService.changeLocale(langCode: result.toString());
    }
  }

  Future<void> showDialogSelectThemeMode(BuildContext context, String title) async {
    var result = await showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (builder){
          return SelectOptionLayout(title: title, listOption: listThemeMode);
        }
    );
    if(result != null){
      onChangeThemeMode(Get.context!, result.toString());
    }
  }

  @override
  void onInit() {
    initValue();
    getDataUser();
    loadTopMembers();
    loadVouchers();
    loadAllVouchers();
    super.onInit();
  }

  void initValue(){
    try{
      String mode = Provider.of<ThemeProvider>(Get.context!, listen:false).isDark ? "dark_mode" : "light_mode";
      listThemeMode.firstWhere((e) => e.value! == mode).isSelected.value = true;
      listLanguage[0].isSelected.value = true;
    }catch(e){
      e.printError(info: "aaaaaa");
    }
  }

  Future<void> getDataUser() async {
    try{
      CollectionReference usersReference = firestore.collection(DataRowName.Users.name);
      final getUSer = await usersReference.doc(FirebaseAuth.instance.currentUser?.uid ?? '').get();
      if(getUSer.data() == null) return;
      userLogin.value = UserLogin.fromJson(getUSer.data() as Map<String, dynamic>);
      initUserInfo(userInfo: userLogin.value);
      
      // Kiểm tra và khởi tạo membership nếu chưa có
      await initializeMembershipIfNeeded();
      
      // Cập nhật điểm đăng nhập hàng ngày
      await updateDailyLoginPoints();
    }catch(e){
      print('Error getting user data: $e');
    }
  }

  void initUserInfo({UserLogin? userInfo}){
    if(userInfo == null) return;
    nameController.text = userInfo.name ?? '';
    phoneController.text = userInfo.phoneNumber ?? '';
    emailController.text = userInfo.email ?? '';
    addressController.text = userInfo.address ?? '';
  }

  Future<void> goToLoginApp() async {
    if((userLogin.value.uuid ?? '').isNotEmpty) return;
    var result = await Get.toNamed(PageConfig.LOGIN);
    if(result == null || (result ?? false) == false) return;
    await getDataUser();
  }

  Future<void> logOutApp() async {
    await FirebaseAuth.instance.signOut();
    Get.back();
  }

  void onEditProfile() {
    if(userLogin.value.name == null) return;
    Get.toNamed(PageConfig.PROFILE_MANAGER, arguments: userLogin.value);
  }

  void onMyOrdersTap() {
    Get.toNamed(PageConfig.PRODUCT_MANAGER);
  }

  Future<void> showMyVoucher() async {
    await loadVouchers(); // Refresh vouchers when showing
    Get.bottomSheet(
      VoucherLayout(controller: this),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  // Voucher methods
  // Tải tất cả voucher công khai (để hiển thị trong danh sách thu thập)
  Future<void> loadAllVouchers() async {
    try {
      isLoadingVouchers.value = true;

      // Lấy tất cả voucher công khai
      final publicVouchersQuery = firestore
          .collection(DataRowName.Cakes.name)
          .doc(DataCollection.Vouchers.name)
          .collection(DataCollection.Vouchers.name);

      final publicVouchersSnapshot = await publicVouchersQuery.get();

      List<VoucherModel> vouchers = [];
      
      // Thêm voucher công khai
      for (var doc in publicVouchersSnapshot.docs) {
        final data = doc.data();
        data['id'] = doc.id;
        vouchers.add(VoucherModel.fromJson(data));
      }

      // Lọc voucher còn hiệu lực và sắp xếp theo ngày hết hạn
      vouchers = vouchers.where((v) => v.isValid).toList();
      vouchers.sort((a, b) {
        if (a.expiredAt != null && b.expiredAt != null) {
          return a.expiredAt!.compareTo(b.expiredAt!);
        }
        return 0;
      });

      listVouchersAll.value = vouchers;
      print('Loaded all vouchers: ${listVouchersAll.length}');
    } catch (e) {
      print('Error loading all vouchers: $e');
      Get.snackbar(
        'Lỗi',
        'Không thể tải voucher',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoadingVouchers.value = false;
    }
  }

  // Tải voucher đã thu thập của user
  Future<void> loadVouchers() async {
    try {
      isLoadingVouchers.value = true;
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) return;

      final collectedVoucherIds = getCollectedVouchers();
      if (collectedVoucherIds.isEmpty) {
        listVouchers.value = [];
        return;
      }

      // Lấy voucher đã thu thập
      List<VoucherModel> vouchers = [];
      
      for (String voucherId in collectedVoucherIds) {
        try {
          final doc = await firestore
              .collection(DataRowName.Cakes.name)
              .doc(DataCollection.Vouchers.name)
              .collection(DataCollection.Vouchers.name)
              .doc(voucherId)
              .get();
              
          if (doc.exists) {
            final data = doc.data()!;
            data['id'] = doc.id;
            final voucher = VoucherModel.fromJson(data);
            if (voucher.isValid) {
              vouchers.add(voucher);
            }
          }
        } catch (e) {
          print('Error loading voucher $voucherId: $e');
        }
      }

      // Sắp xếp theo ngày hết hạn
      vouchers.sort((a, b) {
        if (a.expiredAt != null && b.expiredAt != null) {
          return a.expiredAt!.compareTo(b.expiredAt!);
        }
        return 0;
      });

      listVouchers.value = vouchers;
      print('Loaded collected vouchers: ${listVouchers.length}');
    } catch (e) {
      print('Error loading collected vouchers: $e');
      Get.snackbar(
        'Lỗi',
        'Không thể tải voucher đã thu thập',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoadingVouchers.value = false;
    }
  }

  Future<void> useVoucher(String voucherId) async {
    try {
      await firestore.collection(DataRowName.Cakes.name)
        .doc(DataCollection.Vouchers.name)
        .collection(DataCollection.Vouchers.name)
          .doc(voucherId).update({
        'isUsed': true,
        'usedAt': FieldValue.serverTimestamp(),
      });
      
      // Refresh voucher list
      await loadVouchers();
      
      Get.snackbar(
        'Thành công',
        'Đã sử dụng voucher',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print('Error using voucher: $e');
      Get.snackbar(
        'Lỗi',
        'Không thể sử dụng voucher',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Future<void> createSampleVouchers() async {
  //   try {
  //     // Tạo voucher công khai
  //     List<Map<String, dynamic>> publicVouchers = [
  //       {
  //         'name': 'Chào mừng thành viên mới',
  //         'code': 'WELCOME2024',
  //         'expireDate': '31/12/2025',
  //         'discount': 0.15,
  //         'isUsed': false,
  //         'description': 'Giảm 15% cho thành viên mới',
  //         'minOrderAmount': 50000,
  //         'createdAt': DateTime.now().millisecondsSinceEpoch,
  //         'expiredAt': DateTime(2025, 12, 31).millisecondsSinceEpoch,
  //         'userId': null, // Voucher công khai
  //       },
  //       {
  //         'name': 'Giảm 20% cuối tuần',
  //         'code': 'WEEKEND20',
  //         'expireDate': '31/12/2025',
  //         'discount': 0.2,
  //         'isUsed': false,
  //         'description': 'Giảm 20% cho đơn hàng cuối tuần',
  //         'minOrderAmount': 150000,
  //         'createdAt': DateTime.now().millisecondsSinceEpoch,
  //         'expiredAt': DateTime(2025, 12, 31).millisecondsSinceEpoch,
  //         'userId': null,
  //       },
  //       {
  //         'name': 'Miễn phí vận chuyển',
  //         'code': 'FREESHIP',
  //         'expireDate': '30/11/2025',
  //         'discount': 30000,
  //         'isUsed': false,
  //         'description': 'Miễn phí vận chuyển cho đơn hàng từ 100.000đ',
  //         'minOrderAmount': 100000,
  //         'createdAt': DateTime.now().millisecondsSinceEpoch,
  //         'expiredAt': DateTime(2025, 11, 30).millisecondsSinceEpoch,
  //         'userId': null,
  //       },
  //     ];
  //
  //     // Thêm voucher vào Firestore
  //     for (var voucher in publicVouchers) {
  //       await firestore.collection(DataRowName.Cakes.name)
  //           .doc(DataCollection.Vouchers.name)
  //           .collection(DataCollection.Vouchers.name).add(voucher);
  //     }
  //
  //     await loadAllVouchers();
  //
  //     Get.snackbar(
  //       'Thành công',
  //       'Đã tạo voucher mẫu',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.green,
  //       colorText: Colors.white,
  //     );
  //   } catch (e) {
  //     print('Error creating sample vouchers: $e');
  //   }
  // }

  void copyVoucherCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
    Get.snackbar(
      'Thành công',
      'Đã sao chép mã voucher',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
    );
  }

  // Membership methods
  Future<void> initializeMembershipIfNeeded() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;
    
    if (userLogin.value.membershipPoints == null) {
      await MembershipService.initializeMembership(userId);
      await getDataUser(); // Refresh user data
    }
  }
  
  Future<void> updateDailyLoginPoints() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;
    
    await MembershipService.updatePointsForDailyLogin(userId);
    await getDataUser(); // Refresh user data
  }
  
  Future<void> loadTopMembers() async {
    try {
      isLoadingMembership.value = true;
      final members = await MembershipService.getTopMembers(limit: 10);
      topMembers.value = members;
    } catch (e) {
      print('Error loading top members: $e');
    } finally {
      isLoadingMembership.value = false;
    }
  }
  
  void showMembershipDetails() {
    Get.bottomSheet(
      MemberInfoLayout(controller: this),
      isScrollControlled: true,
    );
  }

  void showTopMembersLeaderboard() {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.7,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            const Text(
              'Bảng xếp hạng thành viên',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (isLoadingMembership.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                return ListView.builder(
                  itemCount: topMembers.length,
                  itemBuilder: (context, index) {
                    final member = topMembers[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color(member.membershipColor),
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(member.name ?? 'Ẩn danh'),
                      subtitle: Text(member.membershipDisplayName),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(member.membershipIcon),
                          const SizedBox(width: 8),
                          Text(
                            '${member.membershipPoints ?? 0}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  // Phương thức thu thập voucher
  Future<void> collectVoucher(String voucherId) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        Get.snackbar(
          'Lỗi',
          'Vui lòng đăng nhập để thu thập voucher',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // Kiểm tra xem voucher đã được thu thập chưa
      final currentUser = userLogin.value;
      if (currentUser.collectedVouchers?.contains(voucherId) == true) {
        Get.snackbar(
          'Thông báo',
          'Bạn đã thu thập voucher này rồi',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }

      // Thêm voucher vào danh sách đã thu thập
      List<String> collectedVouchers = currentUser.collectedVouchers ?? [];
      collectedVouchers.add(voucherId);

      // Cập nhật Firestore
      await firestore.collection(DataRowName.Users.name)
          .doc(userId)
          .update({
        'collectedVouchers': collectedVouchers,
      });

      // Cập nhật local state
      currentUser.collectedVouchers = collectedVouchers;
      userLogin.value = currentUser;
      userLogin.refresh();

      // Tải lại danh sách voucher
      await loadVouchers();

      Get.snackbar(
        'Thành công',
        'Đã thu thập voucher thành công',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print('Error collecting voucher: $e');
      Get.snackbar(
        'Lỗi',
        'Không thể thu thập voucher',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Kiểm tra xem voucher đã được thu thập chưa
  bool isVoucherCollected(String voucherId) {
    return userLogin.value.collectedVouchers?.contains(voucherId) ?? false;
  }

  // Lấy danh sách voucher đã thu thập
  List<String> getCollectedVouchers() {
    return userLogin.value.collectedVouchers ?? [];
  }

  // Hiển thị dialog thu thập voucher
  void showCollectVoucherDialog(VoucherModel voucher) {
    Get.dialog(
      AlertDialog(
        title: Text('Thu thập voucher'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tên voucher: ${voucher.name}'),
            SizedBox(height: 8),
            Text('Mã: ${voucher.code}'),
            SizedBox(height: 8),
            Text('Giảm giá: ${voucher.discountText}'),
            if ((voucher.minOrderAmount ?? 0) > 0)...[
              SizedBox(height: 8),
              Text('Đơn tối thiểu: ${(voucher.minOrderAmount ?? 0).toStringAsFixed(0)}đ'),
            ],
            const SizedBox(height: 8),
            Text('Hạn sử dụng: ${voucher.expireDate}'),
            if ((voucher.description ?? '').isNotEmpty)...[
              const SizedBox(height: 8),
              Text('Mô tả: ${voucher.description}'),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              collectVoucher(voucher.id);
            },
            child: Text('Thu thập'),
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.onClose();
  }
}