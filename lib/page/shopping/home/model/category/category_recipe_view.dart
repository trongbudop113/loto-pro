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
        _buildHeader(),
        const SizedBox(height: 40),
        Obx(() {
          if (model.listCategory.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFF4952C),
              ),
            );
          }
          return _buildCategoryGrid();
        })
      ],
    );
  }

  Widget _buildHeader() {
    return const Column(
      children: [
        Text(
          "Danh Mục",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: Color(0xFFF4952C),
            height: 1.2,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Shop By Category",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryGrid() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1400),
      height: 600,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      _buildCategoryCard(
                        flex: 3,
                        image: "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Fcategories%2Fcategories1.webp?alt=media&token=552601d5-12c6-44b4-a8d3-dda60d13bfd8",
                        category: model.listCategory[1],
                      ),
                      const SizedBox(width: 20),
                      _buildImageCard(
                        flex: 2,
                        image: "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Fcategories%2Fcategories2.webp?alt=media&token=552601d5-12c6-44b4-a8d3-dda60d13bfd8",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Row(
                    children: [
                      _buildImageCard(
                        flex: 2,
                        image: "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Fcategories%2Fcategories4.webp?alt=media&token=552601d5-12c6-44b4-a8d3-dda60d13bfd8",
                      ),
                      const SizedBox(width: 20),
                      _buildCategoryCard(
                        flex: 3,
                        image: "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Fcategories%2Fcategories5.webp?alt=media&token=552601d5-12c6-44b4-a8d3-dda60d13bfd8",
                        category: model.listCategory[1],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          _buildCategoryCard(
            flex: 1,
            image: "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Fcategories%2Fcategories3.webp?alt=media&token=552601d5-12c6-44b4-a8d3-dda60d13bfd8",
            category: model.listCategory[3],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard({
    required int flex,
    required String image,
    required dynamic category,
  }) {
    return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                image,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.4),
                      Colors.black.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 25,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Text(
                      category.categoryName ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildBuyButton(category),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageCard({
    required int flex,
    required String image,
  }) {
    return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildBuyButton(dynamic category) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => model.onTapCategory(category),
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: 120,
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color(0xFFFF7600),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              "Mua ngay",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
