import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/hospitalization_complication.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class HospitalizationComplicationContent extends StatelessWidget {
  const HospitalizationComplicationContent({
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
      title: "Complicaciones de hospitalización",
      index: 7,
      expandedWidget: traumaDataProvider
                      .patientData!.hospitalizationComplication ==
                  null ||
              traumaDataProvider
                  .patientData!.hospitalizationComplication!.isEmpty
          ? noDataWidget
          : SizedBox(
              width: double.infinity,
              child: Wrap(
                runSpacing: 10,
                spacing: 10,
                children:
                    traumaDataProvider.patientData!.hospitalizationComplication!
                        .map(
                          (hospitalizationComplication) => CustomContainer(
                            maxWidth: 600,
                            children: hospitalizationComplicationContent(
                              hospitalizationComplication:
                                  hospitalizationComplication,
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

  List<Widget> hospitalizationComplicationContent({
    required HospitalizationComplication hospitalizationComplication,
    required CustomSize customSize,
    required bool allowEditFields,
    required TraumaDataProvider traumaDataProvider,
    required bool freeSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tipo de complicación",
        hintText: "No registra",
        text: hospitalizationComplication.tipoDeComplicacion ?? "",
        lines: 2,
        width: freeSize ? null : 460,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Fecha y hora de la complicación",
        hintText: "No registra",
        text: hospitalizationComplication.fechaYHoraDeComplicacion != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(hospitalizationComplication.fechaYHoraDeComplicacion!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Lugar de la complicación",
        hintText: "No registra",
        text: hospitalizationComplication.lugarDeComplicacion ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
    ];
  }
}
