import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loto/base/base_model.dart';
import 'package:loto/base/base_model.dart';
import 'package:loto/page/shopping/about_us/model/chef/chef_model.dart';
import 'package:loto/page/shopping/about_us/model/chef/chef_view.dart';
import 'package:loto/page/shopping/about_us/model/inbox/inbox_model.dart';
import 'package:loto/page/shopping/about_us/model/inbox/inbox_view.dart';
import 'package:loto/page/shopping/about_us/model/inbox/inbox_view_mobile.dart';
import 'package:loto/page/shopping/home/model/banner/banner_model.dart';
import 'package:loto/page/shopping/home/model/banner/banner_view.dart';
import 'package:loto/page/shopping/home/model/banner/banner_view_mobile.dart';
import 'package:loto/page/shopping/home/model/best_seller/best_seller_model.dart';
import 'package:loto/page/shopping/home/model/best_seller/best_seller_view.dart';
import 'package:loto/page/shopping/home/model/best_seller/best_seller_view_mobile.dart';
import 'package:loto/page/shopping/home/model/category/category_recipe_model.dart';
import 'package:loto/page/shopping/home/model/category/category_recipe_view.dart';
import 'package:loto/page/shopping/home/model/category/category_recipe_view_mobile.dart';
import 'package:loto/page/shopping/home/model/testimonial/testimonial_model.dart';
import 'package:loto/page/shopping/home/model/testimonial/testimonial_view.dart';
import 'package:loto/page/shopping/home/model/testimonial/testimonial_view_mobile.dart';
import 'package:loto/page/shopping/home_main/model/footer/footer_model.dart';
import 'package:loto/page/shopping/home_main/model/footer/footer_view.dart';
import 'package:loto/page/shopping/home_main/model/footer/footer_view_mobile.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class HomeController extends GetxController{
  List<Widget> listModelView = [];
  List<Widget> listModelViewMobile = [];
  List<Widget> listModelViewTablet = [];

  BannerModel bannerModel = BannerModel();
  CategoryRecipeModel categoryRecipeModel = CategoryRecipeModel();
  TastyRecipeModel tastyRecipeModel = TastyRecipeModel();
  ChefModel chefModel = ChefModel();
  TestimonialModel testimonialModel = TestimonialModel();
  InboxModel inboxModel = InboxModel();
  FooterModel footerModel = FooterModel();

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  initData(){
    listModelView.addAll([
      BannerView(model: bannerModel),
      CategoryRecipeView(model: categoryRecipeModel),
      BestSellerView(model: tastyRecipeModel),
      ChefView(model: chefModel,),
      TestimonialView(model: testimonialModel,),
      InboxView(model: inboxModel,),
      FooterView(model: footerModel,),
    ]);
    listModelViewTablet.addAll([
      BannerViewMobile(model: bannerModel),
      CategoryRecipeViewMobile(model: categoryRecipeModel,),
      BestSellerViewMobile(model: tastyRecipeModel,),
      TestimonialViewMobile(model: testimonialModel,),
      InboxViewMobile(model: inboxModel,),
      FooterViewMobile(model: footerModel,),
    ]);
    listModelViewMobile.addAll([
      BannerViewMobile(model: bannerModel),
      CategoryRecipeViewMobile(model: categoryRecipeModel,),
      BestSellerViewMobile(model: tastyRecipeModel,),
      TestimonialViewMobile(model: testimonialModel,),
      InboxViewMobile(model: inboxModel,),
      FooterViewMobile(model: footerModel,),
    ]);
  }

  Widget getViewModel(int index){
    var data = listModelView[index];

    switch (data.runtimeType) {
      case BannerModel : {
        BannerModel model = data as BannerModel;
        return BannerView(model: model);
      }
      case CategoryRecipeModel : {
        CategoryRecipeModel model = data as CategoryRecipeModel;
        return CategoryRecipeView(model: model);
      }
      case TastyRecipeModel : {
        TastyRecipeModel model = data as TastyRecipeModel;
        return BestSellerView(model: model);
      }
      case ChefModel : {
        ChefModel model = data as ChefModel;
        return ChefView(model: model);
      }
      case TestimonialModel : {
        TestimonialModel model = data as TestimonialModel;
        return TestimonialView(model: model);
      }
      case InboxModel : {
        InboxModel model = data as InboxModel;
        return InboxView(model: model);
      }
      default : {
        return const SizedBox();
      }
    }

  }
}