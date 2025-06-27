import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/helpers/transform_data.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/imaging.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/patient_data.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_icon_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class ImagingContent extends StatelessWidget {
  const ImagingContent({
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
      title: "Imágenes",
      index: 10,
      expandedWidget: _getCurrentPatientData(context).imaging == null ||
              _getCurrentPatientData(context).imaging!.isEmpty
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
                      .imaging!
                      .asMap()
                      .entries
                      .map(
                        (entry) => CustomContainer(
                          maxWidth: 600,
                          children: imagingContent(
                            context: context,
                            index: entry.key,
                            imaging: entry.value,
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
        final currentElements = currentPatientData.imaging;
        final traumaDataProvider = _getCurrentProvider(context);
        traumaDataProvider.updatePatientData(
            currentPatientData.copyWith(
              imaging: [
                if (currentElements != null) ...currentElements,
                Imaging(),
              ],
            ),
            true);
      },
    );
  }

  List<Widget> imagingContent({
    required BuildContext context,
    required int index,
    required Imaging imaging,
    required CustomSize customSize,
    required bool isCreating,
    required bool freeSize,
  }) {
    final traumaDataProvider = _getCurrentProvider(context);
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Tipo de imagen",
        hintText: "No registra",
        text: imaging.tipoDeImagen ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 94,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            imaging: patientData.imaging
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        tipoDeImagen:
                            TransformData.getTransformedValue<String>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Parte del cuerpo",
        hintText: "No registra",
        text: imaging.parteDelCuerpo ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 94,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            imaging: patientData.imaging
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        parteDelCuerpo:
                            TransformData.getTransformedValue<String>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Opción",
        hintText: "No registra",
        text: imaging.opcion != null
            ? imaging.opcion!
                ? 'Sí'
                : 'No'
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            imaging: patientData.imaging
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        opcion: TransformData.getTransformedValue<bool>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Descripción",
        hintText: "No registra",
        text: imaging.descripcion ?? "",
        lines: 9,
        width: freeSize ? null : 460,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            imaging: patientData.imaging
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        descripcion:
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
