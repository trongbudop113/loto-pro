import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/common.dart';
import 'package:loto/page/profile/profile_controller.dart';
import 'package:loto/src/style_resource.dart';

class ProfilePage extends GetView<ProfileController>{

  @override
  Widget build(BuildContext context) {

    final int crossAxisCount = MediaQuery.of(context).size.width > 1000 ? 3 : (MediaQuery.of(context).size.width <= 600 ? 1 : 2);
    final double maxWidth = MediaQuery.of(context).size.width > 600 ? 600 : (MediaQuery.of(context).size.width - 20);
    final double maxHeight = (maxWidth * 9) / 16;

    return Scaffold(
      appBar: AppBar(
        title: Text("setting".tr),
        actions: [
          Row(
            children: [
              Visibility(
                visible: AppCommon.singleton.isLogin,
                child: GestureDetector(
                  onTap: (){
                    controller.logOutApp();
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    child: Icon(Icons.logout),
                  ),
                ),
              )
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Row(
              children: [
                SizedBox(width: 10),
                Obx(() => Container(
                  width: maxWidth,
                  height: maxHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.amber,
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(360),
                              child: Container(
                                width: 80,
                                height: 80,
                                color: Colors.black87,
                                child: Visibility(
                                  visible: (controller.userLogin.value.avatar ?? '').isEmpty,
                                  replacement: Image.network(controller.userLogin.value.avatar ?? ''),
                                  child: const Icon(Icons.manage_accounts_sharp, size: 35, color: Colors.white,),
                                ),
                              ),
                            ),
                            onTap: (){
                              controller.goToLoginApp();
                            },
                          ),
                          SizedBox(width: 10),
                          Column(
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: 'Xin chào: '),
                                    TextSpan(
                                      text: controller.userLogin.value.name ?? '',
                                      style: TextStyleResource.textStyleWhite(context),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                controller.userLogin.value.email ?? '',
                                style: TextStyleResource.textStyleWhite(context),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 25),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                controller.showDialogSelectLanguage(context, "language");
                              },
                              child: Obx(() => Container(
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(360),
                                  color: Colors.black.withOpacity(0.8),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  controller.currentLanguage.value
                                ),
                              )),
                            ),
                            GestureDetector(
                              child: Obx(() => Container(
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(360),
                                  color: Colors.black.withOpacity(0.8),
                                ),
                                child: Icon(controller.isDarkMode.value ? Icons.dark_mode : Icons.light_mode, color: Colors.white,),
                              )),
                              onTap: (){
                                controller.showDialogSelectThemeMode(context, "theme_mode");
                              },
                            ),
                            Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(360),
                                color: Colors.black.withOpacity(0.8),
                              ),
                            ),
                            Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(360),
                                color: Colors.black.withOpacity(0.8),
                              ),
                            )
                          ]
                        ),
                      )
                    ],
                  ),
                )),
                SizedBox(width: 10),
              ],
            ),
            Obx(() => GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              itemCount: controller.listBlock.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 16 / 9,
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0
              ),
              itemBuilder: (BuildContext context, int index){
                return GestureDetector(
                  onTap: (){
                    controller.onTapBlock(context, controller.listBlock[index]);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      color: Colors.amber,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Container(
                            child: Text((controller.listBlock[index].blockName ?? '').tr),
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15,),
                            alignment: Alignment.centerLeft,
                            color: Colors.black87,
                          )
                        ],
                      )
                    ),
                  ),
                );
              },
            ))
          ],
        ),
      )
    );
  }
}