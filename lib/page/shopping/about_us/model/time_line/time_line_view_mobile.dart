import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/about_us/entity/story_line_res.dart';
import 'package:loto/page/shopping/about_us/model/time_line/time_line_model.dart';

class TimeLineViewMobile extends StatelessWidget {
  final TimeLineModel model;
  const TimeLineViewMobile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(
        top: 40,
      ),
      child: Obx(() {
        if (model.listTimeLine.isEmpty) {
          return const SizedBox();
        }
        return ListView.separated(
          itemCount: model.listTimeLine.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (c, i) {
            var data = model.listTimeLine[i];
            return _buildTheRight(data, isLeft: i % 2 == 0);
          },
          separatorBuilder: (c, i){
            return SizedBox(height: (35 / 375) * width);
          },
        );
      }),
    );
  }

  Widget _buildTheRight(StoryLineRes data, {required bool isLeft}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF8E25).withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isLeft ? _timeLineLeft("${data.timeline}") : _timeLineRight("${data.timeline}"),
          const SizedBox(height: 20),
          Text(
            "${data.storyName}",
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: Color(0xFF333333),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Html(
            data: "${data.storyDetail}",
            style: {
              "p": Style(
                fontSize: FontSize(15),
                color: const Color(0xFF666666),
                fontWeight: FontWeight.w400,
                lineHeight: LineHeight(1.6),
              )
            },
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 625 / 340,
              child: Image.network(
                data.storyImage ?? "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Fabout%2Fstory.webp?alt=media&token=ba3b172e-bc50-46e3-824c-84a87037e2c4",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFF5F5F5),
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                      color: Color(0xFFCCCCCC),
                      size: 40,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _timeLineLeft(String time) {
    return Row(
      children: [
        Container(
          height: 4,
          width: 50,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF8E25), Color(0xFFFFB067)],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 15),
        Text(
          time,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 28,
            color: Color(0xFFFF8E25),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFFF8E25).withOpacity(0.8),
                  const Color(0xFFFF8E25).withOpacity(0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _timeLineRight(String time) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFFF8E25).withOpacity(0.3),
                  const Color(0xFFFF8E25).withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Text(
          time,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 28,
            color: Color(0xFFFF8E25),
          ),
        ),
        const SizedBox(width: 15),
        Container(
          height: 4,
          width: 50,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFB067), Color(0xFFFF8E25)],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}
