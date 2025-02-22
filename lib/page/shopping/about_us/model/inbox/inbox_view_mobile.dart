import 'package:loto/page/shopping/about_us/model/inbox/inbox_model.dart';
import 'package:flutter/material.dart';
import 'package:loto/src/image_resource.dart';

class InboxViewMobile extends StatelessWidget {
  final InboxModel model;
  const InboxViewMobile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return buildInbox(width);
  }

  Widget buildInbox(double width) {
    const double paddingItem = 15;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingItem),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              //height: width * 0.35,
              width: double.maxFinite,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Fcategories%2Fregister.webp?alt=media&token=8fed6fb2-272d-4517-86e2-8950ad09ef87"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: width * 0.05,),
                  const Text(
                    "Deliciousness to your inbox",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: width * 0.017),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetuipisicing elit, sed do eiusmod tempor\nincididunt ut labore et dolore magna aliqut enim ad minim ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      height: 16 / 12,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                  SizedBox(height: width * 0.0444),
                  Container(
                    width: width * 0.6,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: model.emailController,
                            cursorRadius: const Radius.circular(10),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              height: 1,
                            ),
                            onChanged: (value) {

                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 15),
                              border: InputBorder.none, // Loại bỏ viền
                              hintMaxLines: 1,
                              hintText: 'Your email address...',
                              labelStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                height: 1,
                              ),
                              hintStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.4),
                                height: 1,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black,
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "Subscribe",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: width * 0.04,),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

}
