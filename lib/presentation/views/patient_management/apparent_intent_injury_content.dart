import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/apparent_intent_injury.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class ApparentIntentInjuryContent extends StatelessWidget {
  const ApparentIntentInjuryContent({
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
      title: "Lesiones intencionales aparentes",
      index: 11,
      expandedWidget: traumaDataProvider.patientData!.apparentIntentInjury ==
                  null ||
              traumaDataProvider.patientData!.apparentIntentInjury!.isEmpty
          ? noDataWidget
          : SizedBox(
              width: double.infinity,
              child: Wrap(
                runSpacing: 10,
                spacing: 10,
                children: traumaDataProvider.patientData!.apparentIntentInjury!
                    .map(
                      (apparentIntentInjury) => CustomContainer(
                        maxWidth: 600,
                        children: apparentIntentInjuryContent(
                          apparentIntentInjury: apparentIntentInjury,
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

  List<Widget> apparentIntentInjuryContent({
    required ApparentIntentInjury apparentIntentInjury,
    required CustomSize customSize,
    required bool allowEditFields,
    required TraumaDataProvider traumaDataProvider,
    required bool freeSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Intesión aparente",
        hintText: "No registra",
        text: apparentIntentInjury.intencionAparente ?? "",
        lines: 1,
        width: freeSize ? null : 460,
      ),
    ];
  }
}
