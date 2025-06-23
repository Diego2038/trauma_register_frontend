import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/vital_sign.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class VitalSignContent extends StatelessWidget {
  const VitalSignContent({
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
      title: "Signos vitales",
      index: 23,
      expandedWidget: traumaDataProvider.patientData!.vitalSign == null ||
              traumaDataProvider.patientData!.vitalSign!.isEmpty
          ? noDataWidget
          : SizedBox(
              width: double.infinity,
              child: Wrap(
                runSpacing: 10,
                spacing: 10,
                children: traumaDataProvider.patientData!.vitalSign!
                    .map(
                      (vitalSign) => CustomContainer(
                        maxWidth: 600,
                        children: vitalSignContent(
                          vitalSign: vitalSign,
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

  List<Widget> vitalSignContent({
    required VitalSign vitalSign,
    required CustomSize customSize,
    required bool allowEditFields,
    required TraumaDataProvider traumaDataProvider,
    required bool freeSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Fecha y hora de la variable",
        hintText: "No registra",
        text: vitalSign.fechaYHoraDeSignosVitales != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(vitalSign.fechaYHoraDeSignosVitales!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Signos de vida",
        hintText: "No registra",
        text: vitalSign.signosDeVida != null
            ? vitalSign.signosDeVida!
                ? 'Sí'
                : 'No'
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Frecuencia cardiaca",
        hintText: "No registra",
        text: "${vitalSign.frecuenciaCardiaca ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Presión arterial sistólica",
        hintText: "No registra",
        text: "${vitalSign.presionArterialSistolica ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Presión arterial diastólica",
        hintText: "No registra",
        text: "${vitalSign.presionArterialDiastolica ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Frecuencia respiratoria",
        hintText: "No registra",
        text: "${vitalSign.frecuenciaRespiratoria ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Calificador de frecuencia respiratoria",
        hintText: "No registra",
        text: vitalSign.calificadorDeFrecuenciaRespiratoria ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Temperatura (celsius)",
        hintText: "No registra",
        text: "${vitalSign.temperaturaCelsius ?? ""}",
        rightIcon: Icons.device_thermostat_outlined,
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Peso (kilogramos)",
        hintText: "No registra",
        text: "${vitalSign.pesoKg ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
      ),
      SizedBox(
        width: freeSize ? null : 220,
        child: Row(
          children: [
            CustomInputWithLabel(
              size: customSize,
              readOnly: !allowEditFields,
              title: "Altura (metros)",
              hintText: "No registra",
              text: "${vitalSign.alturaMetros ?? ""}",
              lines: 1,
              width: freeSize ? null : 100,
              height: freeSize ? null : 108,
            ),
            const SizedBox(width: 20),
            CustomInputWithLabel(
              size: customSize,
              readOnly: !allowEditFields,
              title: "Saturación de oxígeno",
              hintText: "No registra",
              text: "${vitalSign.saturacionDeOxigeno ?? ""}",
              lines: 1,
              width: freeSize ? null : 100,
              height: freeSize ? null : 108,
            ),
          ],
        ),
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Pérdida de conciencia",
        hintText: "No registra",
        text: vitalSign.perdidaDeConciencia ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Duración de pérdida de conciencia",
        hintText: "No registra",
        text: (vitalSign.duracionDePerdidaDeConciencia ?? "").toString(),
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "GCS motora",
        hintText: "No registra",
        text: "${vitalSign.gcsMotora ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
      ),
      SizedBox(
        width: freeSize ? null : 220,
        child: Row(
          children: [
            CustomInputWithLabel(
              size: customSize,
              readOnly: !allowEditFields,
              title: "GCS ocular",
              hintText: "No registra",
              text: "${vitalSign.gcsOcular ?? ""}",
              lines: 1,
              width: freeSize ? null : 100,
              height: freeSize ? null : 108,
            ),
            const SizedBox(width: 20),
            CustomInputWithLabel(
              size: customSize,
              readOnly: !allowEditFields,
              title: "GCS verbal",
              hintText: "No registra",
              text: "${vitalSign.gcsVerbal ?? ""}",
              lines: 1,
              width: freeSize ? null : 100,
              height: freeSize ? null : 108,
            ),
          ],
        ),
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "GCS total",
        hintText: "No registra",
        text: "${vitalSign.gcsTotal ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "AVUP",
        hintText: "No registra",
        text: vitalSign.avup ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 94,
      ),
    ];
  }
}
