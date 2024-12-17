import 'package:flutter/material.dart';
import 'package:loto/page/shopping/home/model/banner/banner_model.dart';

class BannerView extends StatelessWidget {
  final BannerModel model;
  const BannerView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 64),
      child: AspectRatio(
        aspectRatio: 1312/834,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/banner%2Fbg_home.webp?alt=media&token=2544d538-71f5-4194-bb81-38fe0e5692ba"
          ),
        ),
      ),
    );
  }
}
