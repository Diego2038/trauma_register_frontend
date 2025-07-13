import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';

class CustomContainer extends StatelessWidget {
  final List<Widget> children;
  final double? maxWidth;
  final bool showDeleteButton;
  final bool showUpdateButton;
  final VoidCallback? onDelete;
  final Future<void> Function()? onUpdate;
  const CustomContainer({
    super.key,
    required this.children,
    this.maxWidth,
    this.showDeleteButton = false,
    this.showUpdateButton = false,
    this.onDelete,
    this.onUpdate,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showUpdateButton)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (showUpdateButton)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        icon: const Icon(Icons.save),
                        onPressed: () async {
                          if (onUpdate != null) await onUpdate!();
                        },
                        color: AppColors.base,
                        iconSize: 25,
                      ),
                    ),
                ],
              ),
            ),
          Wrap(
            runAlignment: WrapAlignment.end,
            runSpacing: 20,
            spacing: 20,
            children: children,
          ),
          if (showDeleteButton)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (showDeleteButton)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: onDelete,
                        color: AppColors.modalCancel,
                        iconSize: 25,
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
