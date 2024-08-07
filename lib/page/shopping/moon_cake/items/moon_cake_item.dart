import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/moon_cake/controller/moon_cake_controller.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product_model.dart';
import 'package:loto/src/image_resource.dart';
import 'package:loto/src/style_resource.dart';


class MoonCakeProductItem extends StatelessWidget{
  final CakeProductModel productModel;
  final MoonCakeController controller;

  const MoonCakeProductItem({super.key, required this.productModel, required this.controller,});


  @override
  Widget build(BuildContext context) {

    double heightItem = ((MediaQuery.of(context).size.width * 0.477) * 0.36).clamp(80, 130);
    if(MediaQuery.of(context).size.width < 1000){
      heightItem = ((MediaQuery.of(context).size.width * 0.477) * 0.36).clamp(80, 90);
    }

    return GestureDetector(
      onTap: () {
        productModel.onClickDetail(productModel.cakeProduct);
      },
      child: Stack(
        children: [
          _buildMain(context, heightItem: heightItem),
          _buildImageProduct(),
          _buildEggWidget(context, heightItem: heightItem),
          _buildWeightProduct(context, heightItem: heightItem),
        ],
      ),
    );
  }

  Positioned _buildImageProduct(){
    return Positioned(
      top: 0,
      left: 20,
      right: 20,
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.network(
          productModel.cakeProduct.productImageMain ?? '',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }

  Positioned _buildEggWidget(BuildContext context, {required double heightItem}) {
    return Positioned(
      right: 5,
      bottom: heightItem + 5,
      child: Container(
        width: productModel.listEgg.length * 50,
        height: 32,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: Colors.black54,
        ),
        child: Row(
          children: productModel.listEgg.map((e) {
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  productModel.selectEgg(e);
                },
                child: Obx(() => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: e.isSelect.value
                            ? Colors.white54
                            : Colors.transparent,
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${e.value}",
                            style: TextStyleResource.textStyleBlack(context)
                                .copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Image.asset(
                            ImageResource.ic_egg_yolk,
                            height: 15,
                          )
                        ],
                      ),
                    )),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Positioned _buildWeightProduct(BuildContext context, {required double heightItem}) {
    return Positioned(
      bottom: heightItem,
      left: 0,
      child: Stack(
        children: [
          Container(
            width: 50,
            height: 42,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: Colors.grey,
            ),
            alignment: Alignment.center,
            child: Text(
            "${productModel.cakeProduct.productType}g",
            textAlign: TextAlign.center,
            style: TextStyleResource.textStyleWhite(context).copyWith(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          ),
        ],
      ),
    );
  }

  Widget _buildMain(BuildContext context, {required double heightItem}) {

    return Positioned(
      top: 70,
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                child: Container(
                  alignment: Alignment.center,
                  color: productModel.getBackgroundColor,
                ),
              ),
            ),
            SizedBox(
              height: heightItem,
              width: double.maxFinite,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 8,
                    left: 10,
                    right: 10,
                    top: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          "${productModel.cakeProduct.productName}",
                          style:
                              TextStyleResource.textStyleBlack(context).copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(() => Text(
                              "Giá: ${productModel.formatCurrency}",
                              style: TextStyleResource.textStyleBlack(context)
                                  .copyWith(
                                fontSize: 16,
                                color: const Color(0xFFEC9E49),
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                        onTap: () {
                          productModel.cakeProduct.productPrice = productModel.productPrice.value;
                          controller.listClick(productModel.cakeProduct);
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(3),
                              bottomRight: Radius.circular(15),
                            ),
                            color: Color(0xFFEC9E49),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 18,
                          ),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
