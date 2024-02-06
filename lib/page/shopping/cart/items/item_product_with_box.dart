import 'package:flutter/material.dart';
import 'package:loto/page/shopping/moon_cake/models/order_moon_cake.dart';
import 'package:loto/src/color_resource.dart';
import 'package:loto/src/style_resource.dart';

class ItemProductWithBox extends StatelessWidget {
  final ProductOrder productItem;
  const ItemProductWithBox({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            productItem.boxCake!.productName ?? '',
            style: TextStyleResource.textStyleBlack(context),
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Container(
              width: 120,
              height: 120,
              color: ColorResource.color_main_dark,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Gồm:",
                    style: TextStyleResource.textStyleBlack(context),
                  ),
                  SizedBox(height: 10),
                  Text("Bánh Thập Cẩm",
                      style: TextStyleResource.textStyleBlack(context)),
                  Text("Bánh Hạt Sen",
                      style: TextStyleResource.textStyleBlack(context)),
                  Text("Bánh Đậu Xanh",
                      style: TextStyleResource.textStyleBlack(context)),
                  Text("Bánh Đâu Đỏ",
                      style: TextStyleResource.textStyleBlack(context)),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: List.generate(
              4,
              (index) => Container(
                    width: 70,
                    height: 70,
                    color: ColorResource.color_background_dark,
                    margin: EdgeInsets.only(right: 10),
                  )),
        )
      ],
    );
  }
}
