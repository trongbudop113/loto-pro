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
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error_outline, size: 40);
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
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

  Widget _buildNameAndAddCart() {
    return Container(
      height: 85, // Added fixed height
      decoration: const BoxDecoration(
        color: Color(0xFFFF8E25),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 15,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Added to center content vertically
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40, // Fixed height for product name
                  child: Text(
                    cakeProductModel.cakeProduct.productName ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      height: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Obx(() {
                  return Text(
                    'Giá: ${cakeProductModel.formatCurrency.value}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onAddToCart,
            child: Container(
              width: 36, // Slightly smaller
              height: 36, // Slightly smaller
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.white,
                boxShadow: [ // Added subtle shadow
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
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

  Widget _buildItemEegYolk(BuildContext context) {
    if (cakeProductModel.cakeProduct.productCategory != 4) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          const Text(
            "TM:",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          Container(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black54,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: cakeProductModel.listEgg.map((e) {
                return GestureDetector(
                  onTap: () => cakeProductModel.selectEgg(e),
                  child: Obx(() => Container(
                    width: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: e.isSelect.value
                          ? Colors.white.withOpacity(0.3)
                          : Colors.transparent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${e.value}",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFF8E25).withOpacity(0.9),
                          ),
                        ),
                        Image.asset(
                          ImageResource.ic_egg_yolk,
                          height: 14,
                        )
                      ],
                    ),
                  )),
                );
              }).toList(),
            ),
          ),
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
