import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/helpers/transform_data.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/hospitalization_variable.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/patient_data.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_icon_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class HospitalizationVariableContent extends StatelessWidget {
  const HospitalizationVariableContent({
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
      title: "Variables de hospitalización",
      index: 6,
      expandedWidget: _getCurrentPatientData(context).hospitalizationVariable ==
                  null ||
              _getCurrentPatientData(context).hospitalizationVariable!.isEmpty
          ? isCreating
              ? Center(
                  child: _addNewElement(context),
                )
              : noDataWidget
          : SizedBox(
              width: double.infinity,
              child: Wrap(
                runSpacing: 10,
                spacing: 10,
                children: [
                  ..._getCurrentPatientData(context)
                      .hospitalizationVariable!
                      .asMap()
                      .entries
                      .map(
                        (entry) => CustomContainer(
                          maxWidth: 600,
                          children: hospitalizationVariableContent(
                            context: context,
                            index: entry.key,
                            hospitalizationVariable: entry.value,
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
        final currentElements = currentPatientData.hospitalizationVariable;
        final traumaDataProvider = _getCurrentProvider(context);
        traumaDataProvider.updatePatientData(
            currentPatientData.copyWith(
              hospitalizationVariable: [
                if (currentElements != null) ...currentElements,
                HospitalizationVariable(),
              ],
            ),
            true);
      },
    );
  }

  List<Widget> hospitalizationVariableContent({
    required BuildContext context,
    required int index,
    required HospitalizationVariable hospitalizationVariable,
    required CustomSize customSize,
    required bool isCreating,
    required bool freeSize,
  }) {
    final traumaDataProvider = _getCurrentProvider(context);
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Tipo de variable",
        hintText: "No registra",
        text: hospitalizationVariable.tipoDeVariable ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 94,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            hospitalizationVariable: patientData.hospitalizationVariable
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        tipoDeVariable:
                            TransformData.getTransformedValue<String>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Valor de la variable",
        hintText: "No registra",
        text: hospitalizationVariable.valorDeLaVariable ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 94,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            hospitalizationVariable: patientData.hospitalizationVariable
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        valorDeLaVariable:
                            TransformData.getTransformedValue<String>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Fecha y hora de la variable",
        hintText: "No registra",
        text: hospitalizationVariable.fechaYHoraDeLaVariable != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(hospitalizationVariable.fechaYHoraDeLaVariable!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 153,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            hospitalizationVariable: patientData.hospitalizationVariable
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        fechaYHoraDeLaVariable:
                            TransformData.getTransformedValue<DateTime>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Localización de la variable",
        hintText: "No registra",
        text: hospitalizationVariable.localizacionDeVariable ?? "",
        lines: 3,
        width: freeSize ? null : 220,
        height: freeSize ? null : 153,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            hospitalizationVariable: patientData.hospitalizationVariable
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        localizacionDeVariable:
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
