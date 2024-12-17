
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/blog/testimonial_controller.dart';
import 'package:loto/page/shopping/blog/testimonial_page.dart';
import 'package:loto/page/shopping/shop_product/shop_product_controller.dart';
import 'package:loto/page/shopping/shop_product/shop_product_page.dart';
import 'package:loto/page/shopping/shop_product_detail/shop_product_detail_controller.dart';
import 'package:loto/page/shopping/shop_product_detail/shop_product_detail_page.dart';

enum Destination {
  // Update these values in the enum with new values that represent the
  // screens that you want to navigate in your app.
  shop_product,
  shop_product_detail,
  blog,
  blog_detail;

  String get route {
    return '/${describeEnum(this)}';
  }

  GetPageRoute get widget {
    // Update the cases in this switch for each element of this enum
    // and the screens that you want to navigate when an enum is selected.
    switch (this) {
      case Destination.shop_product:
        return GetPageRoute(
          page: (){
            return const ShopProductPage();
          },
          binding: ShopProductBinding()
        );
        //return const BlogPage();
      case Destination.shop_product_detail:
        return GetPageRoute(
            page: (){
              return const ShopProductDetailPage();
            },
            binding: BlogDetailBinding()
        );
      case Destination.blog:
        return GetPageRoute(
            page: (){
              return const TestimonialPage();
            },
            binding: TestimonialBinding()
        );
      case Destination.blog_detail:
        return GetPageRoute(
            page: (){
              return const TestimonialPage();
            },
            binding: TestimonialBinding()
        );
    }
  }

  static GetPageRoute getPage(RouteSettings settings) {
    var destination = Destination.values.firstWhereOrNull((e) => e.route == settings.name);
    destination ??= Destination.values[0];
    return destination.widget;
  }
}
