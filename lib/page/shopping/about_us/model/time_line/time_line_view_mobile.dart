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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isLeft ? _timeLineLeft("${data.timeline}") : _timeLineRight("${data.timeline}"),
        const SizedBox(height: 15),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "${data.storyName}",
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
            ),
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
        AspectRatio(
          aspectRatio: 625 / 340,
          child: Image.network(
            "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Fabout%2Fstory.webp?alt=media&token=ba3b172e-bc50-46e3-824c-84a87037e2c4",
          ),
        ),
      ],
    );
  }

  Widget _timeLineLeft(String time){
    return Row(
      children: [
        Container(
          height: 4,
          width: 50,
          color: const Color(0xFFFF7500).withOpacity(0.8),
        ),
        const SizedBox(width: 15),
        Text(
          time,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 36,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Container(
            height: 4,
            color: const Color(0xFFFF7500).withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _timeLineRight(String time){
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 4,
            color: const Color(0xFFFF7500).withOpacity(0.8),
          ),
        ),
        const SizedBox(width: 15),
        Text(
          time,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 36,
          ),
        ),
        const SizedBox(width: 15),
        Container(
          height: 4,
          width: 50,
          color: const Color(0xFFFF7500).withOpacity(0.8),
        ),
      ],
    );
  }
}
