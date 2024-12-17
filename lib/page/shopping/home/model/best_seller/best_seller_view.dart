import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/home/model/best_seller/best_seller_model.dart';
import 'package:loto/page/shopping/shop_product/items/product_view_item.dart';

class TastyRecipeView extends StatelessWidget {
  final TastyRecipeModel model;
  const TastyRecipeView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return buildSimpleAndTasty();
  }

  Widget buildSimpleAndTasty() {
    return Column(
      children: [
        const SizedBox(height: 67),
        const Text(
          "Best seller",
          style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w600,
              color: Color(0xFFF4952C)),
        ),
        const Text(
          "Best Seller this week!",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 63,
        ),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 69),
            child: Obx(() {
              if (model.listCakeFeature.isEmpty) {
                return const SizedBox();
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: model.listCakeFeature.map((e) {
                  return ClipRRect(
                    child: SizedBox(
                      width: 303,
                      height: 307,
                      child: ProductViewItem(
                        cakeProductModel: e,
                        onAddToCart: () {
                          e.cakeProduct.productPrice = e.productPrice.value;
                          model.listClick(e.cakeProduct);
                        },
                        onTapItem: () {
                          model.onTapDetail(e.cakeProduct);
                        },
                      ),
                    ),
                  );
                }).toList(),
              );
            }))
      ],
    );
  }
}
