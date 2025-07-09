import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/helpers/transform_data.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/shared/optional.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/patient_data.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/trauma_register_icd10.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_icon_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class TraumaRegisterIcd10Content extends StatelessWidget {
  const TraumaRegisterIcd10Content({
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
      title: "Registros de trauma ICD10",
      index: 8,
      expandedWidget:
          _getCurrentPatientData(context).traumaRegisterIcd10 == null ||
                  _getCurrentPatientData(context).traumaRegisterIcd10!.isEmpty
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
                          .traumaRegisterIcd10!
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
        final currentElements = currentPatientData.traumaRegisterIcd10;
        final traumaDataProvider = _getCurrentProvider(context);
        traumaDataProvider.updatePatientData(
            currentPatientData.copyWith(
              traumaRegisterIcd10: [
                if (currentElements != null) ...currentElements,
                TraumaRegisterIcd10(),
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
  final TraumaRegisterIcd10 value;
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
      children: traumaRegisterIcd10Content(
        context: context,
        index: widget.keyy,
        traumaRegisterIcd10: widget.value,
        customSize: widget.customSize,
        isCreating: widget.isCreating,
        freeSize: widget.freeSize,
      ),
    );
  }

  List<Widget> traumaRegisterIcd10Content({
    required BuildContext context,
    required int index,
    required TraumaRegisterIcd10 traumaRegisterIcd10,
    required CustomSize customSize,
    required bool isCreating,
    required bool freeSize,
  }) {
    final traumaDataProvider = _getCurrentProvider(context);
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Descripción",
        hintText: "No registra",
        text: traumaRegisterIcd10.descripcion ?? "",
        lines: 4,
        width: freeSize ? null : 460,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            traumaRegisterIcd10: patientData.traumaRegisterIcd10
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        descripcion: Optional<String?>.of(
                            TransformData.getTransformedValue<String>(value)))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Mecanismo ICD",
        hintText: "No registra",
        text: traumaRegisterIcd10.mecanismoIcd ?? "",
        lines: 1,
        width: freeSize ? null : 460,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            traumaRegisterIcd10: patientData.traumaRegisterIcd10
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        mecanismoIcd: Optional<String?>.of(
                            TransformData.getTransformedValue<String>(value)))
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
