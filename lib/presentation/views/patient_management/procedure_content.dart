import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/procedure.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class ProcedureContent extends StatelessWidget {
  const ProcedureContent({
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
      title: "Procedimientos realizados",
      index: 20,
      expandedWidget: traumaDataProvider.patientData!.procedure == null ||
              traumaDataProvider.patientData!.procedure!.isEmpty
          ? noDataWidget
          : SizedBox(
              width: double.infinity,
              child: Wrap(
                runSpacing: 10,
                spacing: 10,
                children: traumaDataProvider.patientData!.procedure!
                    .map(
                      (procedure) => CustomContainer(
                        maxWidth: 600,
                        children: procedureContent(
                          procedure: procedure,
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

  List<Widget> procedureContent({
    required Procedure procedure,
    required CustomSize customSize,
    required bool allowEditFields,
    required TraumaDataProvider traumaDataProvider,
    required bool freeSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Procedimiento realizado",
        hintText: "No registra",
        text: procedure.procedimientoRealizado ?? "",
        lines: 4,
        width: freeSize ? null : 220,
        height: freeSize ? null : 184,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Lugar",
        hintText: "No registra",
        text: procedure.lugar ?? "",
        lines: 4,
        width: freeSize ? null : 220,
        height: freeSize ? null : 184,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Fecha y hora de inicio",
        hintText: "No registra",
        text: procedure.fechaYHoraDeInicio != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(procedure.fechaYHoraDeInicio!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Fecha y hora de terminación",
        hintText: "No registra",
        text: procedure.fechaYHoraDeTermino != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(procedure.fechaYHoraDeTermino!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
      ),
    ];
  }
}
