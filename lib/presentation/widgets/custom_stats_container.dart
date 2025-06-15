import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';

class CustomStatsContainer extends StatelessWidget {
  final String title;
  final Widget child;
  final double? maxWidth;
  final double? maxHeight;
  final double? minWidth;
  final double? minHeight;
  const CustomStatsContainer({
    super.key,
    required this.title,
    required this.child,
    this.maxWidth,
    this.maxHeight,
    this.minHeight,
    this.minWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      constraints: BoxConstraints(
        maxHeight: maxHeight ?? double.infinity,
        maxWidth: maxWidth ?? double.infinity,
        minHeight: minHeight ?? 0,
        minWidth: minWidth ?? 0,
      ),
      decoration: BoxDecoration(
        color: AppColors.base50,
        border: Border.all(
          color: AppColors.black,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          H3(text: title),
          child,
        ],
      ),
    );
  }
}
