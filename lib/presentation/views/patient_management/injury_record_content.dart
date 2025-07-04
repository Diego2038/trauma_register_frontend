import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/helpers/transform_data.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/injury_record.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/patient_data.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_icon_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class InjuryRecordContent extends StatelessWidget {
  const InjuryRecordContent({
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
      title: "Registro de lesión",
      index: 2,
      expandedWidget: _getCurrentPatientData(context).injuryRecord == null
          ? isCreating
              ? Center(
                  child: CustomIconButton(
                    onPressed: () {
                      final currentPatientData =
                          Provider.of<TraumaDataProvider>(context,
                                  listen: false)
                              .patientData!;
                      _getCurrentProvider(context).updatePatientData(
                          currentPatientData.copyWith(
                            injuryRecord: InjuryRecord(),
                          ),
                          true);
                    },
                  ),
                )
              : noDataWidget
          : CustomContainer(
              children: injuryRecordContent(
                context: context,
                customSize: customSize,
                injuryRecord: _getCurrentPatientData(context).injuryRecord!,
                isCreating: isCreating,
                freeSize: freeSize,
              ),
            ),
    );
  }

  List<Widget> injuryRecordContent({
    required BuildContext context,
    required InjuryRecord injuryRecord,
    required CustomSize customSize,
    required bool isCreating,
    required bool freeSize,
  }) {
    final traumaDataProvider = _getCurrentProvider(context);
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Consumo de alcohol",
        hintText: "No registra",
        text: injuryRecord.consumoDeAlcohol ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: patientData.injuryRecord!.copyWith(
                  consumoDeAlcohol:
                      TransformData.getTransformedValue<String>(value)),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Valor de alcoholemia",
        hintText: "No registra",
        text: "${injuryRecord.valorDeAlcoholemia ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: patientData.injuryRecord!.copyWith(
                  valorDeAlcoholemia:
                      TransformData.getTransformedValue<double>(value)),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Unidad de alcohol",
        hintText: "No registra",
        text: injuryRecord.unidadDeAlcohol ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: patientData.injuryRecord!.copyWith(
                  unidadDeAlcohol:
                      TransformData.getTransformedValue<String>(value)),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Otra sustancia de abuso",
        hintText: "No registra",
        text: injuryRecord.otraSustanciaDeAbuso ?? "",
        lines: 2,
        width: freeSize ? null : 460,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: patientData.injuryRecord!.copyWith(
                  otraSustanciaDeAbuso:
                      TransformData.getTransformedValue<String>(value)),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Dirección / nombre del lugar",
        hintText: "No registra",
        text: injuryRecord.direccionNombreDelLugar ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: patientData.injuryRecord!.copyWith(
                  direccionNombreDelLugar:
                      TransformData.getTransformedValue<String>(value)),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Ciudad del evento de la lesión",
        hintText: "No registra",
        text: injuryRecord.ciudadDeEventoDeLaLesion ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: patientData.injuryRecord!.copyWith(
                  ciudadDeEventoDeLaLesion:
                      TransformData.getTransformedValue<String>(value)),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Condado de lesiones",
        hintText: "No registra",
        text: injuryRecord.condadoDeLesiones ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: patientData.injuryRecord!.copyWith(
                  condadoDeLesiones:
                      TransformData.getTransformedValue<String>(value)),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Estado / provincia de lesiones",
        hintText: "No registra",
        text: injuryRecord.estadoProvinciaDeLesiones ?? "",
        lines: 1,
        width: freeSize ? null : 440,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: patientData.injuryRecord!.copyWith(
                  estadoProvinciaDeLesiones:
                      TransformData.getTransformedValue<String>(value)),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "País de lesiones",
        hintText: "No registra",
        text: injuryRecord.paisDeLesiones ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: patientData.injuryRecord!.copyWith(
                  paisDeLesiones:
                      TransformData.getTransformedValue<String>(value)),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Código postal de lesiones",
        hintText: "No registra",
        text: injuryRecord.codigoPostalDeLesiones ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: patientData.injuryRecord!.copyWith(
                  codigoPostalDeLesiones:
                      TransformData.getTransformedValue<String>(value)),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Fecha y hora del evento",
        hintText: "No registra",
        text: injuryRecord.fechaYHoraDelEvento != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(injuryRecord.fechaYHoraDelEvento!)
            : "",
        // rightIcon: Icons.calendar_month_outlined,
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: patientData.injuryRecord!.copyWith(
                  fechaYHoraDelEvento:
                      TransformData.getTransformedValue<DateTime>(value)),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Accidente de tráfico",
        hintText: "No registra",
        text: injuryRecord.accidenteDeTrafico != null
            ? injuryRecord.accidenteDeTrafico!
                ? 'Sí'
                : 'No'
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: patientData.injuryRecord!.copyWith(
                  accidenteDeTrafico:
                      TransformData.getTransformedValue<bool>(value)),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Tipo de vehículo",
        hintText: "No registra",
        text: injuryRecord.tipoDeVehiculo ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: patientData.injuryRecord!.copyWith(
                  tipoDeVehiculo:
                      TransformData.getTransformedValue<String>(value)),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Ocupante",
        hintText: "No registra",
        text: injuryRecord.ocupante ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: patientData.injuryRecord!.copyWith(
                  ocupante: TransformData.getTransformedValue<String>(value)),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Velocidad de colisión",
        hintText: "No registra",
        text: injuryRecord.velocidadDeColision ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: patientData.injuryRecord!.copyWith(
                  velocidadDeColision:
                      TransformData.getTransformedValue<String>(value)),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "SCQ (%)",
        hintText: "No registra",
        text: "${injuryRecord.scq ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: patientData.injuryRecord!
                  .copyWith(scq: TransformData.getTransformedValue<int>(value)),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Caída",
        hintText: "No registra",
        text: injuryRecord.caida != null
            ? injuryRecord.caida!
                ? 'Sí'
                : 'No'
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: patientData.injuryRecord!.copyWith(
                  caida: TransformData.getTransformedValue<bool>(value)),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Altura (metros)",
        hintText: "No registra",
        text: "${injuryRecord.alturaMetros ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: patientData.injuryRecord!.copyWith(
                  alturaMetros:
                      TransformData.getTransformedValue<double>(value)),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Tipo de superficie",
        hintText: "No registra",
        text: injuryRecord.tipoDeSuperficie ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: patientData.injuryRecord!.copyWith(
                  tipoDeSuperficie:
                      TransformData.getTransformedValue<String>(value)),
            ),
          );
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
