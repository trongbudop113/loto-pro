import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/about_us/entity/story_line_res.dart';
import 'package:loto/page/shopping/about_us/model/time_line/time_line_model.dart';

class TimeLineView extends StatelessWidget {
  final TimeLineModel model;
  const TimeLineView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64).copyWith(
        top: 60,
      ),
      child: Obx(() {
        if (model.listTimeLine.isEmpty) {
          return const SizedBox();
        }
        return ListView.builder(
          itemCount: model.listTimeLine.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (c, i) {
            var data = model.listTimeLine[i];
            if (i % 2 == 0) {
              return _buildTheLeft(data);
            }
            return _buildTheRight(data);
          },
        );
      }),
    );
  }

  Widget _buildTheLeft(StoryLineRes data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 625,
              height: 340,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF8E25).withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Image.network(
                data.storyImage ?? "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Fabout%2Fstory.webp?alt=media&token=ba3b172e-bc50-46e3-824c-84a87037e2c4",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: 4,
            height: 500,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFFFF8E25),
                  const Color(0xFFFF8E25).withOpacity(0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 4,
                      width: 52,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF8E25), Color(0xFFFFB067)],
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 36),
                    Text(
                      "${data.timeline}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 36,
                        color: Color(0xFFFF8E25),
                      ),
                    ),
                    const SizedBox(width: 48),
                    Expanded(
                      child: Text(
                        "${data.storyName}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 40,
                          color: Color(0xFF333333),
                          height: 1.2,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 24),
                Html(
                  data: "${data.storyDetail}",
                  style: {
                    "p": Style(
                      fontSize: FontSize(20),
                      color: const Color(0xFF666666),
                      fontWeight: FontWeight.w400,
                      lineHeight: LineHeight(1.6),
                    )
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTheRight(StoryLineRes data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${data.storyName}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 40,
                    color: Color(0xFF333333),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 24),
                Html(
                  data: "${data.storyDetail}",
                  style: {
                    "p": Style(
                      fontSize: FontSize(20),
                      color: const Color(0xFF666666),
                      fontWeight: FontWeight.w400,
                      lineHeight: LineHeight(1.6),
                      textAlign: TextAlign.right,
                    )
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 48),
          Text(
            "${data.timeline}",
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 36,
              color: Color(0xFFFF8E25),
            ),
          ),
          const SizedBox(width: 36),
          Container(
            height: 4,
            width: 52,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFB067), Color(0xFFFF8E25)],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Container(
            width: 4,
            height: 500,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFFFF8E25),
                  const Color(0xFFFF8E25).withOpacity(0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 625,
              height: 340,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF8E25).withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Image.network(
                data.storyImage ?? "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Fabout%2Fstory.webp?alt=media&token=ba3b172e-bc50-46e3-824c-84a87037e2c4",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
