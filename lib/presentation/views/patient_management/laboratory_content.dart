import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/laboratory.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class LaboratoryContent extends StatelessWidget {
  const LaboratoryContent({
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
      title: "Exámenes de laboratorio",
      index: 18,
      expandedWidget: traumaDataProvider.patientData!.laboratory == null ||
              traumaDataProvider.patientData!.laboratory!.isEmpty
          ? noDataWidget
          : SizedBox(
              width: double.infinity,
              child: Wrap(
                runSpacing: 10,
                spacing: 10,
                children: traumaDataProvider.patientData!.laboratory!
                    .map(
                      (laboratory) => CustomContainer(
                        maxWidth: 600,
                        children: laboratoryContent(
                          laboratory: laboratory,
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

  List<Widget> laboratoryContent({
    required Laboratory laboratory,
    required CustomSize customSize,
    required bool allowEditFields,
    required TraumaDataProvider traumaDataProvider,
    required bool freeSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Resultado de laboratorio",
        hintText: "No registra",
        text: laboratory.resultadoDeLaboratorio ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Fecha y hora de laboratorio",
        hintText: "No registra",
        text: laboratory.fechaYHoraDeLaboratorio != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(laboratory.fechaYHoraDeLaboratorio!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Nombre de la prueba de laboratorio",
        hintText: "No registra",
        text: laboratory.nombreDelLaboratorio ?? "",
        lines: 3,
        width: freeSize ? null : 220,
        height: freeSize ? null : 154,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Nombre de la unidad de laboratorio",
        hintText: "No registra",
        text: laboratory.nombreDeLaUnidadDeLaboratorio ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 154,
      ),
    ];
  }
}
