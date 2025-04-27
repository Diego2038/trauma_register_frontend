import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';

class CustomContainer extends StatelessWidget {
  final List<Widget> children;
  final double? maxWidth;
  const CustomContainer({
    super.key,
    required this.children,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
      decoration: BoxDecoration(
        color: AppColors.base50,
        border: Border.all(
          color: AppColors.black,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Wrap(
        runAlignment: WrapAlignment.end,
        runSpacing: 20,
        spacing: 20,
        children: children,
      ),
    );
  }
}
