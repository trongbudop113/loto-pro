import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/moon_cake/controller/moon_cake_controller.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product.dart';
import 'package:loto/src/style_resource.dart';

class SelectBoxLayout extends StatelessWidget {
  final MoonCakeController controller;
  const SelectBoxLayout({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 40,
                  child: Text(
                    "Chọn Hộp",
                    style: TextStyleResource.textStyleBlack(context).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: controller.streamGetListBox(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return _loadingBoxWidget(width: width);
                      }
                      if (snapshot.hasData) {
                        return _loadingMainWidget(context, snapshot, width : width);
                      } else {
                        return _loadingBoxWidget(width: width);
                      }
                    }),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(12),
                      ),
                    ),
                    height: 48,
                    alignment: Alignment.center,
                    child: Text("Đóng"),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _loadingBoxWidget({required double width}) {
    final int crossAxisCount = width > 1000 ? 3 : (width > 600 ? 2 : 1);
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemBuilder: (c, index) {
          return AspectRatio(
            aspectRatio: 16/ 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.grey,
                alignment: Alignment.center,
              ),
            ),
          );
        },
        itemCount: 12,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 16 / 9,
          mainAxisSpacing: 10, crossAxisSpacing: 10,
        ),
      ),
    );
  }

  Widget _loadingMainWidget(BuildContext context, snapshot, {required double width}) {
    final int crossAxisCount = width > 1000 ? 3 : (width > 600 ? 2 : 1);
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemBuilder: (c, index) {
          CakeProduct product = CakeProduct.fromJson(
              snapshot.data!.docs[index].data() as Map<String, dynamic>);
          return GestureDetector(
            onTap: () {
              controller.onSelectBuyBox(product);
            },
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.network(
                          product.productImageMain,
                          fit: BoxFit.cover,
                          width: Get.width,
                        ),
                      ),
                    ),
                    _buildNumberCake(context, product),
                    _buildTitle(context, product)
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: snapshot.data!.docs.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 16 / 9,
          mainAxisSpacing: 10, crossAxisSpacing: 10,
        ),
      ),
    );
  }

  Positioned _buildTitle(BuildContext context, CakeProduct product) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 45,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.black54,
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                product.productName ?? '',
              ),
            ),
            Text(
              controller.formatCurrency(
                product.productPrice ?? 0,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
      ),
    );
  }

  Positioned _buildNumberCake(BuildContext context, CakeProduct product) {
    return Positioned(
      top: 10,
      right: 10,
      child: Container(
        width: 60,
        height: 60,
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(product.productType ?? 2, (e) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(3),
              ),
              alignment: Alignment.center,
              child: Text(
                "${e + 1}",
                style: TextStyleResource.textStyleBlack(context),
              ),
            );
          }),
        ),
      ),
    );
  }
}
