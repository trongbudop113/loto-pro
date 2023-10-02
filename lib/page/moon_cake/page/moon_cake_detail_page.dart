import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/moon_cake/controller/moon_cake_controller.dart';
import 'package:loto/src/style_resource.dart';

class MoonCakeDetailPage extends StatelessWidget{
  final MoonCakeController controller;
  const MoonCakeDetailPage({Key? key, required this.controller, required this.childKey}) : super(key: key);

  final GlobalKey? childKey;

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      // To send the library the location of the Cart icon
      cartKey: controller.cartKey,
      height: 5,
      width: 5,
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
          title: Text(controller.moonCakeProduct?.productName ?? ''),
          centerTitle: false,
          actions: [
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
        backgroundColor: Theme.of(context).cardColor.withOpacity(0.3),
        body: SingleChildScrollView(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  key: childKey,
                  color: controller.getBackgroundColor(controller.moonCakeProduct?.productColor, context),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(50),
                  child: Image.network("https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/moon_cake.png?alt=media&token=48655c5c-b0c8-4291-b775-ec70c0011df5"),
                ),
              ),
              Container(
                height: 5,
                child: Row(
                  children: List.generate(5, (e){
                    return Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: e == 4 ? 0 : 5),
                        alignment: Alignment.center,
                        color: Colors.black,
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Text(
                  controller.moonCakeProduct?.productName ?? '',
                  style: TextStyleResource.textStyleWhite(context).copyWith(fontSize: 28),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Giá: ${controller.formatCurrency(controller.moonCakeProduct?.productPrice ?? 0)}",
                  style: TextStyleResource.textStyleBlack(context).copyWith(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Loại bánh: ${controller.moonCakeProduct?.productType}g",
                  style: TextStyleResource.textStyleBlack(context).copyWith(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Thành phần:",
                  style: TextStyleResource.textStyleGrey(context).copyWith(fontSize: 20),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10).copyWith(left: 25, right: 15),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Bột mì, đường, bơ đậu phộng, dầu ăn, bí xanh, hạt dưa, mứt sen, lạp xưởng",
                  style: TextStyleResource.textStyleGrey(context).copyWith(fontSize: 20, height: 1.3),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Trứng muối:",
                  style: TextStyleResource.textStyleGrey(context).copyWith(fontSize: 20),
                ),
              ),
              Container(
                height: 60,
                margin: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
                child: Obx(() => Row(
                    children: controller.listEgg.map((e){
                      return GestureDetector(
                        onTap: (){
                          controller.selectEgg(e);
                        },
                        child: Container(
                          width: (Get.width - 40)/ 3,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.orangeAccent.withOpacity(0.8),
                              border: Border.all(color: e.isSelect.value ? Colors.pinkAccent : Colors.transparent, width: 2)
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            e.name.toString(),
                            style: TextStyleResource.textStyleBlack(context).copyWith(fontSize: 18),
                          ),
                        ),
                      );
                    }).toList()
                )),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 60,
          color: controller.getBackgroundColor(controller.moonCakeProduct?.productColor, context),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _subtractButton(),
                    Obx(() => Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 40,
                      child: Text(
                        controller.quantity.value.toString(),
                        style: TextStyle(
                            fontSize: 18,
                            color: getTextColor(Theme.of(context).backgroundColor),
                            height: 1
                        ),
                      ),
                    )),
                    _plusButton()
                  ],
                ),
              ),
              Container(
                height: 60,
                width: 2,
                color: Colors.white,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.onClickAddToCart(childKey!),
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    child: Text(
                      "Thêm vào giỏ",
                      style: TextStyle(
                          fontSize: 18,
                          color: getTextColor(controller.getBackgroundColor(controller.moonCakeProduct?.productColor, context)),
                          height: 1
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  Color getTextColor(Color color) {
    int d = 0;

// Counting the perceptive luminance - human eye favors green color...
    double luminance =
        (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;

    if (luminance > 0.5) {
      d = 0;
    } else {
      d = 255;
    } // dark colors - white font

    return Color.fromARGB(color.alpha, d, d, d);
  }

  Widget _plusButton(){
    return GestureDetector(
      onTap: (){
        controller.onIncreaseQuantity();
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.pink
        ),
        child: const Icon(Icons.add, size: 15,),
      ),
    );
  }

  Widget _subtractButton(){
    return GestureDetector(
      onTap: (){
        controller.onDecreaseQuantity();
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.pink
        ),
        child: const Icon(Icons.add, size: 15,),
      ),
    );
  }
}
