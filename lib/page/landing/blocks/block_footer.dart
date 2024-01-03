import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/landing/landing_controller.dart';
import 'package:loto/src/style_resource.dart';

class BlockFooter extends GetResponsiveView<LandingController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [buildBody(context), endPage(context)],
    );
  }

  Widget endPage(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent,
      alignment: Alignment.center,
      padding: EdgeInsets.all(20),
      child: Text(
        "©Powered By Flutter Web",
        style: TextStyleResource.textStyleWhite(context),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    if (context.isLargeTablet) {
      return buildBodyWeb(context);
    }
    if (context.isTablet) {
      return buildBodyTablet(context);
    }
    if (context.isPhone) {
      return buildBodyMobile(context);
    }

    return buildBodyWeb(context);
  }

  Widget buildBodyMobile(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.teal,
      child: Column(
        children: [
          widget1(context),
          Container(
            height: 2,
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            color: Colors.white,
          ),
          widget2(context),
          Container(
            height: 2,
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            color: Colors.white,
          ),
          widget3(context),
          Container(
            height: 2,
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            color: Colors.white,
          ),
          widget4(context),
        ],
      ),
    );
  }

  Widget buildBodyTablet(BuildContext context) {
    return Container(
      color: Colors.teal,
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: widget1(context),
              ),
              Container(
                width: 2,
                height: 130,
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                color: Colors.white,
              ),
              Expanded(
                child: widget2(context),
              )
            ],
          ),
          Container(
            height: 2,
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            color: Colors.white,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: widget3(context),
              ),
              Container(
                width: 2,
                height: 130,
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                color: Colors.white,
              ),
              Expanded(
                child: widget4(context),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildBodyWeb(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.teal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: widget1(context),
          ),
          Container(
            width: 2,
            height: 150,
            alignment: Alignment.center,
            color: Colors.white,
          ),
          Expanded(
            child: widget2(context),
          ),
          Container(
            width: 2,
            height: 150,
            alignment: Alignment.center,
            color: Colors.white,
          ),
          Expanded(
            child: widget3(context),
          ),
          Container(
            width: 2,
            height: 150,
            alignment: Alignment.center,
            color: Colors.white,
          ),
          Expanded(
            child: widget4(context),
          )
        ],
      ),
    );
  }

  Widget widget1(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(
        children: [
          Text(
            "Sản Phẩm",
            style: TextStyleResource.textStyleWhite(context)
                .copyWith(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          SizedBox(height: 15,),
          Text(
            "Create Website/App",
            style: TextStyleResource.textStyleWhite(context),
          ),
          SizedBox(height: 10,),
          Text(
            "Secure Clould Hosting",
            style: TextStyleResource.textStyleWhite(context),
          ),
          SizedBox(height: 10,),
          Text(
            "Website Support",
            style: TextStyleResource.textStyleWhite(context),
          ),
        ],
      ),
    );
  }

  Widget widget2(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            "Company",
            style: TextStyleResource.textStyleWhite(context)
                .copyWith(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          SizedBox(height: 15,),
          Text(
            "About",
            style: TextStyleResource.textStyleWhite(context),
          ),
          SizedBox(height: 10,),
          Text(
            "Careers",
            style: TextStyleResource.textStyleWhite(context),
          ),
          SizedBox(height: 10,),
          Text(
            "Support",
            style: TextStyleResource.textStyleWhite(context),
          ),
          SizedBox(height: 10,),
          Text(
            "Pricing",
            style: TextStyleResource.textStyleWhite(context),
          ),
          SizedBox(height: 10,),
          Text(
            "FAQ",
            style: TextStyleResource.textStyleWhite(context),
          ),
        ],
      ),
    );
  }

  Widget widget3(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(
        children: [
          Text(
            "Resource",
            style: TextStyleResource.textStyleWhite(context)
                .copyWith(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          SizedBox(height: 15,),
          Text(
            "Blog",
            style: TextStyleResource.textStyleWhite(context),
          ),
          SizedBox(height: 10,),
          Text(
            "eBooks",
            style: TextStyleResource.textStyleWhite(context),
          ),
          SizedBox(height: 10,),
          Text(
            "Website Grader",
            style: TextStyleResource.textStyleWhite(context),
          ),
        ],
      ),
    );
  }

  Widget widget4(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(
        children: [
          Text(
            "Get Help",
            style: TextStyleResource.textStyleWhite(context)
                .copyWith(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          SizedBox(height: 15,),
          Text(
            "Help Center",
            style: TextStyleResource.textStyleWhite(context),
          ),
          SizedBox(height: 10,),
          Text(
            "Contact Us",
            style: TextStyleResource.textStyleWhite(context),
          ),
          SizedBox(height: 10,),
          Text(
            "Privacy Policy",
            style: TextStyleResource.textStyleWhite(context),
          ),
          SizedBox(height: 10,),
          Text(
            "Terms",
            style: TextStyleResource.textStyleWhite(context),
          ),
        ],
      ),
    );
  }
}
