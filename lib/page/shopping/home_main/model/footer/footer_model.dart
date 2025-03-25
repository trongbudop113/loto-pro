import 'package:get/get.dart';
import 'package:loto/base/base_model.dart';
import 'package:loto/page_config.dart';

class FooterModel extends BaseModel{
  FooterModel();


  @override
  void onFinish() {
    // TODO: implement onFinish
  }

  @override
  void onStart() {
    // TODO: implement onStart
  }

  void onGotoRecipePage(){
    Get.toNamed(PageConfig.RECIPE);
  }
}