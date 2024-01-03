import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/custom_icon_icons.dart';
import 'package:loto/core/custom_get_view.dart';
import 'package:loto/page/portfolior/portfolior_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class PortFoliorPage extends CustomGetView<PortFoliorController> {
  PortFoliorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: buildBody(context),
      bottomNavigationBar: _buildNavigation(),
    );
  }

  @override
  Widget buildBodyMobile(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        _buildContentMobile(),
      ],
    );
  }

  @override
  Widget buildBodyTablet(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        _buildContentMobile(),
      ],
    );
  }

  @override
  Widget buildBodyWeb(BuildContext context) {
    return Row(
      children: [
        _buildHeader(context),
        Expanded(
          flex: 8,
          child: _buildContentWeb(),
        )
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.curr.value > 1,
        child: context.isLargeTablet ? Expanded(
          flex: 2,
          child: AnimatedOpacity(
            opacity: controller.curr.value > 1 ? 1 : 0,
            duration: const Duration(milliseconds: 2000),
            child: _buildHeaderContent(context),
          ),
        ) : AnimatedOpacity(
          opacity: controller.curr.value > 1 ? 1 : 0,
          duration: const Duration(milliseconds: 2000),
          child: _buildHeaderContent(context),
        )
      ),
    );
  }

  Widget _buildHeaderContent(BuildContext context) {
    if (context.isLargeTablet) {
      return Column(
        children: [
          _buildHeaderContentImage(),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              color: Colors.yellow,
              height: Get.height,
              child: Text(
                controller.listPage[controller.curr.value].pageName ?? '',
                style: controller.textStyleNewFont.copyWith(
                  fontSize: 20,
                ),
              ),
            ),
          )
        ],
      );
    }
    return SizedBox(
      height: 90,
      child: Row(
        children: [
          _buildHeaderContentImage(),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              color: Colors.yellow,
              child: Text(
                controller.listPage[controller.curr.value].pageName ?? '',
                style: controller.textStyleNewFont.copyWith(
                  fontSize: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeaderContentImage() {
    return Image.network(
      "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/portfolio%2F20231128_141339_451.jpg?alt=media&token=015d2ab5-7946-495f-bad5-675dee644839",
      fit: BoxFit.cover,
    );
  }

  Widget _buildContentMobile() {
    return Expanded(
      child: _buildPageView(),
    );
  }

  Widget _buildPageView() {
    return PageView.builder(
      key: controller.key,
      scrollDirection: Axis.horizontal,
      controller: controller.pageController,
      onPageChanged: (num) {
        controller.curr.value = num;
      },
      itemBuilder: (c, i) {
        return controller.listPage[i].page ?? const SizedBox();
      },
    );
  }

  Widget _buildContentWeb() {
    return _buildPageView();
  }

  Widget _buildNavigation() {
    return Obx(() => Visibility(
          visible: controller.curr.value > 0,
          maintainState: true,
          maintainAnimation: true,
          child: AnimatedOpacity(
            opacity: controller.curr.value > 0 ? 1 : 0,
            duration: Duration(milliseconds: 500),
            child: BottomAppBar(
              color: Colors.transparent,
              elevation: 0,
              child: Container(
                margin: const EdgeInsets.only(
                  bottom: 10,
                  left: 10,
                  right: 10,
                ),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.yellow),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(360),
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
                    Spacer(flex: 1,),
                    Expanded(
                      flex: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: controller.listPage.asMap().entries.map((e) {
                          return GestureDetector(
                            child: Container(
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
                                          color: e.key == controller.curr.value
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
                            onTap: () {
                              controller.onTapItemIndex(e.key);
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    Spacer(flex: 1,),
                    GestureDetector(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(360),
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
              ),
            ),
          ),
        ));
  }

  @override
  Widget buildBody(BuildContext context) {
    if (context.isLargeTablet) {
      return buildBodyWeb(context);
    }
    if (context.isTablet) {
      return buildBodyTablet(context);
    }
    if (context.isPhone) {
      return buildBodyMobile(context);
    }

    return buildBodyWeb(context);
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
