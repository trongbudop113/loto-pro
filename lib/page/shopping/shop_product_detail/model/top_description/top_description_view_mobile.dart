import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/shop_product_detail/model/top_description/top_description_model.dart';
import 'package:loto/src/style_resource.dart';

class TopDescriptionViewMobile extends StatelessWidget {
  final TopDescriptionModel model;
  const TopDescriptionViewMobile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Obx(() {
      return Column(
        children: [
          _buildProductImage(context),
          const SizedBox(height: 10),
          _buildListImage(context),
          _buildDetail(context, width),
        ],
      );
    });
  }

  Widget _buildProductImage(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Obx(() {
            return Container(
              color: model.getBackgroundColor(
                model.moonCakeProduct.value.productColor,
                context,
              ),
              padding: const EdgeInsets.all(5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  model.currentImage.value,
                  fit: BoxFit.fill,
                ),
              ),
            );
          }),
        ),
        Positioned(
            top: 10,
            left: 10,
            child: GestureDetector(
              onTap: () {
                Get.nestedKey(1)?.currentState?.pop();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(360),
                  color: Colors.white70,
                ),
                width: 50,
                height: 50,
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ))
      ],
    );
  }

  Widget _buildListImage(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 102,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: (model.moonCakeProduct.value.productImages ?? []).length,
        itemBuilder: (c, i) {
          return GestureDetector(
            onTap: () {
              model.onTapViewImage(
                  (model.moonCakeProduct.value.productImages ?? [])[i]);
            },
            child: Container(
              height: 102,
              width: 102,
              padding: const EdgeInsets.all(5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: model.getBackgroundColor(
                  model.moonCakeProduct.value.productColor,
                  context,
                ),
              ),
              child: Image.network(
                (model.moonCakeProduct.value.productImages ?? [])[i] ?? '',
                fit: BoxFit.fill,
              ),
            ),
          );
        },
        separatorBuilder: (c, i) {
          return const SizedBox(width: 10);
        },
      ),
    );
  }

  Padding _buildDetail(BuildContext context, double width) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            model.moonCakeProduct.value.productName ?? '',
            style: const TextStyle(
              fontSize: 28,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Obx(() {
            return Row(
              children: [
                const Text(
                  "Giá: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF7500),
                    fontSize: 23,
                  ),
                ),
                Text(
                  model.formatCurrency(model.productPrice.value),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF7500),
                    fontSize: 25,
                  ),
                ),
              ],
            );
          }),
          Html(
            data: model.moonCakeProduct.value.productDescription ?? '',
            style: {
              "p": Style(
                fontSize: FontSize(20),
                color: Colors.black,
                fontWeight: FontWeight.w400,
              )
            },
          ),
          const SizedBox(height: 20),
          _buildSelectEggs(context, width),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: 140,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  color: const Color(0xFFFF7500).withOpacity(0.8),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Mua ngay",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 50),
              Container(
                width: 150,
                height: 58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  border: Border.all(color: Colors.black, width: 1.5),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 18),
                    GestureDetector(
                      onTap: () {
                        model.onDecreaseQuantity();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.transparent,
                        child: Icon(
                          Icons.remove_circle_outline,
                          color: const Color(0xFFFF7500).withOpacity(0.8),
                          size: 15,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Obx(() {
                        return Center(
                          child: Text(
                            "${model.quantity.value}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFFF7500).withOpacity(0.8),
                            ),
                          ),
                        );
                      }),
                    ),
                    GestureDetector(
                      onTap: () {
                        model.onIncreaseQuantity();
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(360),
                          color: const Color(0xFFFF7500).withOpacity(0.8),
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.add_circle_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 18),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              model.onClickAddToCart();
            },
            child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: const Color(0xFFFF7500).withOpacity(0.8),
              ),
              alignment: Alignment.center,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Thêm vào giỏ",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSelectEggs(BuildContext context, double width) {
    return Obx(() {
      if (model.moonCakeProduct.value.productCategory != 4) {
        return const SizedBox();
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Chọn trứng",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 60,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: model.listEgg.length,
              itemBuilder: (c, i) {
                var e = model.listEgg[i];
                return GestureDetector(
                  onTap: () {
                    model.selectEgg(e);
                  },
                  child: Obx(() {
                    return Container(
                      width: (width - 40) / 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.orangeAccent.withOpacity(0.8),
                        border: Border.all(
                          color: e.isSelect.value
                              ? Colors.pinkAccent
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        e.name.toString(),
                        style: TextStyleResource.textStyleBlack(context)
                            .copyWith(fontSize: 18),
                      ),
                    );
                  }),
                );
              },
              separatorBuilder: (c, i) {
                return const SizedBox(width: 10);
              },
            ),
          ),
          const SizedBox(height: 10),
        ],
      );
    });
  }
}
