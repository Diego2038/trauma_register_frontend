import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/stats/categorical_stats.dart';

class CustomPieChart extends StatelessWidget {
  final double? chartWidth;
  final double? chartHeight;
  final List<Datum> data;

  const CustomPieChart({
    super.key,
    required this.data,
    this.chartHeight,
    this.chartWidth,
  });

  @override
  Widget build(BuildContext context) {
    final total = data.fold<double>(0, (sum, item) => sum + item.total);

    final List<PieChartSectionData> showingSections =
        data.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;
      final percentage = (data.total / total) * 100;
      const fontSize = 16.0;
      const radius = 100.0;
      return PieChartSectionData(
        color: _getColorForTag(index),
        // value: data.total,
        // title: '${percentage.toStringAsFixed(1)}%',
        value: data.total,
        title: '${data.total.toInt()}\n${percentage.toStringAsFixed(1)}%',
        radius: radius,
        // badgeWidget: Text("Prueba"),
        // badgePositionPercentageOffset: 0.65,
        titleStyle: const TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: chartWidth,
          height: chartHeight,
          child: PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 40,
              sections: showingSections,
            ),
          ),
        ),
        const SizedBox(width: 20),
        // Leyenda
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: data.asMap().entries.map((entry) {
            final index = entry.key;
            final value = entry.value;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: _getColorForTag(index),
                      border: Border.all(color: AppColors.white),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(width: 8),
                  HeaderText(text: value.tag),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Función para asignar colores basados en la etiqueta de género
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
