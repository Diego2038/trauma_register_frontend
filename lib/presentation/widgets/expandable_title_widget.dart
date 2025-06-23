import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/presentation/providers/expandable_title_provider.dart';

class ExpandableTitleWidget extends StatelessWidget {
  final String title;
  final Widget expandedWidget;
  final int index;

  const ExpandableTitleWidget({
    super.key,
    required this.title,
    required this.expandedWidget,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final expandableTitleProvider =
        Provider.of<ExpandableTitleProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            expandableTitleProvider
                .toggleExpansion(index); // Alternar estado de expansión
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.base,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Consumer<ExpandableTitleProvider>(
                    builder: (context, expandableTitleProvider, _) => Icon(
                      expandableTitleProvider.getExpansionState(index)
                          ? Icons.remove
                          : Icons.add,
                      color: AppColors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: H3(
                  text: title,
                  color: AppColors.base,
                  maxLines: 5,
                ),
              ),
            ],
          ),
        ),
        Consumer<ExpandableTitleProvider>(
          builder: (context, expandableTitleProvider, child) => AnimatedCrossFade(
            firstChild: const SizedBox(),
            secondChild: child!,
            crossFadeState: expandableTitleProvider.getExpansionState(index)
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
          child: expandedWidget,
        ),
      ],
    );
  }
}
