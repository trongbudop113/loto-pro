import 'package:get/get.dart';
import 'package:loto/page/shopping/shop_product/items/product_view_item.dart';
import 'package:loto/page/shopping/shop_product/model/top_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TopProductViewMobile extends StatelessWidget {
  final SearchArticleModel model;
  const TopProductViewMobile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return buildCategory(width);
  }

  Widget buildCategory(double width) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(
        top: 20,
      ),
      child: Column(
        children: [
          _buildCategories(),
          _buildListProduct(width),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Danh mục",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 2,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          child: Obx(() {
            if (model.listCategories.isEmpty) {
              return const SizedBox(
                height: 50,
              );
            }
            return Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              runSpacing: 15,
              spacing: 20,
              children: model.listCategories.asMap().entries.map((e) {
                return GestureDetector(
                  onTap: () {
                    model.onSelectCategory(e.key);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xFFFF8E25).withOpacity(0.3),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(() {
                          return Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: const Color(0xFFCACACA),
                            ),
                            child: Visibility(
                              visible: e.value.isSelected.value,
                              child: const Icon(
                                Icons.circle,
                                color: Color(0xFFFF8E25),
                                size: 20,
                              ),
                            ),
                          );
                        }),
                        const SizedBox(width: 6),
                        Text(
                          e.value.categoryName ?? '',
                          style: const TextStyle(height: 1),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: model.listCategories.length,
              itemBuilder: (c, i) {
                return;
              },
              separatorBuilder: (c, i) {
                return const SizedBox(width: 25);
              },
            );
          }),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _buildListProduct(double width) {
    final itemCount = width <= 600 ? 2 : 3;
    return SizedBox(
      height: (307 * 3),
      child: Obx(() {
        if (model.listCake.isEmpty) {
          return _emptyProduct();
        }
        return GridView.builder(
          itemCount: model.listCake.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: itemCount,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 303 / 307,
          ),
          itemBuilder: (BuildContext context, int index) {
            return ProductViewItem(
              cakeProductModel: model.listCake[index],
              onAddToCart: () {
                model.listCake[index].cakeProduct.productPrice =
                    model.listCake[index].productPrice.value;
                model.listClick(model.listCake[index].cakeProduct);
              },
              onTapItem: () {
                model.onTapDetail(model.listCake[index].cakeProduct);
              },
            );
          },
        );
      }),
    );
  }

  Widget _emptyProduct() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Fshops%2Fbaker.png?alt=media&token=813947d9-ba2e-465c-8498-e973f5972a8f",
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 20),
          const Text(
            "Sản phẩm đang được cập nhật nha",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          )
        ],
      ),
    );
  }
}
