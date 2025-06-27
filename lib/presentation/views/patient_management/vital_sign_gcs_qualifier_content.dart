import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/helpers/transform_data.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/patient_data.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/vital_sign_gcs_qualifier.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_icon_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class VitalSignGcsQualifierContent extends StatelessWidget {
  const VitalSignGcsQualifierContent({
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
      title: "Calificaciones de signos vitales GCS",
      index: 5,
      expandedWidget:
          _getCurrentPatientData(context).vitalSignGcsQualifier == null ||
                  _getCurrentPatientData(context).vitalSignGcsQualifier!.isEmpty
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
                          .vitalSignGcsQualifier!
                          .asMap()
                          .entries
                          .map(
                            (entry) => CustomContainer(
                              maxWidth: 600,
                              children: vitalSignGcsQualifierContent(
                                context: context,
                                index: entry.key,
                                vitalSignGcsQualifier: entry.value,
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
        final currentElements = currentPatientData.vitalSignGcsQualifier;
        final traumaDataProvider = _getCurrentProvider(context);
        traumaDataProvider.updatePatientData(
            currentPatientData.copyWith(
              vitalSignGcsQualifier: [
                if (currentElements != null) ...currentElements,
                VitalSignGcsQualifier(),
              ],
            ),
            true);
      },
    );
  }

  List<Widget> vitalSignGcsQualifierContent({
    required BuildContext context,
    required int index,
    required VitalSignGcsQualifier vitalSignGcsQualifier,
    required CustomSize customSize,
    required bool isCreating,
    required bool freeSize,
  }) {
    final traumaDataProvider = _getCurrentProvider(context);
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Calificador GCS",
        hintText: "No registra",
        text: vitalSignGcsQualifier.calificadorGcs ?? "",
        lines: 2,
        width: freeSize ? null : 460,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSignGcsQualifier: patientData.vitalSignGcsQualifier
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        calificadorGcs:
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
