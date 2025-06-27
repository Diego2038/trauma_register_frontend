import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/helpers/transform_data.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/laboratory.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/patient_data.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_icon_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class LaboratoryContent extends StatelessWidget {
  const LaboratoryContent({
    super.key,
    required this.noDataWidget,
    required this.customSize,
    required this.isCreating,
    required this.freeSize,
  });

  final NormalText noDataWidget;
  final CustomSize customSize;
  final bool isCreating;
  final bool freeSize;

  @override
  Widget build(BuildContext context) {
    return ExpandableTitleWidget(
      title: "Exámenes de laboratorio",
      index: 18,
      expandedWidget: _getCurrentPatientData(context).laboratory == null ||
              _getCurrentPatientData(context).laboratory!.isEmpty
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
                      .laboratory!
                      .asMap()
                      .entries
                      .map(
                        (entry) => CustomContainer(
                          maxWidth: 600,
                          children: laboratoryContent(
                            context: context,
                            index: entry.key,
                            laboratory: entry.value,
                            customSize: customSize,
                            isCreating: isCreating,
                            freeSize: freeSize,
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
        final currentElements = currentPatientData.laboratory;
        final traumaDataProvider = _getCurrentProvider(context);
        traumaDataProvider.updatePatientData(
            currentPatientData.copyWith(
              laboratory: [
                if (currentElements != null) ...currentElements,
                Laboratory(),
              ],
            ),
            true);
      },
    );
  }

  List<Widget> laboratoryContent({
    required BuildContext context,
    required int index,
    required Laboratory laboratory,
    required CustomSize customSize,
    required bool isCreating,
    required bool freeSize,
  }) {
    final traumaDataProvider = _getCurrentProvider(context);
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Resultado de laboratorio",
        hintText: "No registra",
        text: laboratory.resultadoDeLaboratorio ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            laboratory: patientData.laboratory
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        resultadoDeLaboratorio:
                            TransformData.getTransformedValue<String>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Fecha y hora de laboratorio",
        hintText: "No registra",
        text: laboratory.fechaYHoraDeLaboratorio != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(laboratory.fechaYHoraDeLaboratorio!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            laboratory: patientData.laboratory
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        fechaYHoraDeLaboratorio:
                            TransformData.getTransformedValue<DateTime>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Nombre de la prueba de laboratorio",
        hintText: "No registra",
        text: laboratory.nombreDelLaboratorio ?? "",
        lines: 3,
        width: freeSize ? null : 220,
        height: freeSize ? null : 154,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            laboratory: patientData.laboratory
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        nombreDelLaboratorio:
                            TransformData.getTransformedValue<String>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Nombre de la unidad de laboratorio",
        hintText: "No registra",
        text: laboratory.nombreDeLaUnidadDeLaboratorio ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 154,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            laboratory: patientData.laboratory
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        nombreDeLaUnidadDeLaboratorio:
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
