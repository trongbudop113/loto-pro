import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/landing/landing_controller.dart';

class BlockFooter extends GetResponsiveView<LandingController>{
  @override
  Widget build(BuildContext context) {
    return buildBody(context);
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

  Widget buildBodyMobile(BuildContext context){
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          widget1(),
          widget2(),
          widget3(),
          widget4(),
        ],
      ),
    );
  }

  Widget buildBodyTablet(BuildContext context){
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: widget1(),
              ),
              Expanded(
                child: widget2(),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: widget3(),
              ),
              Expanded(
                child: widget4(),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildBodyWeb(BuildContext context){
    return Container(
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: widget1(),
          ),
          Expanded(
            child: widget2(),
          ),
          Expanded(
            child: widget3(),
          ),
          Expanded(
            child: widget4(),
          )
        ],
      ),
    );
  }

  Widget widget1(){
    return Container(
      color: Colors.amber,
      alignment: Alignment.center,
      height: 200,
    );
  }

  Widget widget2(){
    return Container(
      color: Colors.pink,
      alignment: Alignment.center,
      height: 200,
    );
  }

  Widget widget3(){
    return Container(
      color: Colors.blue,
      alignment: Alignment.center,
      height: 200,
    );
  }

  Widget widget4(){
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      height: 200,
    );
  }
}