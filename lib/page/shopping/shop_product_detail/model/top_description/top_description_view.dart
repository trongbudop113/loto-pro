import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/shop_product_detail/model/top_description/top_description_model.dart';

class TopDescriptionView extends StatelessWidget {
  final TopDescriptionModel model;
  const TopDescriptionView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64),
      child: Obx(() {
        return Row(
          children: [
            Obx(() {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: model.getBackgroundColor(
                    model.moonCakeProduct.value.productColor,
                    context,
                  ),
                ),
                padding: const EdgeInsets.all(10),
                width: 550,
                height: 550,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    model.currentImage.value,
                    fit: BoxFit.fill,
                  ),
                ),
              );
            }),
            const SizedBox(width: 10),
            SizedBox(
              width: 102,
              height: 550,
              child: ListView.separated(
                itemCount:
                    (model.moonCakeProduct.value.productImages ?? []).length,
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
                        (model.moonCakeProduct.value.productImages ?? [])[i] ??
                            '',
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
                separatorBuilder: (c, i) {
                  return const SizedBox(height: 10);
                },
              ),
            ),
            const SizedBox(width: 54),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.moonCakeProduct.value.productName ?? '',
                    style: const TextStyle(
                      fontSize: 48,
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
                            fontSize: 40,
                          ),
                        ),
                        Text(
                          model.formatCurrency(model.productPrice.value),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF7500),
                            fontSize: 48,
                          ),
                        ),
                      ],
                    );
                  }),
                  SizedBox(
                    width: 410,
                    child: Html(
                      data:
                          model.moonCakeProduct.value.productDescription ?? '',
                      style: {
                        "p": Style(
                          fontSize: FontSize(18),
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        )
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        width: 158,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: const Color(0xFFFF7500).withOpacity(0.8),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Mua ngay",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 64),
                      Container(
                        width: 169,
                        height: 64,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          border: Border.all(color: Colors.black, width: 1.5),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 32),
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
                                  size: 20,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Obx(() {
                                return Center(
                                  child: Text(
                                      "${model.quantity.value}",
                                    style: TextStyle(
                                      fontSize: 22,
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
                            const SizedBox(width: 32),
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
                      width: 224,
                      height: 56,
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
                            style: TextStyle(color: Colors.white, fontSize: 22),
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
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
