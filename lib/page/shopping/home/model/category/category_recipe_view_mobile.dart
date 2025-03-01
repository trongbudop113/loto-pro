import 'package:get/get.dart';
import 'package:loto/page/shopping/home/model/category/category_recipe_model.dart';
import 'package:flutter/material.dart';

class CategoryRecipeViewMobile extends StatelessWidget {
  final CategoryRecipeModel model;
  const CategoryRecipeViewMobile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return buildCategory(width);
  }

  Widget buildCategory(double width) {
    return Padding(
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
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: (){
                  model.onTapViewAll();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFF9913E),
                  ),
                  padding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                  child: const Text(
                    "Xem tất cả",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      height: 1,
                      color: Colors.white
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: ((width - 40) / 4) * 1.2,
            child: Obx((){
              if(model.listCategory.isEmpty){
                return const SizedBox();
              }
              return ListView.separated(
                itemCount: model.listCategory.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (c, i) {
                  return GestureDetector(
                    onTap: (){
                      model.onTapCategory(model.listCategory[i]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0xFFF9913E),
                      ),
                      height: (width / 4) * 1.2,
                      width: (width - 40) / 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 20),
                          //   child: Image.asset(
                          //     model.listCategory[i].categoryImage ?? '',
                          //     height: ((width - (paddingItem * 2) + 50) / 6) * 0.67,
                          //     fit: BoxFit.fitWidth,
                          //   ),
                          // ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            "${model.listCategory[i].categoryName}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (c, i) {
                  return const SizedBox(
                    width: 10,
                  );
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
