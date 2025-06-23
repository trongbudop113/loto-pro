import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:loto/common/common.dart';
import 'package:loto/page/statistic/statistic_controller.dart';
import 'package:loto/page/statistic/app_color.dart';
import 'package:loto/page/statistic/widget/indicator.dart';
import 'package:loto/src/color_resource.dart';
import 'package:loto/src/style_resource.dart';

class StatisticPage extends GetView<StatisticController> {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Load data when page is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadOrderStatistics();
    });
    return Scaffold(
      backgroundColor: ColorResource.color_background_light,
      appBar: AppBar(
        title: Text(
          'Thống kê bán hàng',
          style: TextStyleResource.textStyleWhite(context).copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorResource.color_main_light,
        elevation: 2,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              // Statistics Cards
              Container(
                margin: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildStatisticsCards(context),
                    const SizedBox(height: 24),
                    _buildChartSection(context),
                    const SizedBox(height: 24),
                    _buildMonthlyBarChart(context),
                  ],
                ),
              ),
              // Top Products List
              _buildTopProductsList(context),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStatisticsCards(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            'Tổng doanh thu',
            AppCommon.singleton.formatCurrency(double.parse(controller.totalRevenue.toStringAsFixed(0)), unit: 'VNĐ'),
            Icons.attach_money,
            Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            context,
            'Sản phẩm bán',
            '${controller.totalProductsSold}',
            Icons.shopping_bag,
            Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            context,
            'Đơn hàng',
            '${controller.totalOrders}',
            Icons.receipt_long,
            Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyleResource.textStyleGrey(context).copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyleResource.textStyleBlack(context).copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Biểu đồ sản phẩm bán chạy',
            style: TextStyleResource.textStyleBlack(context).copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 350,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
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
                          borderData: FlBorderData(show: false),
                          sectionsSpace: 2,
                          centerSpaceRadius: 50,
                          sections: showingSections(),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: controller
                        .getTopSellingProducts(limit: 5)
                        .asMap()
                        .entries
                        .map((entry) {
                      int index = entry.key;
                      var product = entry.value;
                      List<Color> colors = [
                        AppColors.contentColorBlue,
                        AppColors.contentColorYellow,
                        AppColors.contentColorPink,
                        AppColors.contentColorGreen,
                        AppColors.contentColorRed,
                      ];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Indicator(
                          color: colors[index % colors.length],
                          text: product.key,
                          isSquare: false,
                          size:
                              controller.touchedIndex.value == index ? 18 : 16,
                          textColor: controller.touchedIndex.value == index
                              ? Colors.black
                              : Colors.grey,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopProductsList(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top sản phẩm bán chạy',
            style: TextStyleResource.textStyleBlack(context).copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.getTopSellingProducts(limit: 10).length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              var product = controller.getTopSellingProducts(limit: 10)[index];
              var revenue = controller.revenueStatistics[product.key] ?? 0;

              return Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: ColorResource.color_main_light,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyleResource.textStyleWhite(context)
                              .copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.key,
                            style: TextStyleResource.textStyleBlack(context)
                                .copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Số lượng: ${product.value} • Doanh thu: ${AppCommon.singleton.formatCurrency(double.parse(revenue.toStringAsFixed(0)), unit: 'VNĐ')}',
                            style: TextStyleResource.textStyleGrey(context),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: ColorResource.color_background_light,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '${((product.value / controller.totalProductsSold) * 100).toStringAsFixed(1)}%',
                        style:
                            TextStyleResource.textStyleBlack(context).copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyBarChart(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thống kê đơn hàng theo tháng',
            style: TextStyleResource.textStyleBlack(context).copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 300,
            child: Obx(() {
              final monthlyData = controller.getMonthlyOrderStatistics();
              
              if (monthlyData.isEmpty) {
                return Center(
                  child: Text(
                    'Chưa có dữ liệu theo tháng',
                    style: TextStyleResource.textStyleGrey(context),
                  ),
                );
              }

              return BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: monthlyData.map((e) => e.value.toDouble()).reduce((a, b) => a > b ? a : b) * 1.2,
                  barTouchData: BarTouchData(
                     enabled: true,
                     touchTooltipData: BarTouchTooltipData(
                       getTooltipColor: (group) => Colors.blueGrey,
                       getTooltipItem: (group, groupIndex, rod, rodIndex) {
                         final monthKey = monthlyData[group.x.toInt()].key;
                         final orderCount = monthlyData[group.x.toInt()].value;
                         return BarTooltipItem(
                           '${controller.getFormattedMonthName(monthKey)}\n$orderCount đơn hàng',
                           const TextStyle(color: Colors.white),
                         );
                       },
                     ),
                   ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          if (value.toInt() >= 0 && value.toInt() < monthlyData.length) {
                            final monthKey = monthlyData[value.toInt()].key;
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                controller.getFormattedMonthName(monthKey),
                                style: TextStyleResource.textStyleGrey(context).copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }
                          return const Text('');
                        },
                        reservedSize: 40,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text(
                            value.toInt().toString(),
                            style: TextStyleResource.textStyleGrey(context).copyWith(
                              fontSize: 12,
                            ),
                          );
                        },
                        reservedSize: 40,
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  barGroups: monthlyData.asMap().entries.map((entry) {
                    final index = entry.key;
                    final data = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: data.value.toDouble(),
                          color: ColorResource.color_main_light,
                          width: 20,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    drawVerticalLine: false,
                    horizontalInterval: 1,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.3),
                        strokeWidth: 1,
                      );
                    },
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    var topProducts = controller.getTopSellingProducts(limit: 5);

    if (topProducts.isEmpty) {
      return [
        PieChartSectionData(
          color: Colors.grey,
          value: 100,
          title: 'Chưa có dữ liệu',
          radius: 50,
          titleStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ];
    }

    List<Color> colors = [
      AppColors.contentColorBlue,
      AppColors.contentColorYellow,
      AppColors.contentColorPink,
      AppColors.contentColorGreen,
      AppColors.contentColorRed,
    ];

    return topProducts.asMap().entries.map((entry) {
      int index = entry.key;
      var product = entry.value;
      final isTouched = index == controller.touchedIndex.value;
      final fontSize = isTouched ? 20.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      double percentage = (product.value / controller.totalProductsSold) * 100;

      return PieChartSectionData(
        color: colors[index % colors.length],
        value: product.value.toDouble(),
        title: '${percentage.toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: AppColors.mainTextColor1,
          shadows: shadows,
        ),
      );
    }).toList();
  }
}
