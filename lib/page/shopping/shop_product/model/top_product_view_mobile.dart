import 'package:loto/page/shopping/shop_product/model/top_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TopProductViewMobile extends StatelessWidget {
  final SearchArticleModel model;
  const TopProductViewMobile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return buildCategory(width);
  }

  Widget buildCategory(double width) {


    final double paddingItem = width * 0.055;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingItem).copyWith(
        top: 20,
      ),
      child: Column(
        children: [
          const Text(
            "Blog & Article",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
