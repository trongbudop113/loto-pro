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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(
          width: 625,
          height: 340,
          "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Fabout%2Fstory.webp?alt=media&token=ba3b172e-bc50-46e3-824c-84a87037e2c4",
        ),
        Container(
          width: 4,
          height: 500,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          color: const Color(0xFFFF7500).withOpacity(0.8),
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 25,
                  ),
                  Container(
                    height: 4,
                    width: 52,
                    color: const Color(0xFFFF7500).withOpacity(0.8),
                  ),
                  const SizedBox(
                    width: 36,
                  ),
                  Text(
                    "${data.timeline}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                  const SizedBox(
                    width: 48,
                  ),
                  Expanded(
                    child: Text(
                      "${data.storyName}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  )
                ],
              ),
              Html(
                data: "${data.storyDetail}",
                style: {
                  "p": Style(
                    fontSize: FontSize(20),
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  )
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTheRight(StoryLineRes data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                "${data.storyName}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              Html(
                data: "${data.storyDetail}",
                style: {
                  "p": Style(
                    fontSize: FontSize(20),
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  )
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 48,
        ),
        Text(
          "${data.timeline}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 36,
          ),
        ),
        const SizedBox(
          width: 36,
        ),
        Container(
          height: 4,
          width: 52,
          color: const Color(0xFFFF7500).withOpacity(0.8),
        ),
        const SizedBox(
          width: 25,
        ),
        Container(
          width: 4,
          height: 500,
          margin: const EdgeInsets.symmetric(horizontal: 28),
          color: const Color(0xFFFF7500).withOpacity(0.8),
        ),
        Image.network(
          width: 625,
          height: 340,
          "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Fabout%2Fstory.webp?alt=media&token=ba3b172e-bc50-46e3-824c-84a87037e2c4",
        ),
      ],
    );
  }
}
