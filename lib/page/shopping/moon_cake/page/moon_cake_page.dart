import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/custom_icon_icons.dart';
import 'package:loto/page/shopping/moon_cake/controller/moon_cake_controller.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product.dart';
import 'package:loto/page_config.dart';
import 'package:loto/shapes/quater_circle.dart';
import 'package:loto/src/style_resource.dart';

class MoonCakePage extends GetView<MoonCakeController> {
  const MoonCakePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      // To send the library the location of the Cart icon
      cartKey: controller.cartKey,
      height: 30,
      width: 30,
      opacity: 0.85,
      dragAnimation: const DragToCartAnimationOptions(
        rotation: false,
        duration: Duration(milliseconds: 500),
      ),
      jumpAnimation: const JumpAnimationOptions(),
      createAddToCartAnimation: (runAddToCartAnimation) {
        // You can run the animation by addToCartAnimationMethod, just pass trough the the global key of  the image as parameter
        controller.runAddToCartAnimation = runAddToCartAnimation;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("moon_cake".tr),
          centerTitle: false,
          actions: [
            GestureDetector(
              onTap: () {
                Get.toNamed(PageConfig.CART);
              },
              child: AddToCartIcon(
                key: controller.cartKey,
                icon: const Icon(Icons.shopping_cart),
                badgeOptions: const BadgeOptions(
                  active: true,
                  backgroundColor: Colors.red,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            )
          ],
        ),
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Lọc theo:",
                            style: TextStyleResource.textStyleBlack(context),
                          ),
                        ),
                      ),
                      Container(height: 50, width: 1, color: Colors.grey),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration:
                                BoxDecoration(border: Border.all(width: 1.5)),
                            alignment: Alignment.center,
                            child: Text(
                              "Loại",
                              style: TextStyleResource.textStyleBlack(context),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: controller.streamGetListProduct(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Obx(() => GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 0.9,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ).copyWith(
                                bottom: MediaQuery.of(context).padding.bottom +
                                    80 +
                                    (controller.isStatusBuyBox.value ? 110 : 0),
                              ),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext ctx, index) {
                                CakeProduct product = CakeProduct.fromJson(
                                    snapshot.data!.docs[index].data()
                                        as Map<String, dynamic>);
                                return AppListItem(
                                    onClick: controller.listClick,
                                    index: index,
                                    controller: controller,
                                    product: product);
                              }));
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
              ],
            ),
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 10 + 55 + 10,
              left: 10,
              right: 90,
              child: Obx(() => Visibility(
                    visible: controller.isStatusBuyBox.value,
                    child: GestureDetector(
                      onTap: () {
                        controller.showBoxCakeDialog(context);
                      },
                      child: Container(
                        height: 100,
                        color: Colors.black12,
                        child: ListView.separated(
                          itemBuilder: (c, i) {
                            return Container(
                              width: 100,
                              height: 100,
                              color: Colors.white60,
                              child: Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                            );
                          },
                          separatorBuilder: (c, i) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                          itemCount:
                              controller.productOrder?.boxCake!.productType ??
                                  0,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ),
                  )),
            ),
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 10,
              left: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  controller.showBoxCakeDialog(context);
                },
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.amber,
                  ),
                  alignment: Alignment.center,
                  child: Obx(() => Visibility(
                        visible: controller.isStatusBuyBox.value,
                        replacement: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(CustomIcon.gift,
                                color: Colors.white, size: 18),
                            SizedBox(width: 10),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                "Mua Theo Hộp",
                                style:
                                    TextStyleResource.textStyleWhite(context),
                              ),
                            )
                          ],
                        ),
                        child: Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                            "Thêm vào giỏ hàng",
                            style: TextStyleResource.textStyleWhite(context),
                          ),
                        ),
                      )),
                ),
              ),
            )
          ],
        ),
        floatingActionButton: DraggableFab(
          initPosition: Offset(Get.width - 10, Get.height - 70),
          securityBottom: 80,
          child: FloatingActionButton(
            onPressed: () {
              controller.goToCart();
            },
            child: Icon(CustomIcon.shopping_cart),
          ),
        ),
      ),
    );
  }
}

class AppListItem extends StatelessWidget {
  final int index;
  final void Function() onClick;
  final MoonCakeController controller;
  final CakeProduct product;

  AppListItem(
      {super.key,
      required this.onClick,
      required this.index,
      required this.controller,
      required this.product});
  @override
  Widget build(BuildContext context) {
    //  Container is mandatory. It can hold images or whatever you want
    ClipRRect mandatoryContainer = ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      child: Container(
        alignment: Alignment.center,
        color: controller.getBackgroundColor(product.productColor, context),
        padding: const EdgeInsets.all(20),
        child: Image.network(
            "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/moon_cake.png?alt=media&token=48655c5c-b0c8-4291-b775-ec70c0011df5"),
      ),
    );

    return GestureDetector(
      onTap: () {
        controller.onClickDetail(product);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              //spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: mandatoryContainer,
                ),
                SizedBox(
                  height: 60,
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 5),
                            Text(
                              product.productName.toString(),
                              style: TextStyleResource.textStyleWhite(context)
                                  .copyWith(fontSize: 15),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              controller
                                  .formatCurrency(product.productPrice ?? 0),
                              style: TextStyleResource.textStyleBlack(context)
                                  .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => onClick,
                        child: Container(
                          width: 60,
                          decoration: const BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(8))),
                          alignment: Alignment.center,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(360),
                                color: Theme.of(context).backgroundColor),
                            alignment: Alignment.center,
                            child: const Icon(Icons.add_shopping_cart_outlined,
                                color: Colors.white, size: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Stack(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    alignment: Alignment.topRight,
                    child: const QuarterCircle(
                      circleAlignment: CircleAlignment.topRight,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 15,
                    left: 10,
                    right: 0,
                    child: Center(
                        child: Text(
                      "${product.productType}g",
                      style: TextStyleResource.textStyleWhite(context)
                          .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
