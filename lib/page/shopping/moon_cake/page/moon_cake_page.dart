import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/common.dart';
import 'package:loto/common/custom_icon_icons.dart';
import 'package:loto/page/shopping/moon_cake/controller/moon_cake_controller.dart';
import 'package:loto/page/shopping/moon_cake/items/moon_cake_item.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product.dart';
import 'package:loto/src/style_resource.dart';

class MoonCakePage extends GetView<MoonCakeController> {
  const MoonCakePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("moon_cake".tr),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          _buildListProduct(context),
          _buildProductSelectBox(context),
          _buildBottomWidget(context)
        ],
      ),
      floatingActionButton: _buildFloatWidget(context),
    );
  }

  DraggableFab _buildFloatWidget(BuildContext context) {
    return DraggableFab(
      initPosition: Offset(Get.width - 10, Get.height - 70),
      securityBottom: 80,
      child: FloatingActionButton(
        onPressed: () {
          controller.goToCart();
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Icon(CustomIcon.shopping_cart),
            ),
            Positioned(
              bottom: 6,
              right: 6,
              child: Obx(() => Container(
                    padding: EdgeInsets.all(3),
                    alignment: Alignment.center,
                    child: Text(
                      AppCommon.singleton.countCart.value.toString(),
                      style: TextStyleResource.textStyleBlack(context).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Positioned _buildBottomWidget(BuildContext context) {
    return Positioned(
        bottom: MediaQuery.of(context).padding.bottom + 10,
        left: 10,
        right: 10,
        child: Obx(() => Visibility(
              visible: !controller.isStatusBuyBox.value,
              replacement: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        controller.onTapDeleteBuyBox();
                      },
                      child: Container(
                        height: 55,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            bottomLeft: Radius.circular(60),
                          ),
                          color: Colors.redAccent,
                        ),
                        alignment: Alignment.center,
                        child: Text("Xóa"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        controller.onShowOrCompleteBuyBox(context);
                      },
                      child: Container(
                        height: 55,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(60),
                            bottomRight: Radius.circular(60),
                          ),
                          color: Colors.amber,
                        ),
                        alignment: Alignment.center,
                        child: Text("Thêm vào giỏ"),
                      ),
                    ),
                  )
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  controller.onShowOrCompleteBuyBox(context);
                },
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.amber,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        CustomIcon.gift,
                        color: Colors.white,
                        size: 18,
                      ),
                      SizedBox(width: 10),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          "Mua Theo Hộp",
                          style: TextStyleResource.textStyleWhite(context),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }

  Positioned _buildProductSelectBox(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).padding.bottom + 10 + 55 + 10,
      left: 10,
      right: 90,
      child: Obx(
        () => Visibility(
          visible: controller.isStatusBuyBox.value,
          child: Container(
            height: 100,
            color: Colors.black12,
            child: ListView.separated(
              itemBuilder: (c, i) {
                if (i > controller.listCakeBoxTemp.length - 1) {
                  return Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(Icons.add),
                  );
                }
                return Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: controller.getBackgroundColor(
                            controller.listCakeBoxTemp[i].productColor,
                            context),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Image.network(
                        "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/moon_cake.png?alt=media&token=48655c5c-b0c8-4291-b775-ec70c0011df5",
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        decoration: const BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "${controller.listCakeBoxTemp[i].productType}g - ${controller.listCakeBoxTemp[i].numberEggs}T")
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          controller.onRemoveItemInBox(i);
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.center,
                          color: Colors.transparent,
                          child: const Icon(
                            Icons.highlight_remove_outlined,
                            size: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
              separatorBuilder: (c, i) {
                return const SizedBox(
                  width: 10,
                );
              },
              itemCount: controller.listCakeBoxTemp.length +
                  ((controller.productOrder?.boxCake?.productType ?? 0) -
                      controller.listCakeBoxTemp.length),
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListProduct(BuildContext context) {
    int countColumn = context.isLargeTablet ? 5 : (context.isTablet ? 3 : 2);
    return Column(
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
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5),
                    ),
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: countColumn,
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
                            index: index,
                            controller: controller,
                            product: product,
                          );
                        },
                      ));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ],
    );
  }
}
