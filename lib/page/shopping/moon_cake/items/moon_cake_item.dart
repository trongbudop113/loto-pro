import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/moon_cake/controller/moon_cake_controller.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product.dart';
import 'package:loto/page/shopping/moon_cake/models/egg_data.dart';
import 'package:loto/shapes/quater_circle.dart';
import 'package:loto/src/color_resource.dart';
import 'package:loto/src/style_resource.dart';

class AppListItem extends StatefulWidget {
  final int index;
  final MoonCakeController controller;
  final CakeProduct product;

  const AppListItem({
    super.key,
    required this.index,
    required this.controller,
    required this.product,
  });

  @override
  State<AppListItem> createState() => _AppListItemState();
}

class _AppListItemState extends State<AppListItem> {


  List<EggData> listEgg = [];
  final RxDouble productPrice = 0.0.obs;
  late CakeProduct product;

  @override
  void initState() {
    product = widget.product;
    initListEgg();
    super.initState();
  }

  void initListEgg(){
    listEgg = EggData.listTwo();
    if (product.productType!= null && product.productType == 200) {
      listEgg = EggData.listThree();
    }
    listEgg[1].isSelect.value = true;
    productPrice.value = (widget.product.productPrice ?? 0).toDouble() + (listEgg[1].defaultPrice ?? 0).toDouble();
    product.numberEggs = listEgg[1].value ?? 1;
  }

  void selectEgg(EggData data) {
    for (var e in listEgg) {
      e.isSelect.value = false;
      if (e.value == data.value) {
        e.isSelect.value = true;
        data.isSelect.value = true;
        print(e.toJson());
        productPrice.value = (product.productPrice ?? 0).toDouble() + (e.defaultPrice ?? 0).toDouble();
        product.numberEggs = e.value ?? 1;
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.controller.onClickDetail(widget.product);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 1,
              offset: const Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            _buildMain(context),
            _buildEggWidget(context),
            _buildWeightWidget(context),
          ],
        ),
      ),
    );
  }

  Positioned _buildEggWidget(BuildContext context) {
    return Positioned(
      right: 10,
      bottom: 68,
      child: Container(
        width: listEgg.length * 40,
        height: 35,
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: Colors.black54,
        ),
        child: Row(
          children: listEgg.map((e) {
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  selectEgg(e);
                },
                child: Obx(() =>
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: e.isSelect.value ? Colors.white54 : Colors
                            .transparent,
                      ),
                      alignment: Alignment.center,
                      child: Text("${e.value}T"),
                    )),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Positioned _buildWeightWidget(BuildContext context){
    return Positioned(
      top: 0,
      right: 0,
      child: Stack(
        children: [
          Container(
            width: 70,
            height: 70,
            alignment: Alignment.topRight,
            child: const QuarterCircle(
              circleAlignment: CircleAlignment.topRight,
            ),
          ),
          Positioned(
            top: 0,
            bottom: 15,
            left: 10,
            right: 0,
            child: Center(
              child: Text(
                "${product.productType}g",
                style:
                TextStyleResource.textStyleWhite(context).copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMain(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Container(
              alignment: Alignment.center,
              color: widget.controller.getBackgroundColor(widget.product.productColor, context),
              child: Image.network(
                widget.product.productImageMain ?? '',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 60,
          child: Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      product.productName.toString(),
                      style: TextStyleResource.textStyleWhite(context)
                          .copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: 8),
                    Obx(() => Text(
                      widget.controller
                          .formatCurrency(productPrice.value),
                      style: TextStyleResource.textStyleBlack(context)
                          .copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  product.productPrice = productPrice.value;
                  widget.controller.listClick(product);
                },
                child: Container(
                  width: 60,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(360),
                      color: ColorResource.color_background_light,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.add_shopping_cart_outlined,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
