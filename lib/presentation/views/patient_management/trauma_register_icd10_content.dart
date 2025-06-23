import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/trauma_register_icd10.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class TraumaRegisterIcd10Content extends StatelessWidget {
  const TraumaRegisterIcd10Content({
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
      title: "Registros de trauma ICD10",
      index: 8,
      expandedWidget: traumaDataProvider.patientData!.traumaRegisterIcd10 ==
                  null ||
              traumaDataProvider.patientData!.traumaRegisterIcd10!.isEmpty
          ? noDataWidget
          : SizedBox(
              width: double.infinity,
              child: Wrap(
                runSpacing: 10,
                spacing: 10,
                children: traumaDataProvider.patientData!.traumaRegisterIcd10!
                    .map(
                      (traumaRegisterIcd10) => CustomContainer(
                        maxWidth: 600,
                        children: traumaRegisterIcd10Content(
                          traumaRegisterIcd10: traumaRegisterIcd10,
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

  List<Widget> traumaRegisterIcd10Content({
    required TraumaRegisterIcd10 traumaRegisterIcd10,
    required CustomSize customSize,
    required bool allowEditFields,
    required TraumaDataProvider traumaDataProvider,
    required bool freeSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Descripción",
        hintText: "No registra",
        text: traumaRegisterIcd10.descripcion ?? "",
        lines: 4,
        width: freeSize ? null : 460,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Mecanismo ICD",
        hintText: "No registra",
        text: traumaRegisterIcd10.mecanismoIcd ?? "",
        lines: 1,
        width: freeSize ? null : 460,
      ),
    ];
  }
}
