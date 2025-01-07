import 'package:flutter/material.dart';
import 'package:loto/page/shopping/blog/model/add_review/add_review_model.dart';

class AddReviewView extends StatelessWidget {
  final AddReviewModel model;
  const AddReviewView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
                height: 4,
                color: const Color(0xFFF4952C)
            ),
          ),
          GestureDetector(
            onTap: (){
              model.onTapAddReview();
            },
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  color: const Color(0xFFF4952C)
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: const Text(
                "Viết đánh giá",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
