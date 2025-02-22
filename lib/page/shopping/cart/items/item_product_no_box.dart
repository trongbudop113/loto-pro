import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/utils.dart';
import 'package:loto/page/shopping/moon_cake/models/order_moon_cake.dart';
import 'package:loto/src/color_resource.dart';
import 'package:loto/src/style_resource.dart';

enum ItemMode{
  view,
  cart
}

class ItemProductNoBox extends StatelessWidget {
  final ProductOrder productItem;
  final ItemMode itemMode;
  const ItemProductNoBox({
    super.key,
    required this.productItem,
    this.itemMode = ItemMode.cart
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: ColorResource.color_main_light,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
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
                  const SizedBox(
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
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: getBackgroundColor(
                          productItem.boxCake!.productColor, context),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: Image.network(
                      productItem.boxCake!.productImageMain ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Visibility(
                      visible: productItem.boxCake?.productCategory == 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Loại:",
                            style: TextStyleResource.textStyleBlack(context),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${productItem.boxCake!.numberEggs} Trứng - ${productItem.boxCake!.productType}g",
                            style: TextStyleResource.textStyleBlack(context),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  "Giá: $countPrice",
                  style: TextStyleResource.textStyleBlack(context),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Visibility(
          visible: itemMode == ItemMode.cart,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    productItem.onTapRemoveProduct?.call();
                  },
                  child: Container(
                    height: 35,
                    width: 80,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: ColorResource.color_main_light,
                    ),
                    child: const Icon(Icons.delete),
                  ),
                ),
                const SizedBox(
                  height: 35,
                  width: 2,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      productItem.onTapSubtract?.call();
                    },
                    child: Container(
                      height: 35,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: ColorResource.color_main_light,
                      ),
                      child: const Icon(Icons.remove),
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
                      productItem.onTapPlus?.call();
                    },
                    child: Container(
                      height: 35,
                      decoration: const BoxDecoration(
                        color: ColorResource.color_main_light,
                      ),
                      child: const Icon(Icons.add),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Color getBackgroundColor(String? color, BuildContext context) {
    if (color == null) return ColorResource.color_background_light;
    return Color(int.parse("0xFF$color"));
  }

  String get countPrice {
    double total = 0.0;
    total = (productItem.boxCake!.productPrice ?? 0).toDouble();
    return "${FormatUtils.oCcy.format(total)}đ";
  }
}
