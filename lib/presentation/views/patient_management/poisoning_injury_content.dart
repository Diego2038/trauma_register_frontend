import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/poisoning_injury.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class PoisoningInjuryContent extends StatelessWidget {
  const PoisoningInjuryContent({
    super.key,
    required this.traumaDataProvider,
    required this.noDataWidget,
    required this.customSize,
    required this.allowEditFields,
    required this.freeSize,
  });

  final TraumaDataProvider traumaDataProvider;
  final NormalText noDataWidget;
  final CustomSize customSize;
  final bool allowEditFields;
  final bool freeSize;

  @override
  Widget build(BuildContext context) {
    return ExpandableTitleWidget(
      title: "Lesiones por envenenamiento",
      index: 15,
      expandedWidget: traumaDataProvider.patientData!.poisoningInjury == null ||
              traumaDataProvider.patientData!.poisoningInjury!.isEmpty
          ? noDataWidget
          : SizedBox(
              width: double.infinity,
              child: Wrap(
                runSpacing: 10,
                spacing: 10,
                children: traumaDataProvider.patientData!.poisoningInjury!
                    .map(
                      (poisoningInjury) => CustomContainer(
                        maxWidth: 600,
                        children: poisoningInjuryContent(
                          poisoningInjury: poisoningInjury,
                          customSize: customSize,
                          allowEditFields: allowEditFields,
                          traumaDataProvider: traumaDataProvider,
                          freeSize: freeSize,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
    );
  }

  List<Widget> poisoningInjuryContent({
    required PoisoningInjury poisoningInjury,
    required CustomSize customSize,
    required bool allowEditFields,
    required TraumaDataProvider traumaDataProvider,
    required bool freeSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tipo de envenenamiento",
        hintText: "No registra",
        text: poisoningInjury.tipoDeEnvenenamiento ?? "",
        lines: 1,
        width: freeSize ? null : 460,
      ),
    ];
  }
}
