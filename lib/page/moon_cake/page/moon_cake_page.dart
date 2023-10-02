import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/moon_cake/controller/moon_cake_controller.dart';
import 'package:loto/page/moon_cake/models/moon_cake_product.dart';
import 'package:loto/page/moon_cake/widgets/animation_wrapper.dart';
import 'package:loto/shapes/quater_circle.dart';
import 'package:loto/src/style_resource.dart';

class MoonCakePage extends GetView<MoonCakeController>{
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
        duration: Duration(milliseconds: 500)
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
            //  Adding 'clear-cart-button'
            IconButton(
              icon: const Icon(Icons.cleaning_services),
              onPressed: () {
                controller.cartQuantityItems = 0;
                controller.cartKey.currentState!.runClearCartAnimation();
              },
            ),
            const SizedBox(width: 16),
            AddToCartIcon(
              key: controller.cartKey,
              icon: const Icon(Icons.shopping_cart),
              badgeOptions: const BadgeOptions(
                active: true,
                backgroundColor: Colors.red,
              ),
            ),
            const SizedBox(
              width: 16,
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 50,
              color: Colors.red,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text("Lọc theo:"),
                    ),
                  ),
                  Container(height: 50, width: 1, color: Colors.grey),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text("Loại"),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: controller.streamGetListProduct(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.9
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext ctx, index) {
                          MoonCakeProduct product = MoonCakeProduct.fromJson(snapshot.data!.docs[index].data() as Map<String, dynamic>);
                          return AppListItem(
                              onClick: controller.listClick,
                              index: index,
                              controller: controller,
                            product: product
                          );
                        }
                    );
                  }else{
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AppListItem extends StatelessWidget {
  final GlobalKey widgetKey = GlobalKey();
  final int index;
  final void Function(GlobalKey) onClick;
  final MoonCakeController controller;
  final MoonCakeProduct product;

  AppListItem({super.key, required this.onClick, required this.index, required this.controller, required this.product});
  @override
  Widget build(BuildContext context) {
    //  Container is mandatory. It can hold images or whatever you want
    ClipRRect mandatoryContainer = ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      child: Container(
        key: widgetKey,
        alignment: Alignment.center,
        color: controller.getBackgroundColor(product.productColor, context),
        padding: const EdgeInsets.all(20),
        child: Image.network(
            "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/moon_cake.png?alt=media&token=48655c5c-b0c8-4291-b775-ec70c0011df5"
        ),
      ),
    );

    return OpenContainerWrapper(
      transitionType: controller.transitionType,
      controller: controller,
      widgetKey: widgetKey,
      closedBuilder: (BuildContext _, VoidCallback openContainer) {
        return GestureDetector(
          onTap: (){
            controller.onClickDetail(product);
            openContainer.call();
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
                                  style: TextStyleResource.textStyleWhite(context).copyWith(fontSize: 18),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  controller.formatCurrency(product.productPrice ?? 0),
                                  style: TextStyleResource.textStyleBlack(context).copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => onClick(widgetKey),
                            child: Container(
                              width: 60,
                              decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(8))
                              ),
                              alignment: Alignment.center,
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(360),
                                    color: Theme.of(context).backgroundColor
                                ),
                                alignment: Alignment.center,
                                child: const Icon(Icons.add_shopping_cart_outlined, color: Colors.white, size: 18),
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
                              style: TextStyleResource.textStyleWhite(context).copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                            )
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      onClosed: _showMarkedAsDoneSnackbar,
    );
  }

  void _showMarkedAsDoneSnackbar(bool? isMarkedAsDone) {
    if (isMarkedAsDone ?? false) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text('Marked as done!'),
      ));
    }
  }
}