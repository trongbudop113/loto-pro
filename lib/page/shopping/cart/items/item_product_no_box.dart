import 'package:flutter/material.dart';
import 'package:loto/page/shopping/moon_cake/models/order_moon_cake.dart';
import 'package:loto/src/color_resource.dart';
import 'package:loto/src/style_resource.dart';

class ItemProductNoBox extends StatelessWidget {
  final ProductOrder productItem;
  const ItemProductNoBox({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text(
            productItem.productMoonCakeList![0].productName ?? '',
            style: TextStyleResource.textStyleBlack(context),
          ),
          alignment: Alignment.centerLeft,
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Container(
              width: 120,
              height: 120,
              color: ColorResource.color_main_dark,
              child: Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/moon_cake.png?alt=media&token=48655c5c-b0c8-4291-b775-ec70c0011df5"),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "Bánh Thập Cẩm",
                style: TextStyleResource.textStyleBlack(context),
              ),
            )
          ],
        ),
      ],
    );
  }
}
