import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/moon_cake/controller/moon_cake_controller.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product.dart';
import 'package:loto/page/shopping/shop_product/model/top_product_model.dart';
import 'package:loto/src/style_resource.dart';

class SelectBoxLayout extends StatelessWidget {
  final TopProductModel controller;
  const SelectBoxLayout({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          constraints: BoxConstraints(
            maxWidth: 1000,
            maxHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              _buildBoxList(width),
              _buildCloseButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFEEEEEE)),
        ),
      ),
      child: const Text(
        "Chọn hộp bánh",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFF333333),
        ),
      ),
    );
  }

  Widget _buildBoxList(double width) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: controller.streamGetListBox(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingGrid(width);
          }
          if (snapshot.hasData) {
            return _buildBoxGrid(context, snapshot, width);
          }
          return _buildLoadingGrid(width);
        },
      ),
    );
  }

  Widget _buildLoadingGrid(double width) {
    final int crossAxisCount = width > 1000 ? 3 : (width > 600 ? 2 : 1);
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 16 / 9,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (c, i) => Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildBoxGrid(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot, double width) {
    final int crossAxisCount = width > 1000 ? 3 : (width > 600 ? 2 : 1);
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: snapshot.data!.docs.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 16 / 9,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (c, i) {
        final product = CakeProduct.fromJson(
          snapshot.data!.docs[i].data() as Map<String, dynamic>,
        );
        return _buildBoxItem(context, product);
      },
    );
  }

  Widget _buildBoxItem(BuildContext context, CakeProduct product) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => controller.onSelectBuyBox(product),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFEEEEEE)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                product.productImageMain,
                fit: BoxFit.cover,
              ),
              _buildBoxInfo(context, product),
              _buildBoxType(context, product),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBoxInfo(BuildContext context, CakeProduct product) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.7),
            ],
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                product.productName ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              controller.formatCurrency(product.productPrice ?? 0),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBoxType(BuildContext context, CakeProduct product) {
    return Positioned(
      top: 12,
      right: 12,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: SizedBox(
          width: 56,  // Fixed width for 2 items
          height: 56, // Fixed height for 2 items
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
              product.productType ?? 2,
              (i) => Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFF8E25),
                  borderRadius: BorderRadius.circular(4),
                ),
                alignment: Alignment.center,
                child: Text(
                  "${i + 1}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCloseButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Get.back(),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Color(0xFFEEEEEE)),
            ),
          ),
          child: const Text(
            "Đóng",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFFFF8E25),
            ),
          ),
        ),
      ),
    );
  }
}
