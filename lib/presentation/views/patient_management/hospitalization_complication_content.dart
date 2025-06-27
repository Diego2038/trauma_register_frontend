import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/helpers/transform_data.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/hospitalization_complication.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/patient_data.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_icon_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class HospitalizationComplicationContent extends StatelessWidget {
  const HospitalizationComplicationContent({
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
      title: "Complicaciones de hospitalización",
      index: 7,
      expandedWidget:
          _getCurrentPatientData(context).hospitalizationComplication == null ||
                  _getCurrentPatientData(context)
                      .hospitalizationComplication!
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
                          .hospitalizationComplication!
                          .asMap()
                          .entries
                          .map(
                            (entry) => CustomContainer(
                              maxWidth: 600,
                              children: hospitalizationComplicationContent(
                                context: context,
                                index: entry.key,
                                hospitalizationComplication: entry.value,
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
        final currentElements = currentPatientData.hospitalizationComplication;
        final traumaDataProvider = _getCurrentProvider(context);
        traumaDataProvider.updatePatientData(
            currentPatientData.copyWith(
              hospitalizationComplication: [
                if (currentElements != null) ...currentElements,
                HospitalizationComplication(),
              ],
            ),
            true);
      },
    );
  }

  List<Widget> hospitalizationComplicationContent({
    required BuildContext context,
    required int index,
    required HospitalizationComplication hospitalizationComplication,
    required CustomSize customSize,
    required bool isCreating,
    required bool freeSize,
  }) {
    final traumaDataProvider = _getCurrentProvider(context);
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Tipo de complicación",
        hintText: "No registra",
        text: hospitalizationComplication.tipoDeComplicacion ?? "",
        lines: 2,
        width: freeSize ? null : 460,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            hospitalizationComplication: patientData.hospitalizationComplication
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        tipoDeComplicacion:
                            TransformData.getTransformedValue<String>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Fecha y hora de la complicación",
        hintText: "No registra",
        text: hospitalizationComplication.fechaYHoraDeComplicacion != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(hospitalizationComplication.fechaYHoraDeComplicacion!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            hospitalizationComplication: patientData.hospitalizationComplication
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        fechaYHoraDeComplicacion:
                            TransformData.getTransformedValue<DateTime>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Lugar de la complicación",
        hintText: "No registra",
        text: hospitalizationComplication.lugarDeComplicacion ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            hospitalizationComplication: patientData.hospitalizationComplication
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        lugarDeComplicacion:
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
