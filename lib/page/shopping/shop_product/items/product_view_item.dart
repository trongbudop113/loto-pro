import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product_model.dart';
import 'package:loto/src/image_resource.dart';
import 'package:loto/src/style_resource.dart';

class ProductViewItem extends StatelessWidget {
  final CakeProductModel cakeProductModel;
  final VoidCallback onAddToCart;
  final VoidCallback onTapItem;
  const ProductViewItem({
    super.key,
    required this.cakeProductModel,
    required this.onAddToCart,
    required this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: cakeProductModel.getBackgroundColor,
              alignment: Alignment.center,
              child: Image.network(
                cakeProductModel.cakeProduct.productImageMain,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                _buildItemEegYolk(context),
                const SizedBox(height: 5),
                _buildNameAndAddCart(),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: _buildWeightProduct(context),
          ),
        ],
      ),
    );
  }

  Widget _buildItemEegYolk(BuildContext context){
    if(cakeProductModel.cakeProduct.productCategory != 4){
      return const SizedBox();
    }
    return Row(
      children: [
        const SizedBox(width: 10),
        const Text(
          "TM:",
          style: TextStyle(
              color: Colors.white,
              fontSize: 15,
          ),
        ),
        const SizedBox(width: 5),
        Container(
          width: cakeProductModel.listEgg.length * 50,
          height: 32,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: Colors.black54,
          ),
          child: Row(
            children: cakeProductModel.listEgg.map((e) {
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    cakeProductModel.selectEgg(e);
                  },
                  child: Obx(() => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: e.isSelect.value
                          ? Colors.white54
                          : Colors.transparent,
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${e.value}",
                          style: TextStyleResource.textStyleBlack(context)
                              .copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFF8E25).withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Image.asset(
                          ImageResource.ic_egg_yolk,
                          height: 15,
                        )
                      ],
                    ),
                  )),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildNameAndAddCart(){
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFF8E25),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 15,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cakeProductModel.cakeProduct.productName ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 7),
                Obx((){
                  return Text(
                    'Giá: ${cakeProductModel.formatCurrency.value}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onAddToCart,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(360),
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.add,
                color: Color(0xFFFF8E25),
                size: 18,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWeightProduct(BuildContext context) {
    if(cakeProductModel.cakeProduct.productCategory != 4){
      return const SizedBox();
    }
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: 47,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            color: Colors.grey,
          ),
          alignment: Alignment.center,
          child: Text(
            "${cakeProductModel.cakeProduct.productType}g",
            textAlign: TextAlign.center,
            style: TextStyleResource.textStyleWhite(context).copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
