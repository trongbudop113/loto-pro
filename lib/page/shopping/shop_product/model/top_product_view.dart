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

  Widget _topTitle(){
    return Row(
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
    );
  }

  Widget _buyWithBox(BuildContext context){
    return Obx((){
      if(model.isShowBuyBox.value && !model.isStatusBuyBox.value){
        return GestureDetector(
          onTap: (){
            model.onShowOrCompleteBuyBox(context);
          },
          child: Container(
            alignment: Alignment.center,
            color: Colors.black38,
            height: 80,
            margin: const EdgeInsets.only(bottom: 15),
            child: const Text("Mua theo hôp"),
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
