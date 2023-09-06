import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/moon_cake/controller/moon_cake_controller.dart';
import 'package:loto/page/resources/image_resource.dart';
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
        rotation: true,
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
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: controller.list.length,
            itemBuilder: (BuildContext ctx, index) {
              return controller.list[index];
            }),
        // body: ListView(
        //   children: List.generate(
        //     15,
        //         (index) => AppListItem(
        //       onClick: listClick,
        //       index: index,
        //     ),
        //   ),
        // ),
      ),
    );
  }
}

class AppListItem extends StatelessWidget {
  final GlobalKey widgetKey = GlobalKey();
  final int index;
  final void Function(GlobalKey) onClick;

  AppListItem({super.key, required this.onClick, required this.index});
  @override
  Widget build(BuildContext context) {
    //  Container is mandatory. It can hold images or whatever you want
    Container mandatoryContainer = Container(
      key: widgetKey,
      width: 60,
      height: 60,
      color: Colors.transparent,
      child: Image.network(
        "https://cdn.jsdelivr.net/gh/omerbyrk/add_to_cart_animation/example/assets/apple.png",
        width: 60,
        height: 60,
      ),
    );

    return GestureDetector(
      onTap: () => onClick(widgetKey),
      child: Container(
        color: Colors.amberAccent,
        child: Column(
          children: [
            mandatoryContainer,
            Text(
              "Animated Apple Product Image $index",
            )
          ],
        ),
      )
    );
  }
}