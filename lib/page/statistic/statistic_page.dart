import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loto/page/statistic/app_color.dart';
import 'package:loto/page/statistic/statistic_controller.dart';
import 'package:loto/page/statistic/widget/indicator.dart';

class StatisticPage extends GetView<StatisticController> {
  const StatisticPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body:  Column(
        children: [
          const Text("Tong doanh thu: 21.000.000 dong"),
          const Text("Tong so luong ban ra: 300 cai"),
          const Text("Bieu dô thong ke:"),
          AspectRatio(
            aspectRatio: 1.3,
            child: Obx(() {
              return Column(
                children: <Widget>[
                  const SizedBox(
                    height: 28,
                  ),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Obx(() {
                        return PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback:
                                  (FlTouchEvent event, pieTouchResponse) {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  controller.touchedIndex.value = -1;
                                  return;
                                }
                                controller.touchedIndex.value = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              },
                            ),
                            startDegreeOffset: 180,
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 40,
                            sections: showingSections(),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Indicator(
                        color: AppColors.contentColorBlue,
                        text: 'Thâp cẩm',
                        isSquare: false,
                        size: controller.touchedIndex.value == 0 ? 18 : 16,
                        textColor: controller.touchedIndex.value == 0
                            ? AppColors.mainTextColor1
                            : AppColors.mainTextColor3,
                      ),
                      Indicator(
                        color: AppColors.contentColorYellow,
                        text: 'Hạt sen',
                        isSquare: false,
                        size: controller.touchedIndex.value == 1 ? 18 : 16,
                        textColor: controller.touchedIndex.value == 1
                            ? AppColors.mainTextColor1
                            : AppColors.mainTextColor3,
                      ),
                      Indicator(
                        color: AppColors.contentColorPink,
                        text: 'Khoai môn',
                        isSquare: false,
                        size: controller.touchedIndex.value == 2 ? 18 : 16,
                        textColor: controller.touchedIndex.value == 2
                            ? AppColors.mainTextColor1
                            : AppColors.mainTextColor3,
                      ),
                      Indicator(
                        color: AppColors.contentColorGreen,
                        text: 'Dau do',
                        isSquare: false,
                        size: controller.touchedIndex.value == 3 ? 18 : 16,
                        textColor: controller.touchedIndex.value == 3
                            ? AppColors.mainTextColor1
                            : AppColors.mainTextColor3,
                      ),
                      Indicator(
                        color: AppColors.contentColorGreen,
                        text: 'Sữa dưa',
                        isSquare: false,
                        size: controller.touchedIndex.value == 3 ? 18 : 16,
                        textColor: controller.touchedIndex.value == 3
                            ? AppColors.mainTextColor1
                            : AppColors.mainTextColor3,
                      ),
                      Indicator(
                        color: AppColors.contentColorGreen,
                        text: 'Dau xanh',
                        isSquare: false,
                        size: controller.touchedIndex.value == 3 ? 18 : 16,
                        textColor: controller.touchedIndex.value == 3
                            ? AppColors.mainTextColor1
                            : AppColors.mainTextColor3,
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == controller.touchedIndex.value;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.contentColorBlue,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.contentColorYellow,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: AppColors.contentColorPurple,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: AppColors.contentColorGreen,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
