import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loto/page/statistic/app_color.dart';
import 'package:loto/page/statistic/statistic_controller.dart';

class StatisticPage extends GetView<StatisticController> {
  const StatisticPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Title configuration',
              style: TextStyle(
                color: AppColors.mainTextColor2,
              ),
            ),
            Row(
              children: [
                const Text(
                  'Angle',
                  style: TextStyle(
                    color: AppColors.mainTextColor2,
                  ),
                ),
                Obx(() => Slider(
                    value: controller.angleValue.value,
                    max: 360,
                    onChanged: (double value) {
                      controller.angleValue.value = value;
                    }
                )),
                Obx(() => Checkbox(
                  value: controller.relativeAngleMode.value,
                  onChanged: (v) {
                    controller.relativeAngleMode.value = v!;
                  },
                )),
                const Text('Relative'),
              ],
            ),
            GestureDetector(
              onTap: () {
                controller.selectedDataSetIndex.value = -1;
              },
              child: Text(
                'Categories'.toUpperCase(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w300,
                  color: AppColors.mainTextColor1,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: controller.rawDataSets()
                  .asMap()
                  .map((index, value) {
                final isSelected = index == controller.selectedDataSetIndex.value;
                return MapEntry(
                  index,
                  GestureDetector(
                    onTap: () {
                      controller.selectedDataSetIndex.value = index;
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      height: 26,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.pageBackground
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(46),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 6,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInToLinear,
                            padding: EdgeInsets.all(isSelected ? 8 : 6),
                            decoration: BoxDecoration(
                              color: value.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInToLinear,
                            style: TextStyle(
                              color:
                              isSelected ? value.color : controller.gridColor,
                            ),
                            child: Text(value.title),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })
                  .values
                  .toList(),
            )),
            AspectRatio(
              aspectRatio: 1.3,
              child: RadarChart(
                RadarChartData(
                  radarTouchData: RadarTouchData(
                    touchCallback: (FlTouchEvent event, response) {
                      if (!event.isInterestedForInteractions) {
                        controller.selectedDataSetIndex.value = -1;
                        return;
                      }
                      controller.selectedDataSetIndex.value = response?.touchedSpot?.touchedDataSetIndex ?? -1;
                    },
                  ),
                  dataSets: controller.showingDataSets(),
                  radarBackgroundColor: Colors.transparent,
                  borderData: FlBorderData(show: false),
                  radarBorderData: const BorderSide(color: Colors.transparent),
                  titlePositionPercentageOffset: 0.2,
                  titleTextStyle:
                  TextStyle(color: controller.titleColor, fontSize: 14),
                  getTitle: (index, angle) {
                    final usedAngle = controller.relativeAngleMode.value ? angle + controller.angleValue.value : controller.angleValue.value;
                    switch (index) {
                      case 0:
                        return RadarChartTitle(
                          text: 'Mobile or Tablet',
                          angle: usedAngle,
                        );
                      case 2:
                        return RadarChartTitle(
                          text: 'Desktop',
                          angle: usedAngle,
                        );
                      case 1:
                        return RadarChartTitle(text: 'TV', angle: usedAngle);
                      default:
                        return const RadarChartTitle(text: '');
                    }
                  },
                  tickCount: 1,
                  ticksTextStyle:
                  const TextStyle(color: Colors.transparent, fontSize: 10),
                  tickBorderData: const BorderSide(color: Colors.transparent),
                  gridBorderData: BorderSide(color: controller.gridColor, width: 2),
                ),
                swapAnimationDuration: const Duration(milliseconds: 400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}