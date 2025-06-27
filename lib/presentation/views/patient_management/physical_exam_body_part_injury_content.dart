import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/helpers/transform_data.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/patient_data.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/physical_exam_body_part_injury.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_icon_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class PhysicalExamBodyPartInjuryContent extends StatelessWidget {
  const PhysicalExamBodyPartInjuryContent({
    super.key,
    required this.noDataWidget,
    required this.isCreating,
    required this.freeSize,
    required this.customSize,
  });

  final NormalText noDataWidget;
  final bool isCreating;
  final bool freeSize;
  final CustomSize customSize;

  @override
  Widget build(BuildContext context) {
    return ExpandableTitleWidget(
      title: "Exámenes físicos producto por lesión de partes del cuerpo",
      index: 19,
      expandedWidget:
          _getCurrentPatientData(context).physicalExamBodyPartInjury == null ||
                  _getCurrentPatientData(context)
                      .physicalExamBodyPartInjury!
                      .isEmpty
              ? isCreating
                  ? Center(child: _addNewElement(context))
                  : noDataWidget
              : SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: [
                      ..._getCurrentPatientData(context)
                          .physicalExamBodyPartInjury!
                          .asMap()
                          .entries
                          .map(
                            (entry) => CustomContainer(
                              maxWidth: 600,
                              children: physicalExamBodyPartInjuryContent(
                                context: context,
                                index: entry.key,
                                physicalExamBodyPartInjury: entry.value,
                                isCreating: isCreating,
                                freeSize: freeSize,
                                customSize: customSize,
                              ),
                            ),
                          ),
                      if (isCreating) _addNewElement(context),
                    ],
                  ),
                ),
    );
  }

  Widget _addNewElement(BuildContext context) {
    return CustomIconButton(
      onPressed: () {
        final currentPatientData = _getCurrentPatientData(context);
        final currentElements = currentPatientData.physicalExamBodyPartInjury;
        final traumaDataProvider = _getCurrentProvider(context);
        traumaDataProvider.updatePatientData(
            currentPatientData.copyWith(
              physicalExamBodyPartInjury: [
                if (currentElements != null) ...currentElements,
                PhysicalExamBodyPartInjury(),
              ],
            ),
            true);
      },
    );
  }

  List<Widget> physicalExamBodyPartInjuryContent({
    required BuildContext context,
    required int index,
    required PhysicalExamBodyPartInjury physicalExamBodyPartInjury,
    required CustomSize customSize,
    required bool isCreating,
    required bool freeSize,
  }) {
    final traumaDataProvider = _getCurrentProvider(context);
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Parte del cuerpo",
        hintText: "No registra",
        text: physicalExamBodyPartInjury.parteDelCuerpo ?? "",
        lines: 1,
        width: freeSize ? null : 460,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            physicalExamBodyPartInjury: patientData.physicalExamBodyPartInjury
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        parteDelCuerpo:
                            TransformData.getTransformedValue<String>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Tipo de lesión",
        hintText: "No registra",
        text: physicalExamBodyPartInjury.tipoDeLesion ?? "",
        lines: 1,
        width: freeSize ? null : 460,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            physicalExamBodyPartInjury: patientData.physicalExamBodyPartInjury
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        tipoDeLesion:
                            TransformData.getTransformedValue<String>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
    ];
  }

  PatientData _getCurrentPatientData(BuildContext context) {
    return Provider.of<TraumaDataProvider>(context, listen: false).patientData!;
  }

  TraumaDataProvider _getCurrentProvider(BuildContext context) {
    return Provider.of<TraumaDataProvider>(context, listen: false);
  }
}
