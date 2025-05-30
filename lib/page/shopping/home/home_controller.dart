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

class HomeController extends GetxController with GetTickerProviderStateMixin {
  final listModels = <BaseModel>[].obs;
  final isLoading = true.obs;
  late final ScrollController scrollController;
  
  @override
  void onInit() {
    scrollController = ScrollController();
    initData();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Widget getViewModel(int index, DeviceType deviceType) {
    if (index >= listModels.length) return const SizedBox();

    final model = listModels[index];

    switch (model.runtimeType) {
      case BannerModel:
        return deviceType == DeviceType.desktop
            ? BannerView(model: model as BannerModel)
            : BannerViewMobile(model: model as BannerModel);

      case CategoryRecipeModel:
        return deviceType == DeviceType.desktop
            ? CategoryRecipeView(model: model as CategoryRecipeModel)
            : CategoryRecipeViewMobile(model: model as CategoryRecipeModel);

      case TastyRecipeModel:
        return deviceType == DeviceType.desktop
            ? BestSellerView(model: model as TastyRecipeModel)
            : BestSellerViewMobile(model: model as TastyRecipeModel);

      case ChefModel:
        return deviceType == DeviceType.desktop
            ? ChefView(model: model as ChefModel)
            : const SizedBox();

      case TestimonialModel:
        return deviceType == DeviceType.desktop
            ? TestimonialView(model: model as TestimonialModel)
            : TestimonialViewMobile(model: model as TestimonialModel);

      case InboxModel:
        return deviceType == DeviceType.desktop
            ? InboxView(model: model as InboxModel)
            : InboxViewMobile(model: model as InboxModel);

      case FooterModel:
        return deviceType == DeviceType.desktop
            ? FooterView(model: model as FooterModel)
            : FooterViewMobile(model: model as FooterModel);

      default:
        return const SizedBox();
    }
  }

  Future<void> initData() async {
    isLoading.value = true;
    
    // Load primary content first
    await _loadPrimaryContent();
    
    // Load secondary content after primary is rendered
    _loadSecondaryContent();
  }

  Future<void> _loadPrimaryContent() async {
    final primaryModels = [
      BannerModel(),
      CategoryRecipeModel(),
    ];
    
    for (final model in primaryModels) {
      listModels.add(model);
    }
    
    isLoading.value = false;
  }

  void _loadSecondaryContent() {
    Future.microtask(() async {
      final secondaryModels = [
        TastyRecipeModel(),
        TestimonialModel(),
        InboxModel(),
        FooterModel(),
      ];

      for (final model in secondaryModels) {
        listModels.add(model);
      }
    });
  }

  DeviceType getDeviceType(double width) {
    if (width < 600) return DeviceType.mobile;
    if (width < 900) return DeviceType.tablet;
    return DeviceType.desktop;
  }
}



// Add this method to BaseModel
extension BaseModelExtension on BaseModel {
  Future<void> initializeForMobile() async {
    // Optimize images and data for mobile
    // Implement in each model class
  }
}

enum DeviceType { mobile, tablet, desktop }