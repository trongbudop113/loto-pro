import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/utils.dart';
import 'package:loto/page/shopping/cart/items/item_product_no_box.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product.dart';
import 'package:loto/page/shopping/moon_cake/models/order_moon_cake.dart';
import 'package:loto/src/color_resource.dart';
import 'package:loto/src/style_resource.dart';

class ItemProductWithBox extends StatelessWidget {
  final ProductOrder productItem;
  final ItemMode itemModel;

  const ItemProductWithBox({
    super.key,
    required this.productItem,
    this.itemModel = ItemMode.cart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF8E25), Color(0xFFFFB067)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF8E25).withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(1),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            _buildProductContent(context),
            if (itemModel == ItemMode.cart)
              _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProductContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildMainImage(context),
              const SizedBox(width: 16),
              _buildProductList(context),
            ],
          ),
          const SizedBox(height: 16),
          _buildMiniImages(context),
          const SizedBox(height: 16),
          _buildPrice(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            productItem.boxCake?.productName ?? '',
            style: TextStyleResource.textStyleBlack(context).copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFFF8E25),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Obx(() => Text(
            "x${productItem.quantity.value}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          )),
        ),
      ],
    );
  }

  Widget _buildMainImage(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF8E25).withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            colors: [
              const Color(0xFFFF8E25).withOpacity(0.5),
              const Color(0xFFFFB067).withOpacity(0.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            productItem.boxCake?.productImages?.first ?? '',
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                      : null,
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFF8E25)),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: Color(0xFFFF8E25),
                  size: 32,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProductList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gồm:",
          style: TextStyleResource.textStyleBlack(context).copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        ...productItem.productMoonCakeList!.map((e) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            "${e.quantity ?? ''} x ${e.productName ?? ''} (${e.productType}g)",
            style: TextStyleResource.textStyleBlack(context).copyWith(
              fontSize: 14,
            ),
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildMiniImages(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: productItem.productMoonCakeList!.map((cake) => Container(
          width: 70,
          height: 70,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF8E25).withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFFF8E25).withOpacity(0.5),
                  const Color(0xFFFFB067).withOpacity(0.5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                cake.productImageMain ?? '',
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF8E25)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildPrice(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: Text(
        "Tổng: $countPrice",
        style: TextStyleResource.textStyleBlack(context).copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: const Color(0xFFFF8E25),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorResource.color_main_light,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Row(
        children: [
          _buildActionButton(
            onTap: productItem.onTapRemoveProduct,
            icon: Icons.delete_outline,
            isDelete: true,
          ),
          _buildDivider(),
          _buildActionButton(
            onTap: productItem.onTapSubtract,
            icon: Icons.remove,
          ),
          _buildDivider(),
          _buildActionButton(
            onTap: productItem.onTapPlus,
            icon: Icons.add,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    Function? onTap,
    required IconData icon,
    bool isDelete = false,
  }) {
    return Expanded(
      flex: isDelete ? 1 : 2,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTap?.call(),
          child: Container(
            height: 45,
            alignment: Alignment.center,
            child: Icon(
              icon,
              color: isDelete ? Colors.red : const Color(0xFFFF8E25),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 45,
      width: 1,
      color: const Color(0xFFFF8E25).withOpacity(0.1),
    );
  }

  Color getBackgroundColor(String? color, BuildContext context) {
    if (color == null) return ColorResource.color_background_light;
    return Color(int.parse("0xFF$color"));
  }

  String get countPrice {
    double total = 0.0;
    total = total + (productItem.boxCake!.productPrice ?? 0).toDouble();
    for (CakeProduct element in (productItem.productMoonCakeList ?? [])) {
      total = total + (element.productPrice ?? 0).toDouble();
    }
    return "${FormatUtils.oCcy.format(total)}đ";
  }
}
