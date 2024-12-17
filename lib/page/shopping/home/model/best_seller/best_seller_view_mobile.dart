
import 'package:loto/page/shopping/home/model/best_seller/best_seller_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BestSellerViewMobile extends StatelessWidget {
  final TastyRecipeModel model;
  const BestSellerViewMobile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    //print(width);
    return buildSimpleAndTasty(width);
  }

  Widget buildSimpleAndTasty(double width) {

    const double paddingItem = 15;
    final itemCount = width < 750 ? 2 : 3;

    return Column(
      children: [
        const SizedBox(height: 30),
        const Text(
          "Bán chạy",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Color(0xFFF4952C)
          ),
        ),
        const Text(
          "Sản phẩm bán chạy trong tháng",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
