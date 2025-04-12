import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/home/model/testimonial/testimonial_model.dart';

class TestimonialView extends StatelessWidget {
  final TestimonialModel model;
  const TestimonialView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return buildDelicious();
  }

  Widget buildDelicious() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 54),
      child: Column(
        children: [
          const SizedBox(height: 95),
          const Text(
            "Đánh Giá",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFF8E25),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Chúng tôi cũng rất quan tâm\nvề đánh giá của bạn",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 60),
          SizedBox(
            height: 420,
            child: Obx(() {
              if (model.listData.isEmpty) return const SizedBox();
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: model.listData.length,
                itemBuilder: (c, i) {
                  return Container(
                    width: 350,
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF8E25).withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
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
                            borderRadius: BorderRadius.circular(60),
                            child: Image.network(
                              model.listData[i].userAvatar ?? '',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Color(0xFFFF8E25),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          model.listData[i].userName ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            model.listData[i].rating ?? 0,
                            (e) => const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: Icon(
                                Icons.star_rounded,
                                color: Color(0xFFFF8E25),
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Text(
                            model.listData[i].userContent ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xFF666666),
                              height: 1.6,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (c, i) => const SizedBox(width: 30),
              );
            }),
          ),
          const SizedBox(height: 30),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => model.onTapViewAll(),
              borderRadius: BorderRadius.circular(30),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF8E25), Color(0xFFFFB067)],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF8E25).withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Xem tất cả",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
