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

    final double paddingItem = width * 0.055;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingItem),
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
              Container(
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
              )
            ],
          ),
          SizedBox(
            height: paddingItem,
          ),
          // SizedBox(
          //   height: (((width - (paddingItem * 2) + 50) / 6) * 1.1) < 120 ? 120 : (((width - (paddingItem * 2) + 50) / 6) * 1.1),
          //   child: ListView.separated(
          //     itemCount: model.listCategory.length,
          //     scrollDirection: Axis.horizontal,
          //     itemBuilder: (c, i) {
          //       final widthItem = (width - ((paddingItem * 2) + 50)) / 6;
          //       return Container(
          //         width: widthItem < 100 ? 100 : widthItem,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(15),
          //           gradient: LinearGradient(
          //             colors: [
          //               Color(
          //                 int.parse(
          //                     "0x00${model.listCategory[i].categoryColor}"),
          //               ),
          //               Color(
          //                 int.parse(
          //                     "0xFF${model.listCategory[i].categoryColor}"),
          //               ).withOpacity(0.1),
          //             ],
          //             begin: Alignment.topCenter,
          //             end: Alignment.bottomCenter,
          //             stops: [0, 1],
          //           ),
          //         ),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           children: [
          //             Padding(
          //               padding: const EdgeInsets.only(left: 20),
          //               child: Image.asset(
          //                 model.listCategory[i].categoryIcon ?? '',
          //                 height: ((width - (paddingItem * 2) + 50) / 6) * 0.67,
          //                 fit: BoxFit.fitWidth,
          //               ),
          //             ),
          //             const SizedBox(
          //               height: 30,
          //             ),
          //             Text(
          //               "${model.listCategory[i].categoryName}",
          //               style: const TextStyle(
          //                 fontWeight: FontWeight.w800,
          //                 fontSize: 13,
          //               ),
          //             )
          //           ],
          //         ),
          //       );
          //     },
          //     separatorBuilder: (c, i) {
          //       return const SizedBox(
          //         width: 10,
          //       );
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}
