import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/shop_product/items/product_view_item.dart';
import 'package:loto/page/shopping/shop_product/model/top_product_model.dart';

class TopProductView extends StatelessWidget {
  final SearchArticleModel model;
  const TopProductView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return buildCategory();
  }

  Widget buildCategory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64).copyWith(top: 80),
      child: _buildMain(),
    );
  }

  Widget _buildMain() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCategories(),
        const SizedBox(width: 72),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Featured products",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      height: 2,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF8E25),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: const Text(
                      "Lọc theo:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 18),
              _buildListProduct(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildListProduct() {
    return SizedBox(
      height: (307 * 3) + 165,
      child: Obx(() {
        if (model.listCake.isEmpty) {
          return _emptyProduct();
        }
        return GridView.builder(
          itemCount: model.listCake.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 55,
            mainAxisSpacing: 60,
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

  Widget _emptyProduct(){
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Fshops%2Fbaker.png?alt=media&token=813947d9-ba2e-465c-8498-e973f5972a8f",
            width: 300,
            height: 300,
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

  Widget _buildCategories() {
    return SizedBox(
      width: 212,
      child: Column(
        children: [
          const SizedBox(height: 80),
          const Text(
            "Danh mục",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              height: 2,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Obx(() {
            if (model.listCategories.isEmpty) {
              return const SizedBox();
            }
            return ListView.separated(
              itemCount: model.listCategories.length,
              itemBuilder: (c, i) {
                return GestureDetector(
                  onTap: () {
                    model.onSelectCategory(i);
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: 48,
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          child: Obx(() {
                            return Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: const Color(0xFFCACACA),
                              ),
                              child: Visibility(
                                visible:
                                    model.listCategories[i].isSelected.value,
                                child: const Icon(
                                  Icons.circle,
                                  color: Color(0xFFFF8E25),
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          model.listCategories[i].categoryName ?? '',
                          style: const TextStyle(height: 1),
                        )
                      ],
                    ),
                  ),
                );
              },
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (c, i) {
                return const SizedBox(height: 10);
              },
            );
          })
        ],
      ),
    );
  }
}
