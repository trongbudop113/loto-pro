import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:loto/page/statistic/app_color.dart';
import 'package:loto/page/statistic/models/raw_data.dart';

class StatisticBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => StatisticController());
  }
}

class StatisticController extends GetxController {

  final gridColor = AppColors.contentColorPurple;
  final titleColor = AppColors.contentColorPurple;
  final fashionColor = AppColors.contentColorRed;
  final artColor = AppColors.contentColorCyan;
  final boxingColor = AppColors.contentColorGreen;
  final entertainmentColor = AppColors.contentColorWhite;
  final offRoadColor = AppColors.contentColorYellow;

  RxInt selectedDataSetIndex = (-1).obs;
  RxDouble angleValue = 0.0.obs;
  RxBool relativeAngleMode = true.obs;

  List<RawDataSet> rawDataSets() {
    return [
      RawDataSet(
        title: 'Fashion',
        color: fashionColor,
        values: [
          300,
          50,
          250,
        ],
      ),
      RawDataSet(
        title: 'Art & Tech',
        color: artColor,
        values: [
          250,
          100,
          200,
        ],
      ),
      RawDataSet(
        title: 'Entertainment',
        color: entertainmentColor,
        values: [
          200,
          150,
          50,
        ],
      ),
      RawDataSet(
        title: 'Off-road Vehicle',
        color: offRoadColor,
        values: [
          150,
          200,
          150,
        ],
      ),
      RawDataSet(
        title: 'Boxing',
        color: boxingColor,
        values: [
          100,
          250,
          100,
        ],
      ),
    ];
  }

  List<RadarDataSet> showingDataSets() {
    return rawDataSets().asMap().entries.map((entry) {
      final index = entry.key;
      final rawDataSet = entry.value;

      final isSelected = index == selectedDataSetIndex
          ? true
          : selectedDataSetIndex == -1
          ? true
          : false;

      return RadarDataSet(
        fillColor: isSelected
            ? rawDataSet.color.withOpacity(0.2)
            : rawDataSet.color.withOpacity(0.05),
        borderColor:
        isSelected ? rawDataSet.color : rawDataSet.color.withOpacity(0.25),
        entryRadius: isSelected ? 3 : 2,
        dataEntries:
        rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
        borderWidth: isSelected ? 2.3 : 2,
      );
    }).toList();
  }
}