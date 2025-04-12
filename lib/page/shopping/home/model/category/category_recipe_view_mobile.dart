import 'package:get/get.dart';
import 'package:loto/page/shopping/home/model/category/category_recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:loto/page/shopping/shop_product/model_data/top_categories_res.dart';

class CategoryRecipeViewMobile extends StatelessWidget {
  final CategoryRecipeModel model;
  const CategoryRecipeViewMobile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return buildCategory(width);
  }

  Widget buildCategory(double width) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Danh mục",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF333333),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => model.onTapViewAll(),
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF8E25), Color(0xFFFFB067)],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF8E25).withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Xem tất cả",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 12,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
         _buildListCategories(width),
        ],
      ),
    );
  }

  Widget _buildListCategories(double width){
    return SizedBox(
      height: ((width - 40) / 4) * 1.3,
      child: Obx(() {
        if (model.listCategory.isEmpty) {
          return const SizedBox();
        }
        return ListView.separated(
          itemCount: model.listCategory.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (c, i) {
            return _buildItemCategories(width, model.listCategory[i]);
          },
          separatorBuilder: (c, i) => const SizedBox(width: 15),
        );
      }),
    );
  }

  Widget _buildItemCategories(double width, LsCategory item) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => model.onTapCategory(item),
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: (width - 40) / 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFF8E25),
                  Color(0xFFFFB067),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF8E25).withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if ((item.categoryImage ?? '').isNotEmpty) ...[
                  Container(
                    width: 70,
                    height: 70,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                    ),
                    child: Image.network(
                      item.categoryImage ?? '',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "${item.categoryName}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Colors.white,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
}
