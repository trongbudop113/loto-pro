
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/home/model/best_seller/best_seller_model.dart';
import 'package:loto/page/shopping/shop_product/items/product_view_item.dart';

class BestSellerViewMobile extends StatelessWidget {
  final TastyRecipeModel model;
  const BestSellerViewMobile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    //print(width);
    return buildSimpleAndTasty(width);
  }

  Widget buildSimpleAndTasty(double width) {

    const double paddingItem = 15;
    final itemCount = width < 600 ? 2 : 3;

    return Column(
      children: [
        const SizedBox(height: 30),
        const Text(
          "Bán chạy",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Color(0xFFF4952C)
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Sản phẩm bán chạy trong tháng",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Obx(() {
              if (model.listCakeFeature.isEmpty) {
                return const SizedBox();
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: itemCount,
                  childAspectRatio: 303 / 307,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (_, index){
                  var e = model.listCakeFeature[index];
                  return ClipRRect(
                    child: SizedBox(
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
                },
                itemCount: model.listCakeFeature.length,
              );
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: model.listCakeFeature.map((e) {
                  return ClipRRect(
                    child: SizedBox(
                      width: (Get.width - 30 - 20) / 3,
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
