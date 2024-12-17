import 'package:flutter/material.dart';
import 'package:loto/page/shopping/home_main/model/top_title/top_title_model.dart';

class TopTitleView extends StatelessWidget{
  final TopTitleModel model;
  const TopTitleView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 68),
        Text(
          model.title1 ?? '',
          style: const TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w600,
              color: Color(0xFFF4952C)
          ),
        ),
        Text(
          model.title2 ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w600,
              color: Colors.black
          ),
        ),
      ],
    );
  }

}