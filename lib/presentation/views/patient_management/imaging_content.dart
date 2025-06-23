import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/imaging.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class ImagingContent extends StatelessWidget {
  const ImagingContent({
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
      title: "Imágenes",
      index: 10,
      expandedWidget: traumaDataProvider.patientData!.imaging == null ||
              traumaDataProvider.patientData!.imaging!.isEmpty
          ? noDataWidget
          : SizedBox(
              width: double.infinity,
              child: Wrap(
                runSpacing: 10,
                spacing: 10,
                children: traumaDataProvider.patientData!.imaging!
                    .map(
                      (imaging) => CustomContainer(
                        maxWidth: 600,
                        children: imagingContent(
                          imaging: imaging,
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

  List<Widget> imagingContent({
    required Imaging imaging,
    required CustomSize customSize,
    required bool allowEditFields,
    required TraumaDataProvider traumaDataProvider,
    required bool freeSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tipo de imagen",
        hintText: "No registra",
        text: imaging.tipoDeImagen ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Parte del cuerpo",
        hintText: "No registra",
        text: imaging.parteDelCuerpo ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Opción",
        hintText: "No registra",
        text: imaging.opcion != null
            ? imaging.opcion!
                ? 'Sí'
                : 'No'
            : "",
        lines: 1,
        width: freeSize ? null : 220,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Descripción",
        hintText: "No registra",
        text: imaging.descripcion ?? "",
        lines: 9,
        width: freeSize ? null : 460,
      ),
    ];
  }
}
