import 'package:flutter/material.dart';
import 'package:loto/page/shopping/home/model/testimonial/testimonial_model.dart';

class TestimonialViewMobile extends StatelessWidget {
  final TestimonialModel model;
  const TestimonialViewMobile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return buildDelicious();
  }

  Widget buildDelicious() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const SizedBox(height: 30),
          const Text(
            "Đánh giá",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Color(0xFFF4952C)
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            "Tôi cũng rất quan tâm về trải nghiệm của bạn",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 250,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (c, i){
                return Container(
                  color: Colors.red,
                  alignment: Alignment.center,
                  width: 150,
                );
              },
              separatorBuilder: (c, i){
                return const SizedBox(width: 15);
              },
            ),
          )
        ],
      ),
    );
  }
}
