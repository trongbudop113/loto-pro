import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/cart/cart_controller.dart';
import 'package:loto/src/color_resource.dart';
import 'package:loto/src/style_resource.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
        padding: EdgeInsets.all(15),
        itemBuilder: (c, i){
          return Container(
            decoration: BoxDecoration(
              color: ColorResource.color_main_light
            ),
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  child: Text("Hộp trung thu Nam Sư", style: TextStyleResource.textStyleBlack(context)),
                  alignment: Alignment.centerLeft,
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
                          Text("Gồm:", style: TextStyleResource.textStyleBlack(context)),
                          SizedBox(height: 10),
                          Text("Bánh Thập Cẩm", style: TextStyleResource.textStyleBlack(context)),
                          Text("Bánh Hạt Sen", style: TextStyleResource.textStyleBlack(context)),
                          Text("Bánh Đậu Xanh", style: TextStyleResource.textStyleBlack(context)),
                          Text("Bánh Đâu Đỏ", style: TextStyleResource.textStyleBlack(context)),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: List.generate(4, (index) => Container(
                    width: 70,
                    height: 70,
                    color: ColorResource.color_background_dark,
                    margin: EdgeInsets.only(right: 10),
                  )),
                )
              ],
            ),
          );
        },
        separatorBuilder: (c, i){
          return Container(height: 15);
        },
        itemCount: 5
      ),
    );
  }
}