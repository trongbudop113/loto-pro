import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/common.dart';
import 'package:loto/page/shopping/about_us/about_page.dart';
import 'package:loto/page/shopping/blog/testimonial_navigator.dart';
import 'package:loto/page/shopping/cart/cart_page.dart';
import 'package:loto/page/shopping/contact/contact_page.dart';
import 'package:loto/page/shopping/home/home_page.dart';
import 'package:loto/page/shopping/home_main/home_main_controller.dart';
import 'package:loto/page/shopping/shop_product/shop_product_navigator.dart';

class HomeMainPage extends GetView<HomeMainController> {
  const HomeMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value) {
        controller.onBackPage(context);
      },
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFE4E6F1),
        drawer: _buildDrawer(),
        key: controller.scaffoldKey,
        body: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1440, minWidth: 600),
            child: LayoutBuilder(
              builder: (c, constraint) {
                if (constraint.constrainWidth() >= 900) {
                  if (controller.scaffoldKey.currentState?.hasDrawer ?? false) {
                    controller.scaffoldKey.currentState?.closeDrawer();
                  }
                }
                return Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      _buildAppBar(context, constraint),
                      Expanded(
                        child: Obx(() {
                          return IndexedStack(
                            index: controller.currentIndexPage.value,
                            children: const [
                              HomePage(),
                              AboutPage(),
                              ShopProductNavigator(),
                              TestimonialNavigator(),
                              ContactPage(),
                              CartPage(),
                            ],
                          );
                        }),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, BoxConstraints constraint) {
    return Container(
      child: constraint.constrainWidth() > 900
          ? Container(
              constraints: const BoxConstraints(
                maxWidth: 1440,
                minWidth: 600,
              ),
              child: buildAppBarWeb(context),
            )
          : buildAppBarMobile(context),
    );
  }

  Widget buildAppBarWeb(BuildContext context) {
    return Container(
      height: 97,
      color: const Color(0xFFFF7A00),
      padding: const EdgeInsets.symmetric(horizontal: 64),
      child: Row(
        children: [
          const Text(
            "P",
            style: TextStyle(fontSize: 30, color: Colors.white, height: 1),
          ),
          const SizedBox(width: 50),
          Container(
            width: 5,
            height: 32,
            color: Colors.white,
          ),
          const SizedBox(width: 20),
          listHeaderWidget(),
          buildCart(),
        ],
      ),
    );
  }

  Widget buildCart() {
    return GestureDetector(
      onTap: () {
        controller.onChangeTap(5);
      },
      child: Obx(() {
        if (controller.currentIndexPage.value == 5) {
          return const SizedBox();
        }
        return Container(
          width: 163,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color(0xFFFF8E25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => Container(
                  padding: const EdgeInsets.all(3),
                  alignment: Alignment.center,
                  child: Text(
                    "Giỏ hàng(${AppCommon.singleton.countCart.value.toString()})",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              const Icon(
                Icons.shopping_cart_rounded,
                color: Colors.white,
                size: 24,
              )
            ],
          ),
        );
      }),
    );
  }

  Widget buildCartMobile() {
    return GestureDetector(
      onTap: () {
        controller.onChangeTap(5);
      },
      child: Obx(() {
        if (controller.currentIndexPage.value == 5) {
          return const SizedBox(
            width: 70,
          );
        }
        return Container(
          width: 70,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color(0xFFFF8E25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() {
                return Text(
                  "(${AppCommon.singleton.countCart.value.toString()})",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                );
              }),
              const SizedBox(width: 5),
              const Icon(
                Icons.shopping_cart_rounded,
                color: Colors.white,
                size: 20,
              )
            ],
          ),
        );
      }),
    );
  }

  Widget listHeaderWidget() {
    return Expanded(
      flex: 10,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: controller.headerMenu.asMap().entries.map((e) {
            return GestureDetector(
              onTap: () {
                controller.onChangeTap(e.key);
              },
              child: Obx(() => Container(
                    height: 43,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border(
                          bottom: BorderSide(
                            color: controller.currentIndexPage.value == e.key
                                ? Colors.white
                                : Colors.transparent,
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: Text(
                        e.value,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                    ),
                  )),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget buildAppBarMobile(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: Container(
        color: const Color(0xFFFF7A00),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 97,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                if(controller.currentIndexPage.value == 5){
                  controller.onBackCart();
                  return;
                }
                controller.scaffoldKey.currentState?.openDrawer();
              },
              child: Container(
                width: 70,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xFFFF8E25),
                ),
                child: Obx((){
                  if (controller.currentIndexPage.value == 5) {
                    return const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    );
                  }
                  return const Icon(
                    Icons.menu,
                    color: Colors.white,
                  );
                }),
              ),
            ),
            const Text(
              "Pixel Baker",
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            buildCartMobile()
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: controller.headerMenu.asMap().entries.map((e) {
            return GestureDetector(
              onTap: () {
                controller.onChangeTap(e.key);
                controller.scaffoldKey.currentState?.closeDrawer();
              },
              child: Obx(() => Container(
                    height: 43,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border(
                          bottom: BorderSide(
                            color: controller.currentIndexPage.value == e.key
                                ? const Color(0xFFFF7A00)
                                : Colors.transparent,
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: Text(
                        e.value,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF7A00),
                          height: 1.2,
                        ),
                      ),
                    ),
                  )),
            );
          }).toList(),
        ),
      ),
    );
  }
}
