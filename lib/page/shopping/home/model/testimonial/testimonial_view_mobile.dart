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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const SizedBox(height: 30),
          const Text(
            "Đánh giá",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFF8E25),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Tôi cũng rất quan tâm về trải nghiệm của bạn",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF333333),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 320,
            child: Obx(() {
              if (model.listData.isEmpty) {
                return const SizedBox();
              }
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: model.listData.length,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                itemBuilder: (c, i) {
                  return Container(
                    width: 280,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF8E25).withOpacity(0.08),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFFFF8E25).withOpacity(0.15),
                                const Color(0xFFFF8E25).withOpacity(0.05),
                              ],
                            ),
                            border: Border.all(
                              color: const Color(0xFFFF8E25).withOpacity(0.1),
                              width: 1,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Image.network(
                              model.listData[i].userAvatar ?? '',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Color(0xFFFF8E25),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          model.listData[i].userName ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            model.listData[i].rating ?? 0,
                            (e) => const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              child: Icon(
                                Icons.star_rounded,
                                color: Color(0xFFFF8E25),
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Text(
                            model.listData[i].userContent ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xFF666666),
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (c, i) => const SizedBox(width: 15),
              );
            }),
          ),
        ],
      ),
    );
  }
}
