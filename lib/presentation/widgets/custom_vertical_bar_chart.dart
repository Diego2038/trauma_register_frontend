import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/data/models/stats/categorical_stats.dart';

class CustomVerticalBarChart extends StatelessWidget {
  final double? chartWidth;
  final double? chartHeight;
  final List<Datum> data;

  const CustomVerticalBarChart({
    super.key,
    required this.data,
    this.chartWidth,
    this.chartHeight,
  });

  @override
  Widget build(BuildContext context) {
    final maxY = data.map((d) => d.total).reduce((a, b) => a > b ? a : b);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: chartWidth,
          height: chartHeight,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: maxY + (maxY * 0.2),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (double value, _) {
                      final index = value.toInt();
                      if (index < 0 || index >= data.length) {
                        return const SizedBox.shrink();
                      }
                      return SideTitleWidget(
                        axisSide: AxisSide.bottom,
                        child: Text(
                          data[index].tag,
                          style: const TextStyle(fontSize: 10),
                        ),
                      );
                    },
                    reservedSize: 40,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text(
                          value.toInt().toString(),
                          style: const TextStyle(fontSize: 10),
                        ),
                      );
                    },
                  ),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
              ),
              barGroups: data.asMap().entries.map((entry) {
                final index = entry.key;
                final datum = entry.value;
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: datum.total,
                      color: _getColorForTag(index),
                      width: 16,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                );
              }).toList(),
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipColor: (_) => AppColors.base,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      rod.toY.toStringAsFixed(0),
                      const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
                handleBuiltInTouches: true,
              ),
            ),
          ),
        ),
        // const SizedBox(width: 20),
        // // Leyenda
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: data.asMap().entries.map((entry) {
        //     final index = entry.key;
        //     final value = entry.value;
        //     return Padding(
        //       padding: const EdgeInsets.symmetric(vertical: 2),
        //       child: Row(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           Container(
        //             decoration: BoxDecoration(
        //               color: _getColorForTag(index),
        //               border: Border.all(color: AppColors.white),
        //               borderRadius: const BorderRadius.all(
        //                 Radius.circular(20),
        //               ),
        //             ),
        //             width: 16,
        //             height: 16,
        //           ),
        //           const SizedBox(width: 8),
        //           HeaderText(text: value.tag),
        //         ],
        //       ),
        //     );
        //   }).toList(),
        // ),
      ],
    );
  }

  Color _getColorForTag(int index) {
    switch (index) {
      case 0:
        return AppColors.firstGraphicsColor;
      case 1:
        return AppColors.secondaryGraphicsColor;
      case 2:
        return AppColors.thirdGraphicsColor;
      case 3:
        return AppColors.fourthGraphicsColor;
      case 4:
        return AppColors.fifthGraphicsColor;
      case 5:
        return AppColors.sixthGraphicsColor;
      case 6:
        return AppColors.seventhGraphicsColor;
      case 7:
        return AppColors.eighthGraphicsColor;
      case 8:
        return AppColors.ninthGraphicsColor;
      case 9:
        return AppColors.tenthGraphicsColor;
      case 10:
        return AppColors.eleventhGraphicsColor;
      case 11:
        return AppColors.twelfthGraphicsColor;
      case 12:
        return AppColors.thirteenthGraphicsColor;
      case 13:
        return AppColors.fourteenthGraphicsColor;
      case 14:
        return AppColors.fifteenthGraphicsColor;
      case 15:
        return AppColors.sixteenthGraphicsColor;
      default:
        return AppColors.white;
    }
  }
}
