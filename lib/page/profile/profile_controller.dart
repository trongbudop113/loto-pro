import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/language/localization_service.dart';
import 'package:loto/models/user_login.dart';
import 'package:loto/page/profile/dialog/select_option_layout.dart';
import 'package:loto/page/profile/model/option_data.dart';
import 'package:loto/page/profile/model/profile_block.dart';
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

  final box = GetStorage();
  bool get isDark => box.read('darkmode') ?? false;

  final Rx<UserLogin> userLogin = UserLogin().obs;

  RxList<ProfileBlock> listBlock = [
    ProfileBlock(blockName: "theme_mode", page: "", icon: "", type: ProfileType.ThemeMode),
    ProfileBlock(blockName: "language", page: "", icon: "", type: ProfileType.Language)
  ].obs;

  List<OptionData> listLanguage = [
    OptionData(value: "vi"),
    OptionData(value: "en"),
    OptionData(value: "ja"),
  ];

  List<OptionData> listThemeMode = [
    OptionData(value: "light_mode"),
    OptionData(value: "dark_mode"),
  ];

  void onChangeThemeMode(BuildContext context, String value){
    HapticFeedback.mediumImpact();
    bool mode = value =="dark_mode" ? true : false;
    Provider.of<ThemeProvider>(context, listen:false).toggleMode(mode);
    for (var e in listThemeMode) {
      if(e.value == value){
        e.isSelected.value = true;
      }else{
        e.isSelected.value = false;
      }
    }
  }

  void onTapBlock(BuildContext context, ProfileBlock block){
    if(block.type == ProfileType.ThemeMode){
      showDialogSelectThemeMode(context, block.blockName!);
    }else if(block.type == ProfileType.Language){
      showDialogSelectLanguage(context, block.blockName!);
    }else if(block.type == ProfileType.Products){
      Get.toNamed(PageConfig.STATISTIC);
    }else if(block.type == ProfileType.Contacts){
      Get.toNamed(PageConfig.CONTACT_MANAGER);
    }else if(block.type == ProfileType.Footer){
      Get.toNamed(PageConfig.FOOTER_MANAGER);
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
    }catch(e){
      e.printError(info: "aaaaaa");
    }
  }

  Future<void> getDataUser() async {
    try{
      CollectionReference usersReference = firestore.collection(DataRowName.Users.name);
      final getUSer = await usersReference.doc(FirebaseAuth.instance.currentUser?.email ?? '').get();
      if(getUSer.data() == null) return;
      userLogin.value = UserLogin.fromJson(getUSer.data() as Map<String, dynamic>);
      if(userLogin.value.isAdmin ?? false){
        listBlock.addAll([
          ProfileBlock(blockName: "products", page: "", icon: "", type: ProfileType.Products),
          ProfileBlock(blockName: "contact_manager", page: "/contact_manager", icon: "", type: ProfileType.Contacts),
          ProfileBlock(blockName: "footer_manager", page: "/footer_manager", icon: "", type: ProfileType.Footer),
        ]);
      }
    }catch(e){

    }
  }

  Future<void> logOutApp() async {
    await FirebaseAuth.instance.signOut();
    Get.back();
  }
}