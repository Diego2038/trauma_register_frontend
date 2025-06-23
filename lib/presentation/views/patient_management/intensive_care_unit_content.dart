import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/intensive_care_unit.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class IntensiveCareUnitContent extends StatelessWidget {
  const IntensiveCareUnitContent({
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
      title: "Unidades de cuidados intensivos",
      index: 9,
      expandedWidget:
          traumaDataProvider.patientData!.intensiveCareUnit == null ||
                  traumaDataProvider.patientData!.intensiveCareUnit!.isEmpty
              ? noDataWidget
              : SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: traumaDataProvider.patientData!.intensiveCareUnit!
                        .map(
                          (intensiveCareUnit) => CustomContainer(
                            maxWidth: 600,
                            children: intensiveCareUnitContent(
                              intensiveCareUnit: intensiveCareUnit,
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

  List<Widget> intensiveCareUnitContent({
    required IntensiveCareUnit intensiveCareUnit,
    required CustomSize customSize,
    required bool allowEditFields,
    required TraumaDataProvider traumaDataProvider,
    required bool freeSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tipo",
        hintText: "No registra",
        text: intensiveCareUnit.tipo ?? "",
        lines: 2,
        width: freeSize ? null : 460,
        height: freeSize ? null : 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Fecha y hora de inicio",
        hintText: "No registra",
        text: intensiveCareUnit.fechaYHoraDeInicio != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(intensiveCareUnit.fechaYHoraDeInicio!)
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
        text: intensiveCareUnit.fechaYHoraDeTermino != null
            ? DateFormat('dd/MM/yyyy')
                .format(intensiveCareUnit.fechaYHoraDeTermino!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Lugar",
        hintText: "No registra",
        text: intensiveCareUnit.lugar ?? "",
        lines: 3,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Días de UCI",
        hintText: "No registra",
        text: "${intensiveCareUnit.icuDays ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
    ];
  }
}
