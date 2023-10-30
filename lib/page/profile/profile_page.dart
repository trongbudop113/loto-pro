import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/common.dart';
import 'package:loto/page/profile/profile_controller.dart';
import 'package:loto/src/style_resource.dart';

class ProfilePage extends GetView<ProfileController>{

  @override
  Widget build(BuildContext context) {

    final int crossAxisCount = MediaQuery.of(context).size.width > 1000 ? 5 : (MediaQuery.of(context).size.width <= 600 ? 2 : 3);
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
            Row(
              children: [
                SizedBox(width: 10),
                Obx(() => Container(
                  width: maxWidth,
                  height: maxHeight,
                  color: Colors.amber,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(360),
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            children: [
                              Text("Xin chào:"),
                              Text(
                                controller.userLogin.value.name ?? '',
                                style: TextStyleResource.textStyleWhite(context),
                              ),
                              SizedBox(height: 5),
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
                          children: List.generate(4, (index) {
                            return Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(360),
                                color: Colors.black.withOpacity(0.8),
                              ),
                            );
                          }),
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
                  childAspectRatio: 1,
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0
              ),
              itemBuilder: (BuildContext context, int index){
                return GestureDetector(
                  onTap: (){
                    controller.onTapBlock(context, controller.listBlock[index]);
                  },
                  child: Container(
                    color: Colors.amber,
                    alignment: Alignment.center,
                    child: Text((controller.listBlock[index].blockName ?? '').tr),
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