import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';

class CustomButton extends StatefulWidget {
  final String? text;
  final IconData? icon;
  final Future<void> Function()? onPressed;
  final double? height;
  final double? width;
  final CustomSize size;
  final bool showShadow;
  final bool startWithHover;
  final bool centerButtonContent;
  final bool isAvailable;

  const CustomButton({
    super.key,
    this.text,
    this.icon,
    this.onPressed = _emptyAsyncFunction,
    this.height,
    this.width,
    required this.size,
    this.showShadow = true,
    this.startWithHover = false,
    this.centerButtonContent = false,
    this.isAvailable = true,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();

  static Future<void> _emptyAsyncFunction() async {}
}

class _CustomButtonState extends State<CustomButton> {
  bool isLoading = false;
  bool isHover = false;

  @override
  void initState() {
    super.initState();
    isHover = widget.startWithHover;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: !widget.isAvailable
          ? MouseCursor.defer
          : isLoading
              ? MouseCursor.defer
              : SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHover = !widget.startWithHover),
      onExit: (_) => setState(() => isHover = widget.startWithHover),
      child: GestureDetector(
        onTap: () async {
          if (isLoading || !widget.isAvailable) return;
          setState(() => isLoading = true);
          await widget.onPressed!();
          setState(() => isLoading = false);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: decorationButton(),
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: isLoading
                ? Center(child: customProgressIndicator())
                : contentButton(),
          ),
        ),
      ),
    );
  }

  Widget customProgressIndicator() {
    final double size = widget.size == CustomSize.h2
        ? 40
        : widget.size == CustomSize.h3
            ? 32
            : widget.size == CustomSize.h4
                ? 26
                : 22;
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
          color: isHover ? AppColors.white : AppColors.base),
    );
  }

  BoxDecoration decorationButton() {
    final color = !widget.isAvailable
        ? AppColors.grey200
        : isHover
            ? AppColors.base
            : AppColors.white;
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: color,
        width: 2,
      ),
      boxShadow: !widget.showShadow
          ? null
          : [
              BoxShadow(
                color: Colors.black.withOpacity(0.25), 
                offset: const Offset(0, 4),
                blurRadius: 4,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.25), 
                offset: const Offset(0, 0),
                blurRadius: 1,
              ),
            ],
    );
  }

  Widget contentButton() {
    final color = !widget.isAvailable
        ? AppColors.grey500
        : isHover
            ? AppColors.white
            : AppColors.base;
    final showIcon = widget.icon != null;
    final showText = widget.text != null;
    return Row(
      mainAxisAlignment: widget.centerButtonContent
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      mainAxisSize:
          MainAxisSize.min, 
      children: [
        if (showIcon) buttonContent(color),
        if (showIcon && showText) const SizedBox(width: 8),
        if (showText) textContent(color),
      ],
    );
  }

  Widget buttonContent(Color color) {
    final double iconSize = widget.size == CustomSize.h2
        ? 40
        : widget.size == CustomSize.h3
            ? 32
            : 22;
    return Icon(
      widget.icon,
      color: color,
      size: iconSize,
    );
  }

  Widget textContent(Color color) {
    final Widget textWidget = widget.size == CustomSize.h2
        ? H2(text: widget.text!, color: color)
        : widget.size == CustomSize.h3
            ? H3(text: widget.text!, color: color)
            : widget.size == CustomSize.h4
                ? H4(text: widget.text!, color: color)
                : H5(text: widget.text!, color: color);
    return textWidget;
  }
}
