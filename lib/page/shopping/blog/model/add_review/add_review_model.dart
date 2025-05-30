import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/base/base_model.dart';
import 'package:loto/page/shopping/blog/layout/add_review_layout.dart';

class AddReviewModel extends BaseModel{

  final content = ''.obs;
  final rating = 0.obs;
  final showError = false.obs;

  bool validate() {
    showError.value = true;
    return rating.value > 0 && content.value.isNotEmpty;
  }

  @override
  void onFinish() {
    // TODO: implement onFinish
  }

  @override
  void onStart() {
    // TODO: implement onStart
  }

  Future<void> onTapAddReview() async {
    submitCallBack = _submitReview;
    var res = await Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: AddReviewLayout(model: this),
      ),
    );
    if(res == null){
      onReset();
    }
  }

  void onReset(){
    rating.value = 0;
    showError.value = false;
    content.value = "";
  }

  Future<void> _submitReview() async {
    try {
      isLoading.value = true;
      if(!validate()){
        isLoading.value = false;
        return;
      }
      // TODO: Implement your API call here
      await Future.delayed(const Duration(seconds: 2)); // Simulated API call
      Get.back();
      Get.snackbar(
        'Thành công',
        'Cảm ơn bạn đã chia sẻ đánh giá!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Có lỗi xảy ra, vui lòng thử lại sau.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

}