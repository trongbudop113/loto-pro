import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/core/custom_get_controller.dart';

abstract class CustomGetView<T extends CustomGetController> extends GetResponsiveView<T> {
  CustomGetView({Key? key, this.isShowAppbar = true}) : super(key: key);
  final bool isShowAppbar;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: (isShowAppbar ?? false) ? AppBar(
        title: Text(controller.textAppbar),
      ) : null,
      body: buildBody(context)
    );
  }

  Widget buildBody(BuildContext context){
    if(context.isLargeTablet){
      return buildBodyWeb(context);
    }
    if(context.isTablet){
      return buildBodyTablet(context);
    }
    if(context.isPhone){
      return buildBodyMobile(context);
    }

    return buildBodyWeb(context);
  }

  Widget buildBodyTablet(BuildContext context){
    return Container(
      color: Colors.amber,
    );
  }

  Widget buildBodyMobile(BuildContext context){
    return Container(
      color: Colors.pink,
    );
  }

  Widget buildBodyWeb(BuildContext context){
    return Container(
      color: Colors.blue,
    );
  }
}