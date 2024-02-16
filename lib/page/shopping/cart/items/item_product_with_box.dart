import 'package:flutter/material.dart';
import 'package:loto/common/utils.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product.dart';
import 'package:loto/page/shopping/moon_cake/models/order_moon_cake.dart';
import 'package:loto/src/style_resource.dart';

class ItemProductWithBox extends StatelessWidget {
  final ProductOrder productItem;
  const ItemProductWithBox({
    super.key,
    required this.productItem,
  });

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
              fontSize: 22,
            ),
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: SizedBox(
                width: 120,
                height: 120,
                child: Image.network(
                  productItem.boxCake!.productImage ?? '',
                  fit: BoxFit.cover,
                ),
              ),
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
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: productItem.productMoonCakeList!.map((e) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: Text(
                            "${e.quantity ?? ''} x ${e.productName ?? ''} (${e.productType}g)",
                            style: TextStyleResource.textStyleBlack(context),
                          ),
                        );
                      }).toList())
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: List.generate(
              productItem.productMoonCakeList!.length,
              (index) => Container(
                    width: 70,
                    height: 70,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: EdgeInsets.only(right: 10),
                    child: Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/moon_cake.png?alt=media&token=48655c5c-b0c8-4291-b775-ec70c0011df5",
                    ),
                  )),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerRight,
          child: Text(
            "Tổng: $countPrice",
            style: TextStyleResource.textStyleBlack(context),
          ),
        )
      ],
    );
  }

  String get countPrice {
    double total = 0.0;
    total = total + (productItem.boxCake!.productPrice ?? 0).toDouble();
    for (CakeProduct element in (productItem.productMoonCakeList ?? [])) {
      total = total + (element.productPrice ?? 0).toDouble();
    }
    return "${FormatUtils.oCcy.format(total)}đ";
  }
}
