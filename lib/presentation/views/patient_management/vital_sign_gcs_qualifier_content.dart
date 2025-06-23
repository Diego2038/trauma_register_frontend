import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/vital_sign_gcs_qualifier.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class VitalSignGcsQualifierContent extends StatelessWidget {
  const VitalSignGcsQualifierContent({
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
      title: "Calificaciones de signos vitales GCS",
      index: 5,
      expandedWidget: traumaDataProvider.patientData!.vitalSignGcsQualifier ==
                  null ||
              traumaDataProvider.patientData!.vitalSignGcsQualifier!.isEmpty
          ? noDataWidget
          : SizedBox(
              width: double.infinity,
              child: Wrap(
                runSpacing: 10,
                spacing: 10,
                children: traumaDataProvider.patientData!.vitalSignGcsQualifier!
                    .map(
                      (vitalSignGcsQualifier) => CustomContainer(
                        maxWidth: 600,
                        children: vitalSignGcsQualifierContent(
                          vitalSignGcsQualifier: vitalSignGcsQualifier,
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

  List<Widget> vitalSignGcsQualifierContent({
    required VitalSignGcsQualifier vitalSignGcsQualifier,
    required CustomSize customSize,
    required bool allowEditFields,
    required TraumaDataProvider traumaDataProvider,
    required bool freeSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Calificador GCS",
        hintText: "No registra",
        text: vitalSignGcsQualifier.calificadorGcs ?? "",
        lines: 2,
        width: freeSize ? null : 460,
      ),
    ];
  }
}
