import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';

class TextBlock extends StatelessWidget {
  final String title;
  final String text;
  final CustomSize size;

  const TextBlock({
    super.key,
    required this.title,
    required this.text,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          customTitle(title: title, size: size),
          const SizedBox(height: 0),
          customText(text: text, size: size),
        ],
      ),
    );
  }

  Widget customTitle({required String title, required CustomSize size}) {
    return size == CustomSize.h2
        ? H2(
            text: title,
            color: AppColors.grey300,
          )
        : size == CustomSize.h3
            ? H3(
                text: title,
                color: AppColors.grey300,
              )
            : H5(
                text: title,
                color: AppColors.grey300,
              );
  }

  Widget customText({required String text, required CustomSize size}) {
    return size == CustomSize.h2
        ? H2(
            text: text,
            fontWeight: FontWeight.w300,
          )
        : size == CustomSize.h3
            ? H3(
                text: text,
                fontWeight: FontWeight.w300,
              )
            : H5(
                text: text,
                fontWeight: FontWeight.w300,
              );
  }
}
