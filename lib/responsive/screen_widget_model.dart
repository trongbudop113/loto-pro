import 'package:flutter/material.dart';
import 'package:loto/responsive/divider_layout.dart';
import 'package:loto/responsive/screen_size_config.dart';

class WidgetContainer extends StatelessWidget with DividerLayoutModel{
  final Widget child;
  WidgetContainer({Key? key, required this.child, Map<DeviceScreen, int>? responsiveScreens}) : super(key: key){
    init(responsiveScreens: responsiveScreens);
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}