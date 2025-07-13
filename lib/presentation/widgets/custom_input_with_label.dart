import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/enums/input_type.dart';
import 'package:trauma_register_frontend/core/helpers/content_options.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_size_text.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';

class CustomInputWithLabel extends StatelessWidget {
  final CustomSize size;
  final String title;
  final String hintText;
  final String? text;
  final double? width;
  final double? height;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final VoidCallback? onPressedRightIcon;
  final void Function(String?)? onSubmitted;
  final IconData? rightIcon;
  final IconData? leftIcon;
  final bool readOnly;
  final int lines;
  final List<String>? suggestions;
  final InputType? inputType;
  final VoidCallback? onTap;

  const CustomInputWithLabel({
    super.key,
    required this.size,
    required this.title,
    required this.hintText,
    this.text,
    this.width,
    this.height,
    this.controller,
    this.onChanged,
    this.onPressedRightIcon,
    this.onSubmitted,
    this.rightIcon,
    this.leftIcon,
    required this.readOnly,
    this.lines = 1,
    this.suggestions,
    this.inputType = InputType.string,
    this.onTap,
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
          MouseRegion(
            cursor: onTap != null && !readOnly
                ? SystemMouseCursors.click
                : MouseCursor.defer,
            child: GestureDetector(
              onTap: !readOnly ? onTap : null,
              child: customTitle(),
            ),
          ),
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
    return readOnly || (inputType != InputType.boolean && suggestions == null)
        ? _CustomTextField(
            controller: controller,
            text: text,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            lines: lines,
            readOnly: readOnly,
            dimensionSize: dimensionSize,
            hintText: hintText,
            leftIcon: leftIcon,
            customSpace: customSpace,
            iconConstrain: iconConstrain,
            rightIcon: rightIcon,
            onPressedRightIcon: readOnly ? null : onPressedRightIcon ?? onTap,
            rightIconWidget: rightIconWidget,
            inputType: inputType,
          )
        : _AutoCompleteWidget(
            suggestions: suggestions,
            controller: controller,
            onChanged: onChanged,
            width: width,
            text: text,
            onSubmitted: onSubmitted,
            lines: lines,
            hintText: hintText,
            leftIcon: leftIcon,
            rightIcon: rightIcon,
            onPressedRightIcon: readOnly ? null : onPressedRightIcon ?? onTap,
            dimensionSize: dimensionSize,
            customSpace: customSpace,
            iconConstrain: iconConstrain,
            rightIconWidget: rightIconWidget,
            inputType: inputType,
          );
  }
}

class _AutoCompleteWidget extends StatelessWidget {
  const _AutoCompleteWidget({
    required this.suggestions,
    required this.controller,
    required this.onChanged,
    required this.width,
    required this.text,
    required this.onSubmitted,
    required this.lines,
    required this.hintText,
    required this.leftIcon,
    required this.rightIcon,
    required this.onPressedRightIcon,
    required this.inputType,
    required this.dimensionSize,
    required this.customSpace,
    required this.iconConstrain,
    required this.rightIconWidget,
  });

  final List<String>? suggestions;
  final TextEditingController? controller;
  final void Function(String p1)? onChanged;
  final double? width;
  final String? text;
  final void Function(String? p1)? onSubmitted;
  final int lines;
  final String hintText;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final VoidCallback? onPressedRightIcon;
  final InputType? inputType;
  final double dimensionSize;
  final double customSpace;
  final BoxConstraints iconConstrain;
  final Icon rightIconWidget;

  @override
  Widget build(BuildContext context) {
    final List<String>? establishedSuggestions = suggestions ??
        (inputType == InputType.boolean ? ContentOptions.booleanValues : null);
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (establishedSuggestions?.isEmpty ?? true) {
          return const Iterable<String>.empty();
        } else if (textEditingValue.text.isEmpty) {
          return establishedSuggestions!;
        }
        return establishedSuggestions!.where((String option) {
          return option
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        if (controller != null) {
          controller!.text = selection;
        }
        if (onChanged != null) {
          onChanged!(selection);
        }
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: SizedBox(
              width: width,
              height: 175,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: options.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final option = options.elementAt(index);
                  return ListTile(
                    title: H6(
                      text: option,
                      color: AppColors.black,
                    ),
                    onTap: () => onSelected(option),
                  );
                },
              ),
            ),
          ),
        );
      },
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController textEditingController,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted,
      ) {
        textEditingController.text = text ?? '';
        return _CustomTextField(
          focusNode: focusNode,
          controller: textEditingController,
          text: text,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          lines: lines,
          readOnly: false,
          dimensionSize: dimensionSize,
          hintText: hintText,
          leftIcon: leftIcon,
          customSpace: customSpace,
          iconConstrain: iconConstrain,
          rightIcon: rightIcon,
          onPressedRightIcon: onPressedRightIcon,
          rightIconWidget: rightIconWidget,
          inputType: inputType,
        );
      },
    );
  }
}

class _CustomTextField extends StatelessWidget {
  const _CustomTextField({
    this.focusNode,
    this.controller,
    required this.text,
    required this.onChanged,
    required this.onSubmitted,
    required this.lines,
    required this.readOnly,
    required this.dimensionSize,
    required this.hintText,
    required this.leftIcon,
    required this.customSpace,
    required this.iconConstrain,
    required this.rightIcon,
    required this.onPressedRightIcon,
    required this.rightIconWidget,
    required this.inputType,
  });

  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? text;
  final void Function(String p1)? onChanged;
  final void Function(String? p1)? onSubmitted;
  final int lines;
  final bool readOnly;
  final double dimensionSize;
  final String hintText;
  final IconData? leftIcon;
  final double customSpace;
  final BoxConstraints iconConstrain;
  final IconData? rightIcon;
  final VoidCallback? onPressedRightIcon;
  final Icon rightIconWidget;
  final InputType? inputType;

  @override
  Widget build(BuildContext context) {
    TextInputType? keyboardType;
    List<TextInputFormatter>? inputFormatters;

    if (inputType == InputType.string) {
      keyboardType = TextInputType.text;
      inputFormatters = null;
    } else if (inputType == InputType.integer) {
      keyboardType = TextInputType.number;
      inputFormatters = [FilteringTextInputFormatter.digitsOnly];
    } else if (inputType == InputType.double) {
      keyboardType = const TextInputType.numberWithOptions(decimal: true);
      inputFormatters = [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
      ];
    } else if (inputType == InputType.boolean) {
      keyboardType = TextInputType.text;
      inputFormatters = [
        FilteringTextInputFormatter.allow(
          RegExp(r'[sniío]', caseSensitive: false),
        ),
        LengthLimitingTextInputFormatter(2),
      ];
    } else if (inputType == InputType.date) {
      keyboardType = TextInputType.datetime;
      inputFormatters = [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
        LengthLimitingTextInputFormatter(10),
      ];
    } else if (inputType == InputType.time) {
      keyboardType = TextInputType.datetime;
      inputFormatters = [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9:]')),
        LengthLimitingTextInputFormatter(8),
      ];
    } else if (inputType == InputType.datetime) {
      keyboardType = TextInputType.datetime;
      inputFormatters = [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9/: ]')),
        LengthLimitingTextInputFormatter(19),
      ];
    }
    return TextField(
      focusNode: focusNode,
      controller: controller ?? TextEditingController(text: text),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
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
