import 'package:flutter/material.dart';
import 'package:loto/page/landing/models/block_menu.dart';
import 'package:loto/src/style_resource.dart';

abstract class BlockItemBase{
  Widget buildBlockItem(BuildContext context, BlockMenu menu){
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