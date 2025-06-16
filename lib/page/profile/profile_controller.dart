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
import 'package:loto/page/profile/widgets/voucher_layout.dart';
import 'package:loto/page_config.dart';
import 'package:loto/theme/theme_provider.dart';
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
    }catch(e){

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

  void showMyVoucher() {
    Get.bottomSheet(
      VoucherLayout(controller: this),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

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

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.onClose();
  }
}