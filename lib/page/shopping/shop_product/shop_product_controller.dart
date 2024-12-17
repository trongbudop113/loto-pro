import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/about_us/model/inbox/inbox_model.dart';
import 'package:loto/page/shopping/about_us/model/inbox/inbox_view.dart';
import 'package:loto/page/shopping/about_us/model/inbox/inbox_view_mobile.dart';
import 'package:loto/page/shopping/home_main/model/footer/footer_model.dart';
import 'package:loto/page/shopping/home_main/model/footer/footer_view.dart';
import 'package:loto/page/shopping/home_main/model/footer/footer_view_mobile.dart';
import 'package:loto/page/shopping/home_main/model/top_title/top_title_model.dart';
import 'package:loto/page/shopping/home_main/model/top_title/top_title_view.dart';
import 'package:loto/page/shopping/shop_product/model/top_product_model.dart';
import 'package:loto/page/shopping/shop_product/model/top_product_view.dart';
import 'package:loto/page/shopping/shop_product/model/top_product_view_mobile.dart';

class ShopProductBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ShopProductController());
  }
}

class ShopProductController extends GetxController{

  List<Widget> listModelView = [];
  List<Widget> listModelViewMobile = [];

  SearchArticleModel searchArticleModel = SearchArticleModel();
  InboxModel inboxModel = InboxModel();
  FooterModel footerModel = FooterModel();

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  initData(){
    TopTitleModel titleModel = TopTitleModel(
      title1: "Sản Phẩm",
      title2: "Trải nghiệm tất cả tại đây",
    );
    listModelView.addAll([
      TopTitleView(model: titleModel,),
      TopProductView(model: searchArticleModel,),
      InboxView(model: inboxModel,),
      FooterView(model: footerModel,),
    ]
    );
    listModelViewMobile.addAll([
      TopTitleView(model: titleModel,),
      TopProductViewMobile(model: searchArticleModel,),
      InboxViewMobile(model: inboxModel,),
      FooterViewMobile(model: footerModel,),
    ]);
  }
}