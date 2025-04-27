import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';

class CustomCheckbox extends StatefulWidget {
  final CustomSize size;
  final String text;
  final bool initialValue;
  final Function(bool) onChanged;
  final double minWidthToCollapse;

  const CustomCheckbox({
    super.key,
    required this.size,
    required this.text,
    this.initialValue = false,
    required this.onChanged,
    required this.minWidthToCollapse,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool checkboxValue = false;

  @override
  void initState() {
    super.initState();
    checkboxValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: customCheckbox(size: widget.size),
        ),
        spaceWidth(size: widget.size),
        Expanded(
          flex: size.width > widget.minWidthToCollapse ? 0 : 1,
          child: customText(
            text: widget.text,
            size: widget.size,
          ),
        ),
      ],
    );
  }

  Widget customCheckbox({required CustomSize size}) {
    final double radious = size == CustomSize.h1
        ? 30
        : size == CustomSize.h2
            ? 25
            : size == CustomSize.h3
                ? 21
                : 16;
    return Padding(
      padding: EdgeInsets.all(radious * 0.1),
      child: Transform.scale(
        scale: radious / 18,
        child: SizedBox(
          width: radious,
          child: Checkbox(
              value: checkboxValue,
              splashRadius: 15,
              // fillColor: WidgetStateProperty.all(AppColors.base),
              fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.base;
                }
                return Colors.transparent;
              }),
              side: const BorderSide(color: AppColors.base, width: 2),
              onChanged: (bool? value) {
                setState(() {
                  checkboxValue = value!;
                });
                widget.onChanged(value!);
              }),
        ),
      ),
    );
  }

  Widget spaceWidth({required CustomSize size}) {
    return size == CustomSize.h1
        ? const SizedBox(width: 10)
        : size == CustomSize.h2
            ? const SizedBox(width: 7)
            : size == CustomSize.h3
                ? const SizedBox(width: 5)
                : const SizedBox(width: 3);
  }

  Widget customText({required String text, required CustomSize size}) {
    return size == CustomSize.h1
        ? H1(
            text: text,
          )
        : size == CustomSize.h2
            ? H2(
                text: text,
              )
            : size == CustomSize.h3
                ? H3(
                    text: text,
                  )
                : H5(
                    text: text,
                  );
  }
}
