import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/common.dart';
import 'package:loto/page/shopping/moon_cake/controller/moon_cake_detail_controller.dart';
import 'package:loto/src/color_resource.dart';
import 'package:loto/src/style_resource.dart';

class MoonCakeDetailPage extends GetView<MoonCakeDetailController> {
  const MoonCakeDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final double maxWidthImage = width * 0.4 > 800 ? 800 : (width * 0.4);

    return Scaffold(
      appBar: AppBar(
        title: Text(controller.moonCakeProduct?.productName ?? ''),
        centerTitle: false,
        actions: [
          Container(
            alignment: Alignment.center,
            color: Colors.transparent,
            width: 56,
            child: Stack(
              children: [
                const Positioned.fill(child: Icon(Icons.shopping_cart)),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Obx(
                    () => Container(
                      width: 15,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.amber,
                      ),
                      child: Text(
                        AppCommon.singleton.currentProductInCart.length
                            .toString(),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            context.isLargeTablet
                ? Row(
                    children: [
                      _buildImage("", context,
                          width: maxWidthImage, height: maxWidthImage),
                      const SizedBox(
                        width: 5,
                      ),
                      _buildListImage(context, width: width),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: _buildDescription(context, width: width),
                      )
                    ],
                  )
                : Column(
                    children: [
                      _buildImage("", context, width: width, height: width),
                      _buildListImage(context, width: width),
                      _buildDescription(context, width: width)
                    ],
                  ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                "Trứng muối:",
                style: TextStyleResource.textStyleGrey(context)
                    .copyWith(fontSize: 20),
              ),
            ),
            Container(
              height: 60,
              margin: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
              child: Obx(
                () => Row(
                  children: controller.listEgg.map((e) {
                    return GestureDetector(
                      onTap: () {
                        controller.selectEgg(e);
                      },
                      child: Container(
                        width: (width - 40) / 3,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.orangeAccent.withOpacity(0.8),
                            border: Border.all(
                                color: e.isSelect.value
                                    ? Colors.pinkAccent
                                    : Colors.transparent,
                                width: 2)),
                        alignment: Alignment.center,
                        child: Text(
                          e.name.toString(),
                          style: TextStyleResource.textStyleBlack(context)
                              .copyWith(fontSize: 18),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: controller.getBackgroundColor(
            controller.moonCakeProduct?.productColor, context),
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
                              color: getTextColor(
                                  ColorResource.color_background_light),
                              height: 1),
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
                onTap: () => controller.onClickAddToCart(),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  child: Text(
                    "Thêm vào giỏ",
                    style: TextStyle(
                        fontSize: 18,
                        color: getTextColor(controller.getBackgroundColor(
                            controller.moonCakeProduct?.productColor, context)),
                        height: 1),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String image, BuildContext context,
      {required double width, required double height}) {
    return Container(
      width: width,
      height: width,
      color: controller.getBackgroundColor(
          controller.moonCakeProduct?.productColor, context),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
      child: Image.network(
        width: width,
        height: width,
        controller.moonCakeProduct?.productImageMain ?? '',
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildDescription(BuildContext context, {required double width}) {
    final double maxWidthImage = width * 0.4 > 800 ? 800 : (width * 0.4);
    final double? maxHeightDes = context.isLargeTablet ? maxWidthImage : null;

    return SizedBox(
      height: maxHeightDes,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              controller.moonCakeProduct?.productName ?? '',
              style: TextStyleResource.textStyleWhite(context)
                  .copyWith(fontSize: 28),
            ),
          ),
          Obx(() => Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Giá: ${controller.formatCurrency(controller.productPrice.value)}",
                  style: TextStyleResource.textStyleBlack(context)
                      .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              )),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            alignment: Alignment.centerLeft,
            child: Text(
              "Loại bánh: ${controller.moonCakeProduct?.productType}g",
              style: TextStyleResource.textStyleBlack(context)
                  .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            alignment: Alignment.centerLeft,
            child: Text(
              "Thành phần:",
              style: TextStyleResource.textStyleGrey(context)
                  .copyWith(fontSize: 20),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10)
                .copyWith(left: 25, right: 15),
            alignment: Alignment.centerLeft,
            child: Text(
              controller.moonCakeProduct?.productDescription ?? '',
              style: TextStyleResource.textStyleGrey(context)
                  .copyWith(fontSize: 20, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListImage(BuildContext context, {required double width}) {
    final double maxWidthImage = width * 0.4 > 800 ? 800 : (width * 0.4);
    final double height =
        context.isLargeTablet ? maxWidthImage : ((width - 20) / 5);
    final double widthList =
        context.isLargeTablet ? ((height - 20) / 5) : width;
    final Axis direction =
        context.isLargeTablet ? Axis.vertical : Axis.horizontal;
    final double? heightItem =
        context.isLargeTablet ? ((height - 20) / 5) : null;
    final double mgRight = context.isLargeTablet ? 0 : 5;
    final double mgBottom = context.isLargeTablet ? 5 : 0;

    return Container(
        margin: const EdgeInsets.only(top: 5),
        height: height,
        width: widthList,
        child: ListView.builder(
            scrollDirection: direction,
            itemCount: (controller.moonCakeProduct?.productImages ?? []).length,
            itemBuilder: (c, i) {
              return Container(
                height: heightItem,
                padding: const EdgeInsets.all(5),
                margin: EdgeInsets.only(right: mgRight, bottom: mgBottom),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: controller.getBackgroundColor(
                      controller.moonCakeProduct?.productColor, context),
                ),
                child: Image.network(
                  (controller.moonCakeProduct?.productImages ?? [])[i] ?? '',
                  fit: BoxFit.fill,
                ),
              );
            }));
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

  Widget _plusButton() {
    return GestureDetector(
      onTap: () {
        controller.onIncreaseQuantity();
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.pink),
        child: const Icon(
          Icons.add,
          size: 15,
        ),
      ),
    );
  }

  Widget _subtractButton() {
    return GestureDetector(
      onTap: () {
        controller.onDecreaseQuantity();
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.pink),
        child: const Icon(
          Icons.remove,
          size: 15,
        ),
      ),
    );
  }
}
