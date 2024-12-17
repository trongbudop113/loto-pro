import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loto/page/shopping/blog/model/blog_event/blog_event_model.dart';

class BlockEventView extends StatelessWidget {
  final BlogEventModel model;
  const BlockEventView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return _buildListProduct();
  }

  Widget _buildListProduct() {
    return Obx(() {
      if (model.listTestimonial.isEmpty) {
        return const SizedBox();
      }
      return GridView.builder(
        itemCount: model.listTestimonial.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 66).copyWith(top: 60),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 54,
            mainAxisSpacing: 64,
            childAspectRatio: 1),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Ftestimonials%2Fcroitsant.webp?alt=media&token=eb776ca4-141a-4d44-98b0-796708f35add",
                    ),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 55,
                  vertical: 145,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('dd MMM yyyy',"vi").format(model.listTestimonial[index].createDate!),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Text(
                        model.listTestimonial[index].userContent ?? '',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
