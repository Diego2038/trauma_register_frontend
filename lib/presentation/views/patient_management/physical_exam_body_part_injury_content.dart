import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/physical_exam_body_part_injury.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class PhysicalExamBodyPartInjuryContent extends StatelessWidget {
  const PhysicalExamBodyPartInjuryContent({
    super.key,
    required this.traumaDataProvider,
    required this.noDataWidget,
    required this.allowEditFields,
    required this.freeSize,
    required this.customSize,
  });

  final TraumaDataProvider traumaDataProvider;
  final NormalText noDataWidget;
  final bool allowEditFields;
  final bool freeSize;
  final CustomSize customSize;

  @override
  Widget build(BuildContext context) {
    return ExpandableTitleWidget(
      title: "Exámenes físicos producto por lesión de partes del cuerpo",
      index: 19,
      expandedWidget:
          traumaDataProvider.patientData!.physicalExamBodyPartInjury == null ||
                  traumaDataProvider
                      .patientData!.physicalExamBodyPartInjury!.isEmpty
              ? noDataWidget
              : SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: traumaDataProvider
                        .patientData!.physicalExamBodyPartInjury!
                        .map(
                          (physicalExamBodyPartInjury) => CustomContainer(
                            maxWidth: 600,
                            children: physicalExamBodyPartInjuryContent(
                              physicalExamBodyPartInjury:
                                  physicalExamBodyPartInjury,
                              allowEditFields: allowEditFields,
                              traumaDataProvider: traumaDataProvider,
                              freeSize: freeSize,
                              customSize: customSize,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
    );
  }

  List<Widget> physicalExamBodyPartInjuryContent({
    required PhysicalExamBodyPartInjury physicalExamBodyPartInjury,
    required CustomSize customSize,
    required bool allowEditFields,
    required TraumaDataProvider traumaDataProvider,
    required bool freeSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Parte del cuerpo",
        hintText: "No registra",
        text: physicalExamBodyPartInjury.parteDelCuerpo ?? "",
        lines: 1,
        width: freeSize ? null : 460,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tipo de lesión",
        hintText: "No registra",
        text: physicalExamBodyPartInjury.tipoDeLesion ?? "",
        lines: 1,
        width: freeSize ? null : 460,
      ),
    ];
  }
}
