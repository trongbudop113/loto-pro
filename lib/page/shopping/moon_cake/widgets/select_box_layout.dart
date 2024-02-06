import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
              margin: EdgeInsets.symmetric(horizontal: 50),
              height: MediaQuery.of(context).size.height * 0.75,
              color: Colors.white,
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Text(
                      "Chọn Hộp",
                      style: TextStyleResource.textStyleBlack(context),
                    ),
                    height: 40,
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: controller.streamGetListBox(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Expanded(
                            child: ListView.separated(
                              padding: EdgeInsets.all(10),
                              itemBuilder: (c, index) {
                                CakeProduct product = CakeProduct.fromJson(
                                    snapshot.data!.docs[index].data()
                                        as Map<String, dynamic>);
                                return GestureDetector(
                                  onTap: () {
                                    controller.onSelectBuyBox(product);
                                  },
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        child: Image.network(
                                          product.productImage ?? '',
                                          fit: BoxFit.cover,
                                        ),
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
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                  Container(
                    color: Colors.amber,
                    height: 48,
                    alignment: Alignment.center,
                    child: Text("Đóng"),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
