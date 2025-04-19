import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';

class ExpandableTitleWidget extends StatefulWidget {
  final String title;
  final Widget expandedWidget;

  const ExpandableTitleWidget({
    super.key,
    required this.title,
    required this.expandedWidget,
  });

  @override
  State<ExpandableTitleWidget> createState() => _ExpandableTitleWidgetState();
}

class _ExpandableTitleWidgetState extends State<ExpandableTitleWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.base,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(
                  _isExpanded ? Icons.remove : Icons.add, 
                  color: AppColors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 8),
              H3(text: widget.title, color: AppColors.base),
            ],
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox(), 
          secondChild: widget.expandedWidget, 
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration:
              const Duration(milliseconds: 300), 
        ),
      ],
    );
  }
}
