import 'package:carousel_slider/carousel_slider.dart';
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
    final double width = MediaQuery.of(context).size.width > 1600
        ? 1600
        : MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: Drawer(
        child: _buildDrawer(context),
      ),
      key: controller.scaffoldKey,
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1600,
            minWidth: 600,
          ),
          child: Stack(
            children: [
              //_buildMainWidget(context),
              _buildSliverList(width, context),
              _buildProductSelectBox(context),
              _buildBottomWidget(context),
              _buildFloatWidget(context)
            ],
          ),
        ),
      ),
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
            GestureDetector(
              onTap: () {
                controller.onTapMenu(context);
              },
              child: Container(
                color: Colors.transparent,
                width: 60,
                height: 60,
                child: const Icon(Icons.menu),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                "Pixel Baker",
                style: TextStyleResource.textStyleBlack(context).copyWith(
                  color: const Color(0xFFFE8160),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            GestureDetector(
              onTap: () {
                controller.goToCart();
              },
              child: Stack(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    color: Colors.transparent,
                    child: const Icon(Icons.shopping_cart),
                  ),
                  Positioned(
                    bottom: 6,
                    right: 6,
                    child: Obx(
                      () => Container(
                        padding: const EdgeInsets.all(3),
                        alignment: Alignment.center,
                        child: Text(
                          AppCommon.singleton.countCart.value.toString(),
                          style: TextStyleResource.textStyleBlack(context)
                              .copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
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
          expandedHeight: 125 + 70,
          collapsedHeight: 125 + 70,
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
                  padding: const EdgeInsets.all(3),
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
      child: Obx(
        () => Visibility(
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
                    child: const Text("Xóa"),
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
                    child: const Text("Thêm vào giỏ"),
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
                  const SizedBox(width: 10),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Text(
                      "Mua Theo Hộp",
                      style: TextStyleResource.textStyleWhite(context),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white54,
                    ),
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
                              style: TextStyleResource.textStyleWhite(context),
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
                          padding: const EdgeInsets.all(5),
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

  Widget _buildListCategory(BuildContext context) {
    return Container(
      height: 110,
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: 10),
      child: ListView.separated(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (c, i) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  colors: [
                    Color(
                      int.parse("0xFFFFFF00"),
                    ).withOpacity(0.1),
                    Color(
                      int.parse("0xFFFFFF00"),
                    ),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0, 1],
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.light_mode,
                    size: 50,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Bánh bông lan",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (c, i) {
          return const SizedBox(
            width: 40,
          );
        },
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
    return Column(
      children: [
        SizedBox(
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
                    border: Border.all(width: 1.5, color: Colors.black),
                  ),
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
                      hintStyle:
                          TextStyleResource.textStyleGrey(context).copyWith(
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
                onTap: () {
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
        ),
        _buildListCategory(context)
      ],
    );
  }

  Widget shopBanner(BuildContext context){
    return   Row(
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
    );
  }

  Widget _buildBanner(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 60),
      color: const Color(0xFFFAE8D4),
      child: CarouselSlider(
        //carouselController: controller.bannerController,
        options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            enlargeCenterPage: true,
            autoPlayInterval: const Duration(seconds: 10 ),
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            onPageChanged: (index, c){
              //controller.onPageChange(index);
            }
        ),
        items: List.generate(2, (e) {
          if(e == 1){
            return shopBanner(context);
          }
          return Stack(
            children: [
              Container(
                alignment: Alignment.center,
                //child: Image.network(banner.bannerImage ?? '', fit: BoxFit.fill)
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Chao mừng den voi tiệm bánh Chui"),
                    Text("Chuyen cung cap nhung loai banh kem chat luong"),
                  ],
                ),
              ),

            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 100,
            ),
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: (){
                  controller.onCloseDraw();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  color: Colors.transparent,
                  child: const Icon(Icons.close),
                ),
              ),
            )
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          child: Text(
            "Thông Tin Huu Ich",
            style: TextStyleResource.textStyleBlack(context),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          child: Text(
            "Cong Thuc Lam Banh",
            style: TextStyleResource.textStyleBlack(context),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          child: Text(
            "Phan Tích",
            style: TextStyleResource.textStyleBlack(context),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          child: Text(
            "Dat Hang",
            style: TextStyleResource.textStyleBlack(context),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          child: Text(
            "Phan Tich Cong Thuc",
            style: TextStyleResource.textStyleBlack(context),
          ),
        )
      ],
    );
  }
}
