import 'dart:convert';

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
import 'package:loto/src/logo_app_base_64.dart';

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
              child: _buildAppBarWeb(context),
            )
          : _buildAppBarMobile(context),
    );
  }

  Widget _buildAppBarWeb(BuildContext context) {
    return Container(
      height: 97,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF7A00), Color(0xFFFF8E25)],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 44),
      child: Row(
        children: [
          _buildLogo(),
          const SizedBox(width: 30),
          _buildDivider(),
          const SizedBox(width: 20),
          listHeaderWidget(),
          _buildCart(),
        ],
      ),
    );
  }

  Widget _buildLogo({double size = 60}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.2),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Image.memory(
        base64Decode(logoAppBase64),
        width: size,
        height: size,
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 3,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(1.5),
      ),
    );
  }

  Widget _buildAppBarMobile(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF7A00), Color(0xFFFF8E25)],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 97,
        child: Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMenuButton(),
              _buildTitle(),
              _buildCartMobile(),
            ],
          );
        }),
      ),
    );
  }

  Text _buildTitle() {
    return Text(
      controller.currentIndexPage.value == 5 ? "Giỏ Hàng" : "Bug Cake",
      style: const TextStyle(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildMenuButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (controller.currentIndexPage.value == 5) {
            controller.onBackCart();
            return;
          }
          controller.scaffoldKey.currentState?.openDrawer();
        },
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: 70,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white.withOpacity(0.2),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Icon(
            controller.currentIndexPage.value == 5
                ? Icons.arrow_back_ios_new
                : Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildCart() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => controller.onChangeTap(5),
        borderRadius: BorderRadius.circular(30),
        child: Obx(() {
          if (controller.currentIndexPage.value == 5) {
            return const SizedBox();
          }
          return Container(
            width: 163,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white.withOpacity(0.2),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => Text(
                      "Giỏ hàng(${AppCommon.singleton.countCart.value})",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    )),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.shopping_cart_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCartMobile() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => controller.onChangeTap(5),
        borderRadius: BorderRadius.circular(30),
        child: controller.currentIndexPage.value == 5
            ? const SizedBox(width: 70)
            : Container(
                width: 70,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_cart_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                    Positioned(
                      top: 6,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Obx(() => Text(
                              AppCommon.singleton.countCart.value.toString(),
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFFF8E25),
                                height: 1,
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
      ),
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

  Widget _buildDrawer() {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            _buildLogo(size: 100),
            ...controller.headerMenu.asMap().entries.map((e) {
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
        }).toList()
          ],
        ),
      ),
    );
  }
}
