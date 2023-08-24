import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loto/language/localization_service.dart';
import 'package:loto/page/profile/model/profile_block.dart';
import 'package:loto/src/style_resource.dart';
import 'package:loto/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}

class ProfileController extends GetxController {

  List<ProfileBlock> listBlock = [
    ProfileBlock(blockName: "theme_mode", page: "", icon: "", type: ProfileType.ThemeMode),
    ProfileBlock(blockName: "language", page: "", icon: "", type: ProfileType.Language),
  ];

  List<Locale> listLanguage = [
    Locale("vi", "VN"),
    Locale("en", "US"),
    Locale("ja", "JP"),
  ];

  void onChangeThemeMode(BuildContext context){
    HapticFeedback.mediumImpact();
    Provider.of<ThemeProvider>(context, listen:false).toggleMode();
  }

  void onTapBlock(BuildContext context, ProfileBlock block){
    if(block.type == ProfileType.ThemeMode){
      onChangeThemeMode(context);
    }else if(block.type == ProfileType.Language){
      showDialogSelectLanguage(context, block.blockName!);
    }
  }

  void test(BuildContext context){

  }

  void showDialogSelectLanguage(BuildContext context, String title){
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (builder){
          return Container(
            height: 350.0,
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(15),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)
                    )
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title.tr,
                      style: TextStyleResource.textStyleCaption(context).copyWith(fontSize: 22),
                    ),
                    SizedBox(height: 15),
                    Column(
                      children: listLanguage.map((e) {
                        return GestureDetector(
                          onTap: (){
                            LocalizationService.changeLocale(langCode: e.languageCode);
                            Get.back();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      e.languageCode.tr,
                                      style: TextStyleResource.textStyleBlack(context),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                Container(
                                  color: Colors.grey,
                                  height: 1,
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  ],
                )
            ),
          );
        }
    );
  }

}