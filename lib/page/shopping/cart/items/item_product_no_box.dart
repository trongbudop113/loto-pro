import 'package:flutter/material.dart';
import 'package:loto/common/utils.dart';
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
        SizedBox(
          height: 15,
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            productItem.boxCake!.productName ?? '',
            style: TextStyleResource.textStyleBlack(context).copyWith(
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: ColorResource.color_main_dark,
              ),
              padding: EdgeInsets.all(5),
              child: Image.network(
                "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/moon_cake.png?alt=media&token=48655c5c-b0c8-4291-b775-ec70c0011df5",
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Loại:",
                    style: TextStyleResource.textStyleBlack(context),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${productItem.boxCake!.numberEggs} Trứng - ${productItem.boxCake!.productType}g",
                    style: TextStyleResource.textStyleBlack(context),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerRight,
          child: Text(
            "Tổng: $countPrice",
            style: TextStyleResource.textStyleBlack(context),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  String get countPrice {
    double total = 0.0;
    total = (productItem.boxCake!.productPrice ?? 0).toDouble();
    return "${FormatUtils.oCcy.format(total)}đ";
  }
}
