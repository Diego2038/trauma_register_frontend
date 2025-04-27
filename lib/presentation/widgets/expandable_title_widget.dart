import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';

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
    final traumaDataProvider =
        Provider.of<TraumaDataProvider>(context, listen: true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            traumaDataProvider
                .toggleExpansion(index); // Alternar estado de expansión
          },
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.base,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(
                  traumaDataProvider.getExpansionState(index)
                      ? Icons.remove
                      : Icons.add,
                  color: AppColors.white,
                  size: 24,
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
        AnimatedCrossFade(
          firstChild: const SizedBox(),
          secondChild: expandedWidget,
          crossFadeState: traumaDataProvider.getExpansionState(index)
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }
}
