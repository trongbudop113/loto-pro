import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/custom_icon_icons.dart';
import 'package:loto/page/shopping/moon_cake/controller/moon_cake_controller.dart';
import 'package:loto/page/shopping/moon_cake/items/moon_cake_item.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product.dart';
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
        ),
        body: Stack(
          children: [
            _buildListProduct(context),
            _buildProductSelectBox(context),
            _buildBottomWidget(context)
          ],
        ),
        floatingActionButton: _buildFloatWidget(),
      ),
    );
  }

  DraggableFab _buildFloatWidget(){
    return DraggableFab(
      initPosition: Offset(Get.width - 10, Get.height - 70),
      securityBottom: 80,
      child: FloatingActionButton(
        onPressed: () {
          controller.goToCart();
        },
        child: const Icon(CustomIcon.shopping_cart),
      ),
    );
  }

  Positioned _buildBottomWidget(BuildContext context){
    return Positioned(
      bottom: MediaQuery.of(context).padding.bottom + 10,
      left: 10,
      right: 10,
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
          child: Obx(() => Visibility(
            visible: controller.isStatusBuyBox.value,
            replacement: Row(
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
    );
  }

  Positioned _buildProductSelectBox(BuildContext context){
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
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: const Icon(Icons.add),
                  );
                }
                return Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: controller.getBackgroundColor(controller.listCakeBoxTemp[i].productColor, context),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Image.network(
                    "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/moon_cake.png?alt=media&token=48655c5c-b0c8-4291-b775-ec70c0011df5",
                  ),
                );
              },
              separatorBuilder: (c, i) {
                return const SizedBox(
                  width: 10,
                );
              },
              itemCount: controller.listCakeBoxTemp.length +
                  ((controller.productOrder?.boxCake!.productType ??
                      0) -
                      controller.listCakeBoxTemp.length),
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListProduct(BuildContext context){
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
                      bottom:
                      MediaQuery.of(context).padding.bottom +
                          80 +
                          (controller.isStatusBuyBox.value
                              ? 110
                              : 0),
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
