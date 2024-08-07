import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/common.dart';
import 'package:loto/common/custom_icon_icons.dart';
import 'package:loto/page/shopping/moon_cake/controller/moon_cake_controller.dart';
import 'package:loto/page/shopping/moon_cake/items/moon_cake_item.dart';
import 'package:loto/src/style_resource.dart';

class MoonCakePage extends GetView<MoonCakeController> {
  const MoonCakePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          //_buildMainWidget(context),
          _buildSliverList(width, context),
          _buildProductSelectBox(context),
          _buildBottomWidget(context),
          _buildFloatWidget(context)
        ],
      ),
      //floatingActionButton: _buildFloatWidget(context),
    );
  }

  Widget _buildSliverList(double width, BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          snap: false,
          floating: false,
          expandedHeight: (width * 0.41) + Get.mediaQuery.padding.top + 60,
          collapsedHeight: 60,
          actions: [
            const SizedBox(
              width: 60,
              height: 60,
              child: Icon(Icons.home),
            ),
            const Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                "Pixel Baker",
                style: TextStyleResource.textStyleBlack(context).copyWith(
                  color: Color(0xFFFE8160),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            GestureDetector(
              onTap: (){
                controller.goToCart();
              },
              child: Container(
                width: 60,
                height: 60,
                color: Colors.transparent,
                child: const Icon(Icons.shopping_cart),
              ),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: _buildBanner(context),
          ),
        ),
        SliverAppBar(
          pinned: true,
          snap: false,
          floating: false,
          expandedHeight: 70,
          collapsedHeight: 70,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          flexibleSpace: FlexibleSpaceBar(
            background: _buildSearchBar(context),
          ),
        ),
        _buildListProduct(context),
      ],
    );
  }

  Positioned _buildFloatWidget(BuildContext context) {
    return Positioned(
      bottom: 150,
      right: 10,
      child: FloatingActionButton(
        onPressed: () {
          controller.goToCart();
        },
        child: Stack(
          children: [
            const Positioned.fill(
              child: Icon(CustomIcon.shopping_cart),
            ),
            Positioned(
              bottom: 6,
              right: 6,
              child: Obx(
                () => Container(
                  padding: EdgeInsets.all(3),
                  alignment: Alignment.center,
                  child: Text(
                    AppCommon.singleton.countCart.value.toString(),
                    style: TextStyleResource.textStyleBlack(context).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
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
                        controller.listCakeBoxTemp[i].productImageMain ?? '',
                        fit: BoxFit.cover,
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
                              "${controller.listCakeBoxTemp[i].productType}g - ${controller.listCakeBoxTemp[i].numberEggs}T",
                            )
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
    int countColumn = context.mediaQuerySize.width > 1300
        ? 5
        : (context.mediaQuerySize.width < 600 ? 2 : 3);
    return SliverToBoxAdapter(
      child: Obx(() {
        if (controller.isLoadingData.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Obx(() => GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: countColumn,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 179 / 239,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ).copyWith(
                bottom: MediaQuery.of(context).padding.bottom +
                    80 +
                    (controller.isStatusBuyBox.value ? 110 : 0),
              ),
              itemCount: controller.listCake.length,
              itemBuilder: (BuildContext ctx, index) {
                return MoonCakeProductItem(
                  controller: controller,
                  productModel: controller.listCake[index],
                );
              },
            ));
      }),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 1.5, color: Colors.black)),
              child: TextField(
                controller: controller.searchController,
                cursorRadius: const Radius.circular(10),
                style: TextStyleResource.textStyleBlack(context).copyWith(
                  height: 1,
                  fontSize: 14,
                ),
                onChanged: (value) {
                  controller.onChangeSearchCake(value);
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 15),
                  border: InputBorder.none, // Loại bỏ viền
                  hintMaxLines: 1,
                  hintText: 'Bạn muốn tìm bánh nào...',
                  labelStyle:
                      TextStyleResource.textStyleBlack(context).copyWith(
                    height: 1,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  hintStyle: TextStyleResource.textStyleGrey(context).copyWith(
                    height: 1,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: (){
              controller.showFilterDialog(context);
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              child: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildBanner(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 60),
      color: Color(0xFFFAE8D4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Pixel Baker",
                style: TextStyleResource.textStyleBlack(context).copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Xin chào",
                style: TextStyleResource.textStyleBlack(context).copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.network(
              "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/moon_cake.png?alt=media&token=a7d877c5-69d8-4d54-b218-e18d486421de",
            ),
          ),
        ],
      ),
    );
  }
}
