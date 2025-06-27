import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/helpers/transform_data.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/custom/time_of_day.dart'
    as t;
import 'package:trauma_register_frontend/data/models/trauma_data/patient_data.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/vital_sign.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_icon_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class VitalSignContent extends StatelessWidget {
  const VitalSignContent({
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
      title: "Signos vitales",
      index: 23,
      expandedWidget: _getCurrentPatientData(context).vitalSign == null ||
              _getCurrentPatientData(context).vitalSign!.isEmpty
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
                      .vitalSign!
                      .asMap()
                      .entries
                      .map(
                        (entry) => CustomContainer(
                          maxWidth: 600,
                          children: vitalSignContent(
                            context: context,
                            index: entry.key,
                            vitalSign: entry.value,
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
        final currentElements = currentPatientData.vitalSign;
        final traumaDataProvider = _getCurrentProvider(context);
        traumaDataProvider.updatePatientData(
            currentPatientData.copyWith(
              vitalSign: [
                if (currentElements != null) ...currentElements,
                VitalSign(),
              ],
            ),
            true);
      },
    );
  }

  List<Widget> vitalSignContent({
    required BuildContext context,
    required int index,
    required VitalSign vitalSign,
    required CustomSize customSize,
    required bool isCreating,
    required bool freeSize,
  }) {
    final traumaDataProvider = _getCurrentProvider(context);
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Fecha y hora de la variable",
        hintText: "No registra",
        text: vitalSign.fechaYHoraDeSignosVitales != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(vitalSign.fechaYHoraDeSignosVitales!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        fechaYHoraDeSignosVitales:
                            TransformData.getTransformedValue<DateTime>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        signosDeVida:
                            TransformData.getTransformedValue<bool>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Frecuencia cardiaca",
        hintText: "No registra",
        text: "${vitalSign.frecuenciaCardiaca ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        frecuenciaCardiaca:
                            TransformData.getTransformedValue<int>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Presión arterial sistólica",
        hintText: "No registra",
        text: "${vitalSign.presionArterialSistolica ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        presionArterialSistolica:
                            TransformData.getTransformedValue<int>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Presión arterial diastólica",
        hintText: "No registra",
        text: "${vitalSign.presionArterialDiastolica ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        presionArterialDiastolica:
                            TransformData.getTransformedValue<int>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Frecuencia respiratoria",
        hintText: "No registra",
        text: "${vitalSign.frecuenciaRespiratoria ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        frecuenciaRespiratoria:
                            TransformData.getTransformedValue<int>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Calificador de frecuencia respiratoria",
        hintText: "No registra",
        text: vitalSign.calificadorDeFrecuenciaRespiratoria ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        calificadorDeFrecuenciaRespiratoria:
                            TransformData.getTransformedValue<String>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Temperatura (celsius)",
        hintText: "No registra",
        text: "${vitalSign.temperaturaCelsius ?? ""}",
        rightIcon: Icons.device_thermostat_outlined,
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        temperaturaCelsius:
                            TransformData.getTransformedValue<double>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Peso (kilogramos)",
        hintText: "No registra",
        text: "${vitalSign.pesoKg ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        pesoKg:
                            TransformData.getTransformedValue<double>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      SizedBox(
        width: freeSize ? null : 220,
        child: Row(
          children: [
            CustomInputWithLabel(
              size: customSize,
              readOnly: !isCreating,
              title: "Altura (metros)",
              hintText: "No registra",
              text: "${vitalSign.alturaMetros ?? ""}",
              lines: 1,
              width: freeSize ? null : 100,
              height: freeSize ? null : 108,
              onChanged: (String? value) {
                final patientData = _getCurrentPatientData(context);
                traumaDataProvider.updatePatientData(patientData.copyWith(
                  vitalSign: patientData.vitalSign
                      ?.asMap()
                      .entries
                      .map((e) => e.key == index
                          ? e.value.copyWith(
                              alturaMetros:
                                  TransformData.getTransformedValue<double>(
                                      value))
                          : e.value)
                      .toList(),
                ));
              },
            ),
            const SizedBox(width: 20),
            CustomInputWithLabel(
              size: customSize,
              readOnly: !isCreating,
              title: "Saturación de oxígeno",
              hintText: "No registra",
              text: "${vitalSign.saturacionDeOxigeno ?? ""}",
              lines: 1,
              width: freeSize ? null : 100,
              height: freeSize ? null : 108,
              onChanged: (String? value) {
                final patientData = _getCurrentPatientData(context);
                traumaDataProvider.updatePatientData(patientData.copyWith(
                  vitalSign: patientData.vitalSign
                      ?.asMap()
                      .entries
                      .map((e) => e.key == index
                          ? e.value.copyWith(
                              saturacionDeOxigeno:
                                  TransformData.getTransformedValue<double>(
                                      value))
                          : e.value)
                      .toList(),
                ));
              },
            ),
          ],
        ),
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Pérdida de conciencia",
        hintText: "No registra",
        text: vitalSign.perdidaDeConciencia ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        perdidaDeConciencia:
                            TransformData.getTransformedValue<String>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Duración de pérdida de conciencia",
        hintText: "No registra",
        text: (vitalSign.duracionDePerdidaDeConciencia ?? "").toString(),
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        duracionDePerdidaDeConciencia:
                            TransformData.getTransformedValue<t.TimeOfDay>(
                                value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "GCS motora",
        hintText: "No registra",
        text: "${vitalSign.gcsMotora ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        gcsMotora:
                            TransformData.getTransformedValue<int>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      SizedBox(
        width: freeSize ? null : 220,
        child: Row(
          children: [
            CustomInputWithLabel(
              size: customSize,
              readOnly: !isCreating,
              title: "GCS ocular",
              hintText: "No registra",
              text: "${vitalSign.gcsOcular ?? ""}",
              lines: 1,
              width: freeSize ? null : 100,
              height: freeSize ? null : 108,
              onChanged: (String? value) {
                final patientData = _getCurrentPatientData(context);
                traumaDataProvider.updatePatientData(patientData.copyWith(
                  vitalSign: patientData.vitalSign
                      ?.asMap()
                      .entries
                      .map((e) => e.key == index
                          ? e.value.copyWith(
                              gcsOcular:
                                  TransformData.getTransformedValue<int>(value))
                          : e.value)
                      .toList(),
                ));
              },
            ),
            const SizedBox(width: 20),
            CustomInputWithLabel(
              size: customSize,
              readOnly: !isCreating,
              title: "GCS verbal",
              hintText: "No registra",
              text: "${vitalSign.gcsVerbal ?? ""}",
              lines: 1,
              width: freeSize ? null : 100,
              height: freeSize ? null : 108,
              onChanged: (String? value) {
                final patientData = _getCurrentPatientData(context);
                traumaDataProvider.updatePatientData(patientData.copyWith(
                  vitalSign: patientData.vitalSign
                      ?.asMap()
                      .entries
                      .map((e) => e.key == index
                          ? e.value.copyWith(
                              gcsVerbal:
                                  TransformData.getTransformedValue<int>(value))
                          : e.value)
                      .toList(),
                ));
              },
            ),
          ],
        ),
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "GCS total",
        hintText: "No registra",
        text: "${vitalSign.gcsTotal ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 94,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        gcsTotal: TransformData.getTransformedValue<int>(value))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "AVUP",
        hintText: "No registra",
        text: vitalSign.avup ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 94,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        avup: TransformData.getTransformedValue<String>(value))
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
