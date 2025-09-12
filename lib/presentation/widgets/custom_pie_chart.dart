import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:trauma_register_frontend/core/helpers/interpolate.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/stats/categorical_stats.dart';

class CustomPieChart extends StatefulWidget {
  final double? chartWidth;
  final double? chartHeight;
  final List<Datum> data;
  final bool allowBadge;

  const CustomPieChart({
    super.key,
    required this.data,
    this.chartHeight,
    this.chartWidth,
    this.allowBadge = false,
  });

  @override
  State<CustomPieChart> createState() => _CustomPieChartState();
}

class _CustomPieChartState extends State<CustomPieChart> {
  int? _touchedIndex;

  @override
  Widget build(BuildContext context) {
    final total = widget.data.fold<double>(0, (sum, item) => sum + item.total);
    final double width = MediaQuery.of(context).size.width;
    final bool isMobileView = width < 800;

    final List<PieChartSectionData> showingSections =
        widget.data.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;
      final percentage = (data.total / total) * 100;
      const fontSize = 16.0;
      final isTouched = index == _touchedIndex;
      final radius = Interpolate.interpolate(
        xMin: isMobileView ? 400 : 800,
        xMax: isMobileView ? 600 : 1000,
        yMin: isTouched ? 20 : 10,
        yMax: isTouched ? 100 : 90,
        x: width,
      );
      final double badgePositionPercentageOffset = Interpolate.interpolate(
        xMin: isMobileView ? 400 : 800,
        xMax: isMobileView ? 600 : 1000,
        yMin: 2.25,
        yMax: 1.3,
        x: width,
      );

      return PieChartSectionData(
        color: _getColorForTag(index),
        value: data.total,
        showTitle: !widget.allowBadge,
        title: widget.allowBadge
            ? null
            : isTouched
                ? '${data.total.toInt()}\n${percentage.toStringAsFixed(1)}%'
                : null,
        // titlePositionPercentageOffset: 0.4,
        radius: radius,
        badgeWidget: !widget.allowBadge
            ? null
            : isTouched
                ? H6(
                    text:
                        '${data.total.toInt()}\n${percentage.toStringAsFixed(1)}%',
                    color: AppColors.base,
                    fontWeight: FontWeight.bold,
                  )
                : null,
        badgePositionPercentageOffset:
            !widget.allowBadge ? null : badgePositionPercentageOffset,
        titleStyle: const TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
      );
    }).toList();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: widget.chartWidth,
          height: widget.chartHeight,
          child: PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 40,
              sections: showingSections,
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      _touchedIndex = null;
                      return;
                    }
                    _touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        // Leyenda
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.data.asMap().entries.map((entry) {
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
