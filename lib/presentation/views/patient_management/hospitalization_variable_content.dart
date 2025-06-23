import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/hospitalization_variable.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class HospitalizationVariableContent extends StatelessWidget {
  const HospitalizationVariableContent({
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
      title: "Variables de hospitalización",
      index: 6,
      expandedWidget: traumaDataProvider.patientData!.hospitalizationVariable ==
                  null ||
              traumaDataProvider.patientData!.hospitalizationVariable!.isEmpty
          ? noDataWidget
          : SizedBox(
              width: double.infinity,
              child: Wrap(
                runSpacing: 10,
                spacing: 10,
                children:
                    traumaDataProvider.patientData!.hospitalizationVariable!
                        .map(
                          (hospitalizationVariable) => CustomContainer(
                            maxWidth: 600,
                            children: hospitalizationVariableContent(
                              hospitalizationVariable: hospitalizationVariable,
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

  List<Widget> hospitalizationVariableContent({
    required HospitalizationVariable hospitalizationVariable,
    required CustomSize customSize,
    required bool allowEditFields,
    required TraumaDataProvider traumaDataProvider,
    required bool freeSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tipo de variable",
        hintText: "No registra",
        text: hospitalizationVariable.tipoDeVariable ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Valor de la variable",
        hintText: "No registra",
        text: hospitalizationVariable.valorDeLaVariable ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Fecha y hora de la variable",
        hintText: "No registra",
        text: hospitalizationVariable.fechaYHoraDeLaVariable != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(hospitalizationVariable.fechaYHoraDeLaVariable!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 153,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Localización de la variable",
        hintText: "No registra",
        text: hospitalizationVariable.localizacionDeVariable ?? "",
        lines: 3,
        width: freeSize ? null : 220,
        height: freeSize ? null : 153,
      ),
    ];
  }
}
