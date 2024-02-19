import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/utils.dart';
import 'package:loto/page/shopping/cart/cart_controller.dart';
import 'package:loto/page/shopping/moon_cake/models/order_moon_cake.dart';
import 'package:loto/src/color_resource.dart';
import 'package:loto/src/style_resource.dart';

class ItemProductNoBox extends StatelessWidget {
  final ProductOrder productItem;
  final CartController controller;
  const ItemProductNoBox({
    super.key,
    required this.productItem,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: ColorResource.color_main_light,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        productItem.boxCake!.productName ?? '',
                        style:
                            TextStyleResource.textStyleBlack(context).copyWith(
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Obx(() => Text(
                        "x${productItem.quantity.value}",
                        style:
                            TextStyleResource.textStyleBlack(context).copyWith(
                          fontSize: 20,
                        ),
                      )),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: controller.getBackgroundColor(
                          productItem.boxCake!.productColor, context),
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
          ),
        ),
        SizedBox(
          height: 2,
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  controller.onTapRemoveProductItem(productItem);
                },
                child: Container(
                  height: 35,
                  width: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorResource.color_main_light,
                  ),
                  child: Icon(Icons.delete),
                ),
              ),
              Container(
                height: 35,
                width: 2,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.onTapSubtract(productItem);
                  },
                  child: Container(
                    height: 35,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: ColorResource.color_main_light,
                    ),
                    child: Icon(Icons.remove),
                  ),
                ),
              ),
              Container(
                height: 35,
                width: 2,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.onTapPlus(productItem);
                  },
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: ColorResource.color_main_light,
                    ),
                    child: Icon(Icons.add),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  String get countPrice {
    double total = 0.0;
    total = (productItem.boxCake!.productPrice ?? 0).toDouble();
    return "${FormatUtils.oCcy.format(total)}đ";
  }
}
