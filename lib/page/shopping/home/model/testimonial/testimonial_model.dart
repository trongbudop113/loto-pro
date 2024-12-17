import 'package:get/get.dart';
import 'package:loto/base/base_model.dart';
import 'package:loto/page/shopping/blog/model_data/testimonial_product_res.dart';
import 'package:loto/page/shopping/home_main/home_main_controller.dart';

class TestimonialModel extends BaseModel{

  final RxList<TestimonialProductRes> listData = <TestimonialProductRes>[].obs;

  void setListTestimonial(List<TestimonialProductRes> lsCategory){
    listData.addAll(lsCategory);
  }

  @override
  void onFinish() {
    // TODO: implement onFinish
  }

  @override
  void onStart() {
    // TODO: implement onStart
  }

  void onTapViewAll() {
    Get.find<HomeMainController>().onChangeTap(3);
  }
}