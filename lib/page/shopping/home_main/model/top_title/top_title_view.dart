import 'package:flutter/material.dart';
import 'package:loto/page/shopping/home_main/model/top_title/top_title_model.dart';

class TopTitleView extends StatelessWidget{
  final TopTitleModel model;
  const TopTitleView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final double textSize1 = width > 900 ? 38 : 28;
    final double textSize2 = width > 900 ? 40 : 28;
    return Column(
      children: [
        SizedBox(height: width > 900 ? 68 : 40),
        Text(
          model.title1 ?? '',
          style: TextStyle(
              fontSize: textSize1,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFF4952C)
          ),
        ),
        const SizedBox(height: 5),
        Text(
          model.title2 ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: textSize2,
              fontWeight: FontWeight.w600,
              color: Colors.black
          ),
        ),
      ],
    );
  }

}