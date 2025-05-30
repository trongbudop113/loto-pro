import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/base/base_model.dart';
import 'package:loto/page/shopping/blog/model/add_review/add_review_model.dart';

class AddReviewLayout<T extends BaseModel> extends StatelessWidget {
  final T model;
  const AddReviewLayout({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Viết đánh giá",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 16),
          _buildStarRating(),
          const SizedBox(height: 24),
          _buildTextField(),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Get.back(),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                      side: const BorderSide(
                        color: Color(0xFFFF8E25),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Hủy",
                    style: TextStyle(
                      color: Color(0xFFFF8E25),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Obx(() => ElevatedButton(
                      onPressed: () {
                        if(model.submitCallBack != null){
                          model.submitCallBack?.call();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: const Color(0xFFFF8E25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60),
                        ),
                      ),
                      child: model.isLoading.value
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              "Gửi",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStarRating() {
    return Column(
      children: [
        Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () => (model as AddReviewModel).rating.value = index + 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(
                  (model as AddReviewModel).rating.value > index
                      ? Icons.star_rounded
                      : Icons.star_outline_rounded,
                  size: 36,
                  color: const Color(0xFFFF8E25),
                ),
              ),
            );
          }),
        )),
        const SizedBox(height: 8),
        Obx(() => (model as AddReviewModel).showError.value && 
                  (model as AddReviewModel).rating.value == 0
            ? const Text(
                "Vui lòng chọn số sao đánh giá",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              )
            : const SizedBox()),
      ],
    );
  }

  Widget _buildTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          maxLines: 5,
          onChanged: (value) => (model as AddReviewModel).content.value = value,
          decoration: InputDecoration(
            hintText: "Chia sẻ trải nghiệm của bạn...",
            hintStyle: const TextStyle(
              color: Color(0xFF999999),
              fontSize: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFEEEEEE),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFEEEEEE),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFFF8E25),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Obx(() => (model as AddReviewModel).showError.value && 
                  (model as AddReviewModel).content.value.isEmpty
            ? const Text(
                "Vui lòng nhập nội dung đánh giá",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              )
            : const SizedBox()),
      ],
    );
  }
}
