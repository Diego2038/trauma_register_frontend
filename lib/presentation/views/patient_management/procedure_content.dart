import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/helpers/transform_data.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/patient_data.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/procedure.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_icon_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class ProcedureContent extends StatelessWidget {
  const ProcedureContent({
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
      title: "Procedimientos realizados",
      index: 20,
      expandedWidget: _getCurrentPatientData(context).procedure == null ||
              _getCurrentPatientData(context).procedure!.isEmpty
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
                      .procedure!
                      .asMap()
                      .entries
                      .map(
                        (entry) => CustomContainer(
                          maxWidth: 600,
                          children: procedureContent(
                            context: context,
                            index: entry.key,
                            procedure: entry.value,
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
        final currentElements = currentPatientData.procedure;
        final traumaDataProvider = _getCurrentProvider(context);
        traumaDataProvider.updatePatientData(
            currentPatientData.copyWith(
              procedure: [
                if (currentElements != null) ...currentElements,
                Procedure(),
              ],
            ),
            true);
      },
    );
  }

  List<Widget> procedureContent({
    required BuildContext context,
    required int index,
    required Procedure procedure,
    required CustomSize customSize,
    required bool isCreating,
    required bool freeSize,
  }) {
    final traumaDataProvider = _getCurrentProvider(context);
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Procedimiento realizado",
        hintText: "No registra",
        text: procedure.procedimientoRealizado ?? "",
        lines: 4,
        width: freeSize ? null : 220,
        height: freeSize ? null : 184,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            procedure: patientData.procedure
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        procedimientoRealizado:
                            TransformData.getTransformedValue<String>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Lugar",
        hintText: "No registra",
        text: procedure.lugar ?? "",
        lines: 4,
        width: freeSize ? null : 220,
        height: freeSize ? null : 184,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            procedure: patientData.procedure
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        lugar: TransformData.getTransformedValue<String>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Fecha y hora de inicio",
        hintText: "No registra",
        text: procedure.fechaYHoraDeInicio != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(procedure.fechaYHoraDeInicio!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            procedure: patientData.procedure
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        fechaYHoraDeInicio:
                            TransformData.getTransformedValue<DateTime>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Fecha y hora de terminación",
        hintText: "No registra",
        text: procedure.fechaYHoraDeTermino != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(procedure.fechaYHoraDeTermino!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            procedure: patientData.procedure
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        fechaYHoraDeTermino:
                            TransformData.getTransformedValue<DateTime>(value))
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
