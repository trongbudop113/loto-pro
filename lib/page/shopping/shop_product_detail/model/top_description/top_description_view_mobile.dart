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
          Container(
            constraints: BoxConstraints(
              maxWidth: width > 768 ? 600 : width,
              maxHeight: width > 768 ? 500 : width,
            ),
            child: _buildProductImage(context),
          ),
          const SizedBox(height: 10),
          Container(
            constraints: BoxConstraints(
              maxWidth: width > 768 ? 600 : width,
            ),
            child: _buildListImage(context),
          ),
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
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: model.getBackgroundColor(
                  model.moonCakeProduct.value.productColor,
                  context,
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  model.currentImage.value,
                  fit: BoxFit.contain,
                ),
              ),
            );
          }),
        ),
        Positioned(
          top: 12,
          left: 12,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white.withOpacity(0.9),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF8E25).withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            width: 45,
            height: 45,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: Color(0xFFFF8E25),
              ),
              onPressed: () => Get.nestedKey(1)?.currentState?.pop(),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildListImage(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: (model.moonCakeProduct.value.productImages ?? []).length,
        itemBuilder: (c, i) {
          return GestureDetector(
            onTap: () => model.onTapViewImage(
                (model.moonCakeProduct.value.productImages ?? [])[i]),
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 3,
                  color: model.getBackgroundColor(
                    model.moonCakeProduct.value.productColor,
                    context,
                  ),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  (model.moonCakeProduct.value.productImages ?? [])[i] ?? '',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          );
        },
        separatorBuilder: (c, i) => const SizedBox(width: 10),
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 50,
                width: width * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF8E25), Color(0xFFFFB067)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF8E25).withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Mua ngay",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                width: width * 0.45,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border:
                      Border.all(color: const Color(0xFFFF8E25), width: 1.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () => model.onDecreaseQuantity(),
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: const Color(0xFFFF8E25).withOpacity(0.8),
                        size: 20,
                      ),
                    ),
                    Obx(() => Text(
                          "${model.quantity.value}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFFF8E25).withOpacity(0.8),
                          ),
                        )),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF8E25), Color(0xFFFFB067)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => model.onIncreaseQuantity(),
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF8E25), Color(0xFFFFB067)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
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
