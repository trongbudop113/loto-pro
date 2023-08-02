import 'package:flutter/material.dart';
import 'package:loto/page/landing/models/block_menu.dart';
import 'package:loto/responsive/dimensions.dart';
import 'package:loto/src/style_resource.dart';

abstract class BlockItemBase{

  LayoutEnum layoutDesign = LayoutEnum.mobile;

  Widget buildBlockItem(BuildContext context, BlockMenu menu){
    if(layoutDesign == LayoutEnum.mobile){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildImage(menu.blockIcon ?? ''),
          const SizedBox(height: 10),
          buildTitle(context, name: menu.blockName ?? '')
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildImage(menu.blockIcon ?? ''),
        const SizedBox(width: 10),
        buildTitle(context, name: menu.blockName ?? '')
      ],
    );
  }

  Widget buildImage(String image){
    return Image.network(image, width: 70, height: 70);
  }

  Widget buildTitle(BuildContext context, {required String name}){
    return Text(
      name,
      style: TextStyleResource.textStyleBlack(context),
    );
  }
}