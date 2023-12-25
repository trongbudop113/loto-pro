import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/custom_icon_icons.dart';
import 'package:loto/page/portfolior/portfolior_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class PortFoliorPage extends GetView<PortFoliorController> {
  const PortFoliorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          Obx(() => Visibility(
                visible: controller.curr.value > 1,
                child: Row(
                  children: [
                    Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/portfolio%2F20231128_141339_451.jpg?alt=media&token=015d2ab5-7946-495f-bad5-675dee644839",
                      fit: BoxFit.cover,
                      width: 120,
                      height: 90,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.yellow,
                        height: 90,
                        child: Text(
                          controller.listPage[controller.curr.value].pageName ?? '',
                          style: controller.textStyleNewFont
                              .copyWith(fontSize: 20),
                        ),
                      ),
                    )
                  ],
                ),
              )),
          Expanded(
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: controller.pageController,
              onPageChanged: (num) {
                controller.curr.value = num;
              },
              children: controller.listPage.map((e) {
                return e.page ?? const SizedBox();
              }).toList(),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        child: Obx(() => Visibility(
              visible: controller.curr.value > 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.orangeAccent),
                      child: Icon(
                        CustomIcon.left_big,
                        size: 25,
                      ),
                    ),
                    onTap: () {
                      controller.onTapForward();
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: controller.listPage.asMap().entries.map((e) {
                        return Stack(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(360),
                                  color: Colors.amber),
                              child: Obx(() => Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(360),
                                    border: Border.all(
                                      color:
                                      e.key == controller.curr.value
                                          ? Colors.black
                                          : Colors.transparent,
                                      width: 2,
                                    )),
                                alignment: Alignment.center,
                                child: Icon(
                                  e.value.pageIcon,
                                  size: 25,
                                ),
                              )),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.orangeAccent),
                      child: Icon(
                        CustomIcon.right_big,
                        size: 25,
                      ),
                    ),
                    onTap: () {
                      controller.onTapNext();
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

// Positioned(
// top: MediaQuery.of(context).padding.top + 25,
// left: 25,
// child: GestureDetector(
// child: Container(
// width: 50,
// height: 50,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(12),
// color: Colors.orangeAccent
// ),
// ),
// onTap: (){
// Get.back();
// },
// ),
// ),
