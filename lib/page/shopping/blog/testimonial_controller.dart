import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/about_us/model/inbox/inbox_model.dart';
import 'package:loto/page/shopping/about_us/model/inbox/inbox_view.dart';
import 'package:loto/page/shopping/blog/model/add_review/add_review_model.dart';
import 'package:loto/page/shopping/blog/model/add_review/add_review_view.dart';
import 'package:loto/page/shopping/blog/model/blog_event/block_event_view.dart';
import 'package:loto/page/shopping/blog/model/blog_event/blog_event_model.dart';
import 'package:loto/page/shopping/home_main/model/footer/footer_model.dart';
import 'package:loto/page/shopping/home_main/model/footer/footer_view.dart';
import 'package:loto/page/shopping/home_main/model/top_title/top_title_model.dart';
import 'package:loto/page/shopping/home_main/model/top_title/top_title_view.dart';

class TestimonialBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => TestimonialController());
  }
}

class TestimonialController extends GetxController{

  List<Widget> listModelView = [];
  List<Widget> listModelViewMobile = [];

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  void initData() {
    TopTitleModel titleModel = TopTitleModel(
      title1: "Đánh Giá",
      title2: "Chúng tôi cũng rất quan tâm\nvề đánh giá của bạn",
    );
    InboxModel inboxModel = InboxModel();
    AddReviewModel addReviewModel = AddReviewModel();
    FooterModel footerModel = FooterModel();
    BlogEventModel blogEventModel = BlogEventModel();

    listModelView.addAll([
      TopTitleView(model: titleModel,),
      AddReviewView(model: addReviewModel,),
      BlockEventView(model: blogEventModel,),
      InboxView(model: inboxModel,),
      FooterView(model: footerModel,)
    ]);

    listModelViewMobile.addAll([
      TopTitleView(model: titleModel,),
    ]);
  }
}