import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/shop_product/items/product_view_item.dart';
import 'package:loto/page/shopping/shop_product/model/top_product_model.dart';
import 'package:loto/src/style_resource.dart';

class TopProductView extends StatelessWidget {
  final TopProductModel model;
  const TopProductView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return buildCategory(context);
  }

  Widget buildCategory(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64).copyWith(top: 80),
      child: _buildMain(context),
    );
  }

  Widget _buildMain(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCategories(),
        const SizedBox(width: 72),
        Expanded(
          child: Column(
            children: [
              _topTitle(),
              const SizedBox(height: 18),
              _buyWithBox(context),
              const SizedBox(height: 18),
              _buildListProduct(),
            ],
          ),
        )
      ],
    );
  }

  Widget _topTitle() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Featured products",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF333333),
                  height: 1.2,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Discover our special products",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF666666),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFFF8E25),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF8E25).withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Row(
              children: [
                Text(
                  "Lọc theo:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.filter_list,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buyWithBox(BuildContext context) {
      return Obx(() {
        if (model.isShowBuyBox.value && !model.isStatusBuyBox.value) {
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => model.onShowOrCompleteBuyBox(context),
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFFF8E25).withOpacity(0.9),
                        const Color(0xFFFFB067),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF8E25).withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mua theo hộp",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Tiết kiệm hơn khi mua theo bộ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 15),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      return Obx(
            () => Visibility(
          visible: model.isStatusBuyBox.value,
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: ListView.separated(
                  itemBuilder: (c, i) {
                    if (i > model.listCakeBoxTemp.length - 1) {
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
                            color: model.getBackgroundColor(
                                model.listCakeBoxTemp[i].productColor,
                                context),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Image.network(
                            model.listCakeBoxTemp[i].productImageMain ?? '',
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
                                  "${model.listCakeBoxTemp[i].productType}g - ${model.listCakeBoxTemp[i].numberEggs}T",
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
                              model.onRemoveItemInBox(i);
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
                  itemCount: model.listCakeBoxTemp.length +
                      ((model.productOrder?.boxCake?.productType ?? 0) -
                          model.listCakeBoxTemp.length),
                  scrollDirection: Axis.horizontal,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        model.onTapDeleteBuyBox();
                      },
                      child: Container(
                        height: 45,
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
                        model.onShowOrCompleteBuyBox(context);
                      },
                      child: Container(
                        height: 45,
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
              const SizedBox(height: 15),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildListProduct() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Obx(() {
        if (model.listCake.isEmpty) {
          return _emptyProduct();
        }

        final int totalItems = model.listCake.length;
        const int itemsPerPage = 6;
        final int totalPages = (totalItems / itemsPerPage).ceil();
        final int startIndex = model.currentPage.value * itemsPerPage;
        final int endIndex = (startIndex + itemsPerPage) > totalItems 
            ? totalItems 
            : startIndex + itemsPerPage;

        return Column(
          children: [
            GridView.builder(
              itemCount: endIndex - startIndex,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
                childAspectRatio: 1,
              ),
              itemBuilder: (BuildContext context, int index) {
                final itemIndex = startIndex + index;
                return AnimatedOpacity(
                  duration: Duration(milliseconds: 300 + (index * 100)),
                  opacity: 1,
                  child: ProductViewItem(
                    cakeProductModel: model.listCake[itemIndex],
                    onAddToCart: () {
                      model.listCake[itemIndex].cakeProduct.productPrice =
                          model.listCake[itemIndex].productPrice.value;
                      model.listClick(model.listCake[itemIndex].cakeProduct);
                    },
                    onTapItem: () {
                      model.onTapDetail(model.listCake[itemIndex].cakeProduct);
                    },
                  ),
                );
              },
            ),
            if (totalPages > 1) ...[
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: model.currentPage.value > 0
                        ? () => model.currentPage.value--
                        : null,
                    icon: const Icon(Icons.arrow_back_ios),
                    color: const Color(0xFFFF8E25),
                  ),
                  const SizedBox(width: 20),
                  ...List.generate(totalPages, (index) => 
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: InkWell(
                        onTap: () => model.currentPage.value = index,
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: model.currentPage.value == index
                                ? const Color(0xFFFF8E25)
                                : Colors.transparent,
                            border: Border.all(
                              color: const Color(0xFFFF8E25),
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: model.currentPage.value == index
                                    ? Colors.white
                                    : const Color(0xFFFF8E25),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    onPressed: model.currentPage.value < totalPages - 1
                        ? () => model.currentPage.value++
                        : null,
                    icon: const Icon(Icons.arrow_forward_ios),
                    color: const Color(0xFFFF8E25),
                  ),
                ],
              ),
            ],
          ],
        );
      }),
    );
  }

  Widget _emptyProduct() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFF8E25).withOpacity(0.1),
            ),
            child: Center(
              child: Image.network(
                "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Fshops%2Fbaker.png?alt=media&token=813947d9-ba2e-465c-8498-e973f5972a8f",
                width: 180,
                height: 180,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            "Chưa có sản phẩm nào",
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Sản phẩm đang được cập nhật, vui lòng quay lại sau",
            style: TextStyle(
              color: Color(0xFF666666),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFFF8E25),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF8E25).withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.refresh_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  "Làm mới",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Danh mục",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 20),
          Obx(() {
            if (model.listCategories.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFFF8E25),
                ),
              );
            }
            return ListView.separated(
              itemCount: model.listCategories.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (c, i) => const SizedBox(height: 8),
              itemBuilder: (c, i) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => model.onSelectCategory(i),
                    borderRadius: BorderRadius.circular(10),
                    child: Obx(() => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: model.listCategories[i].isSelected.value
                            ? const Color(0xFFFF8E25).withOpacity(0.1)
                            : Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: const Color(0xFFFF8E25),
                                width: 2,
                              ),
                              color: model.listCategories[i].isSelected.value
                                  ? const Color(0xFFFF8E25)
                                  : Colors.white,
                            ),
                            child: model.listCategories[i].isSelected.value
                                ? const Icon(
                                    Icons.check,
                                    size: 14,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              model.listCategories[i].categoryName ?? '',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: model.listCategories[i].isSelected.value
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: const Color(0xFF333333),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
