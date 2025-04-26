import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_size_text.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';

class CustomInputWithLabel extends StatelessWidget {
  final CustomSize size;
  final String title;
  final String hintText;
  final String text;
  final double? width;
  final double? height;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final VoidCallback? onPressedRightIcon;
  final IconData? rightIcon;
  final IconData? leftIcon;
  final bool readOnly;
  final int lines;
  final bool allowOnlyNumbers;

  const CustomInputWithLabel({
    super.key,
    required this.size,
    required this.title,
    required this.hintText,
    required this.text,
    this.width,
    this.height,
    this.controller,
    this.onChanged,
    this.onPressedRightIcon,
    this.rightIcon,
    this.leftIcon,
    this.readOnly = false,
    this.lines = 1,
    this.allowOnlyNumbers = false,
  }) : assert(
          size == CustomSize.h2 ||
              size == CustomSize.h3 ||
              size == CustomSize.h5,
          'Invalid size value.',
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customTitle(),
          // customHeightSpace(),
          customInput(),
        ],
      ),
    );
  }

  Widget customTitle() {
    return size == CustomSize.h2
        ? H2(
            text: title,
            color: AppColors.grey200,
          )
        : size == CustomSize.h3
            ? H3(
                text: title,
                color: AppColors.grey200,
              )
            : H5(
                text: title,
                color: AppColors.grey200,
              );
  }

  Widget customHeightSpace() {
    return SizedBox(
        height: size == CustomSize.h2
            ? 10
            : size == CustomSize.h3
                ? 7
                : 5);
  }

  Widget customInput() {
    final double customSpace = size == CustomSize.h2
        ? 10
        : size == CustomSize.h3
            ? 7
            : 5;
    final double dimensionSize = size == CustomSize.h2
        ? AppSizeText.h2
        : size == CustomSize.h3
            ? AppSizeText.h3
            : AppSizeText.h5;
    const iconConstrain = BoxConstraints(
      minWidth: 0,
      minHeight: 0,
    );
    final rightIconWidget = Icon(
      rightIcon,
      color: AppColors.grey200,
      size: dimensionSize,
    );
    return TextField(
      controller: controller ?? TextEditingController(text: text),
      onChanged: onChanged,
      keyboardType: allowOnlyNumbers ? TextInputType.number : null,
      inputFormatters: allowOnlyNumbers
          ? [
              FilteringTextInputFormatter.digitsOnly,
            ]
          : null,
      maxLines: lines,
      minLines: lines,
      readOnly: readOnly,
      style: TextStyle(
        fontSize: dimensionSize,
        color: AppColors.black,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: dimensionSize,
          color: AppColors.grey200,
          fontWeight: FontWeight.w300,
        ),
        prefixIcon: leftIcon != null
            ? Padding(
                padding: EdgeInsets.only(
                  left: 5,
                  right: customSpace,
                ),
                child: Icon(
                  leftIcon,
                  color: AppColors.grey200,
                  size: dimensionSize,
                ),
              )
            : null,
        prefixIconConstraints: iconConstrain,
        suffixIcon: rightIcon != null
            ? Padding(
                padding: const EdgeInsets.only(right: 5),
                child: onPressedRightIcon == null
                    ? rightIconWidget
                    : IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: onPressedRightIcon,
                        icon: rightIconWidget,
                      ),
              )
            : null,
        suffixIconConstraints: iconConstrain,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: AppColors.grey200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: AppColors.grey200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: AppColors.base),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: dimensionSize * 0.3,
          horizontal: 5,
        ),
      ),
    );
  }
}
