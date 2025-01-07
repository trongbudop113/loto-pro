import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          Container(
            height: 250,
            alignment: Alignment.centerLeft,
            child: Obx(() {
              if (model.listData.isEmpty) {
                return const SizedBox();
              }
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: model.listData.length,
                itemBuilder: (c, i) {
                  return Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(360),
                          child: Container(
                            color: Colors.red,
                            width: 70,
                            height: 70,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          model.listData[i].userName ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          model.listData[i].userContent ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.black,
                            height: 1.2,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 10,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: List.generate(
                            model.listData[i].rating ?? 0,
                                (e) {
                              return const Icon(
                                Icons.star,
                                color: Color(0xFFDBFF01),
                              );
                            },
                          ).toList(),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (c, i) {
                  return const SizedBox(width: 15);
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
