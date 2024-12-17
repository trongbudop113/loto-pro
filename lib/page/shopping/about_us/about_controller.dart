import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loto/core/custom_get_controller.dart';
import 'package:loto/page/shopping/about_us/model/inbox/inbox_model.dart';
import 'package:loto/page/shopping/about_us/model/inbox/inbox_view.dart';
import 'package:loto/page/shopping/about_us/model/inbox/inbox_view_mobile.dart';
import 'package:loto/page/shopping/about_us/model/time_line/time_line_model.dart';
import 'package:loto/page/shopping/about_us/model/time_line/time_line_view.dart';
import 'package:loto/page/shopping/home_main/model/footer/footer_model.dart';
import 'package:loto/page/shopping/home_main/model/footer/footer_view.dart';
import 'package:loto/page/shopping/home_main/model/top_title/top_title_model.dart';
import 'package:loto/page/shopping/home_main/model/top_title/top_title_view.dart';

class AboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AboutController());
  }
}

class AboutController extends CustomGetController {
  List<Widget> listModelView = [];
  List<Widget> listModelViewMobile = [];
  List<Widget> listModelViewTablet = [];

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  initData() {
    TopTitleModel model = TopTitleModel(
      title1: "Về Chúng Tôi",
      title2: "Những câu chuyện",
    );
    InboxModel inboxModel = InboxModel();
    FooterModel footerModel = FooterModel();
    TimeLineModel timeLineModel = TimeLineModel();
    listModelView.addAll([
      TopTitleView(model: model),
      TimeLineView(model: timeLineModel),
      InboxView(model: inboxModel),
      FooterView(model: footerModel)
    ]);
    listModelViewTablet.addAll([
      TopTitleView(model: model),
      InboxViewMobile(model: inboxModel),
      FooterView(model: footerModel)
    ]);
    listModelViewMobile.addAll([
      TopTitleView(model: model),
      InboxViewMobile(model: inboxModel),
      FooterView(model: footerModel)
    ]);
  }
}
