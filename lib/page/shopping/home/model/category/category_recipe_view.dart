import 'package:get/get.dart';
import 'package:loto/page/shopping/home/model/category/category_recipe_model.dart';
import 'package:flutter/material.dart';

class CategoryRecipeView extends StatelessWidget {
  final CategoryRecipeModel model;
  const CategoryRecipeView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return buildCategory();
  }

  Widget buildCategory() {
    return Column(
      children: [
        const Text(
          "Danh Mục",
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w600,
            color: Color(0xFFF4952C),
          ),
        ),
        const Text(
          "Shop By Category",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 55,
        ),
        Obx(() {
          if (model.listCategory.isEmpty) {
            return const SizedBox();
          }
          return Container(
            height: 607,
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: Row(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                width: 477,
                                child: Image.network(
                                    "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Fcategories%2Fcategories1.webp?alt=media&token=552601d5-12c6-44b4-a8d3-dda60d13bfd8"),
                              ),
                              Positioned.fill(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 25),
                                    Text(
                                      model.listCategory[1].categoryName ?? '',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        model.onTapCategory(
                                            model.listCategory[1]);
                                      },
                                      child: Container(
                                        width: 134,
                                        height: 40,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: const Color(0xFFFF7600),
                                        ),
                                        child: const Text(
                                          "Mua ngay",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(width: 46),
                          SizedBox(
                            width: 337,
                            child: Image.network(
                              "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Fcategories%2Fcategories2.webp?alt=media&token=552601d5-12c6-44b4-a8d3-dda60d13bfd8",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 31),
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 337,
                            child: Image.network(
                                "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Fcategories%2Fcategories4.webp?alt=media&token=552601d5-12c6-44b4-a8d3-dda60d13bfd8"),
                          ),
                          const SizedBox(width: 46),
                          Stack(
                            children: [
                              SizedBox(
                                width: 477,
                                child: Image.network(
                                    "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Fcategories%2Fcategories5.webp?alt=media&token=552601d5-12c6-44b4-a8d3-dda60d13bfd8"),
                              ),
                              Positioned.fill(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 25),
                                    Text(
                                      model.listCategory[1].categoryName ?? '',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        model.onTapCategory(
                                            model.listCategory[1]);
                                      },
                                      child: Container(
                                        width: 134,
                                        height: 40,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: const Color(0xFFFF7600),
                                        ),
                                        child: const Text(
                                          "Mua ngay",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const Spacer(flex: 1),
                Stack(
                  children: [
                    SizedBox(
                      width: 331,
                      child: Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Fcategories%2Fcategories3.webp?alt=media&token=552601d5-12c6-44b4-a8d3-dda60d13bfd8"),
                    ),
                    Positioned.fill(
                      child: Column(
                        children: [
                          const SizedBox(height: 25),
                          Text(
                            model.listCategory[3].categoryName ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              model.onTapCategory(model.listCategory[3]);
                            },
                            child: Container(
                              width: 134,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color(0xFFFF7600),
                              ),
                              child: const Text(
                                "Mua ngay",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        })
      ],
    );
  }
}
