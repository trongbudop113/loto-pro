import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/profile/product_manager/product_manager/product_manager_controller.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product.dart';
import 'package:loto/src/color_resource.dart';
import 'package:loto/src/style_resource.dart';

class ProductManagerPage extends GetView<ProductManagerController> {
  const ProductManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "product_management".tr,
          style: TextStyleResource.textStyleWhite(context),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => controller.onAddNewProduct(),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.streamGetProduct(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFFF8E25),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.docs.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final cake = CakeProduct.fromJson(
                snapshot.data!.docs[index].data() as Map<String, dynamic>,
              );
              return _buildProductItem(context, cake);
            },
          );
        },
      ),
    );
  }

  Widget _buildProductItem(BuildContext context, CakeProduct cake) {
    final double itemHeight = (MediaQuery.of(context).size.width * 0.3).clamp(0.0, 250.0);

    return InkWell(
      onTap: () => controller.onTapItem(cake),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: itemHeight,
        decoration: BoxDecoration(
          color: ColorResource.color_white_light,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: cake.productType == 200
            ? _buildLeftImageLayout(context, cake)
            : _buildRightImageLayout(context, cake),
      ),
    );
  }

  Widget _buildLeftImageLayout(BuildContext context, CakeProduct cake) {
    return Row(
      children: [
        _buildProductImage(context, cake),
        const SizedBox(width: 16),
        Expanded(
          child: _buildProductInfo(context, cake),
        ),
      ],
    );
  }

  Widget _buildRightImageLayout(BuildContext context, CakeProduct cake) {
    return Row(
      children: [
        Expanded(
          child: _buildProductInfo(context, cake),
        ),
        const SizedBox(width: 16),
        _buildProductImage(context, cake),
      ],
    );
  }

  Widget _buildProductImage(BuildContext context, CakeProduct cake) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: controller.getBackgroundColor(cake.productColor, context),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            cake.productImageMain,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                  color: const Color(0xFFFF8E25),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProductInfo(BuildContext context, CakeProduct cake) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            cake.productName ?? '',
            style: TextStyleResource.textStyleBlack(context).copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            "Loại: ${cake.productType ?? 0}g",
            style: TextStyleResource.textStyleGrey(context),
          ),
        ],
      ),
    );
  }
}