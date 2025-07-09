import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/helpers/transform_data.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/shared/optional.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/intensive_care_unit.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/patient_data.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_icon_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class IntensiveCareUnitContent extends StatelessWidget {
  const IntensiveCareUnitContent({
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
      title: "Unidades de cuidados intensivos",
      index: 9,
      expandedWidget:
          _getCurrentPatientData(context).intensiveCareUnit == null ||
                  _getCurrentPatientData(context).intensiveCareUnit!.isEmpty
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
                          .intensiveCareUnit!
                          .asMap()
                          .entries
                          .map(
                            (entry) => _Content(
                              keyy: entry.key,
                              value: entry.value,
                              customSize: customSize,
                              isCreating: isCreating,
                              freeSize: freeSize,
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
        final currentElements = currentPatientData.intensiveCareUnit;
        final traumaDataProvider = _getCurrentProvider(context);
        traumaDataProvider.updatePatientData(
            currentPatientData.copyWith(
              intensiveCareUnit: [
                if (currentElements != null) ...currentElements,
                IntensiveCareUnit(),
              ],
            ),
            true);
      },
    );
  }

  PatientData _getCurrentPatientData(BuildContext context) {
    return Provider.of<TraumaDataProvider>(context, listen: false).patientData!;
  }

  TraumaDataProvider _getCurrentProvider(BuildContext context) {
    return Provider.of<TraumaDataProvider>(context, listen: false);
  }
}

class _Content extends StatefulWidget {
  const _Content({
    required this.keyy,
    required this.value,
    required this.customSize,
    required this.isCreating,
    required this.freeSize,
  });

  final int keyy;
  final IntensiveCareUnit value;
  final CustomSize customSize;
  final bool isCreating;
  final bool freeSize;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      maxWidth: 600,
      children: intensiveCareUnitContent(
        context: context,
        index: widget.keyy,
        intensiveCareUnit: widget.value,
        customSize: widget.customSize,
        isCreating: widget.isCreating,
        freeSize: widget.freeSize,
      ),
    );
  }

  List<Widget> intensiveCareUnitContent({
    required BuildContext context,
    required int index,
    required IntensiveCareUnit intensiveCareUnit,
    required CustomSize customSize,
    required bool isCreating,
    required bool freeSize,
  }) {
    final traumaDataProvider = _getCurrentProvider(context);
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Tipo",
        hintText: "No registra",
        text: intensiveCareUnit.tipo ?? "",
        lines: 2,
        width: freeSize ? null : 460,
        height: freeSize ? null : 94,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            intensiveCareUnit: patientData.intensiveCareUnit
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        tipo: Optional<String?>.of(
                            TransformData.getTransformedValue<String>(value)))
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
        text: intensiveCareUnit.fechaYHoraDeInicio != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(intensiveCareUnit.fechaYHoraDeInicio!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            intensiveCareUnit: patientData.intensiveCareUnit
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        fechaYHoraDeInicio: Optional<DateTime?>.of(
                            TransformData.getTransformedValue<DateTime>(value)))
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
        text: intensiveCareUnit.fechaYHoraDeTermino != null
            ? DateFormat('dd/MM/yyyy')
                .format(intensiveCareUnit.fechaYHoraDeTermino!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            intensiveCareUnit: patientData.intensiveCareUnit
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        fechaYHoraDeTermino: Optional<DateTime?>.of(
                            TransformData.getTransformedValue<DateTime>(value)))
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
        text: intensiveCareUnit.lugar ?? "",
        lines: 3,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            intensiveCareUnit: patientData.intensiveCareUnit
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        lugar: Optional<String?>.of(
                            TransformData.getTransformedValue<String>(value)))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Días de UCI",
        hintText: "No registra",
        text: "${intensiveCareUnit.icuDays ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            intensiveCareUnit: patientData.intensiveCareUnit
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        icuDays: Optional<double?>.of(
                            TransformData.getTransformedValue<double>(value)))
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
