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
                        return _loadingBoxWidget();
                      }
                      if (snapshot.hasData) {
                        return _loadingMainWidget(context, snapshot);
                      } else {
                        return _loadingBoxWidget();
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

  Widget _loadingBoxWidget() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  color: Colors.grey,
                  margin: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loadingMainWidget(BuildContext context, snapshot) {
    return Expanded(
      child: ListView.separated(
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
                          product.productImage ?? '',
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
        separatorBuilder: (c, index) => Container(
          height: 15,
        ),
        itemCount: snapshot.data!.docs.length,
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
