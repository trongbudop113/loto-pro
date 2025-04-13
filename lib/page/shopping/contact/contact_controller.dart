import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/about_us/model/inbox/inbox_model.dart';
import 'package:loto/page/shopping/about_us/model/inbox/inbox_view.dart';
import 'package:loto/page/shopping/about_us/model/inbox/inbox_view_mobile.dart';
import 'package:loto/page/shopping/contact/model/contact_box/contact_box_model.dart';
import 'package:loto/page/shopping/contact/model/contact_box/contact_box_view.dart';
import 'package:loto/page/shopping/contact/model/contact_box/contact_box_view_mobile.dart';
import 'package:loto/page/shopping/home_main/model/footer/footer_model.dart';
import 'package:loto/page/shopping/home_main/model/footer/footer_view.dart';
import 'package:loto/page/shopping/home_main/model/footer/footer_view_mobile.dart';
import 'package:loto/page/shopping/home_main/model/top_title/top_title_model.dart';
import 'package:loto/page/shopping/home_main/model/top_title/top_title_view.dart';

class ContactBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ContactController());
  }
}

class ContactController extends GetxController{

  List<Widget> listModelView = [];
  List<Widget> listModelViewMobile = [];

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  initData(){
    TopTitleModel topTitleModel = TopTitleModel(
      title1: "Liên Hệ",
      title2: "Thông Tin Tại Đây"
    );
    ContactBoxModel contactBoxModel = ContactBoxModel();
    InboxModel inboxModel = InboxModel();
    FooterModel footerModel = FooterModel();
    listModelView.addAll([
      TopTitleView(model: topTitleModel,),
      ContactBoxView(model: contactBoxModel,),
      InboxView(model: inboxModel,),
      FooterView(model: footerModel,),
    ]
    );
    listModelViewMobile.addAll([
      TopTitleView(model: topTitleModel,),
      ContactBoxViewMobile(model: contactBoxModel,),
      InboxViewMobile(model: inboxModel,),
      FooterViewMobile(model: footerModel,),
    ]);
  }
}