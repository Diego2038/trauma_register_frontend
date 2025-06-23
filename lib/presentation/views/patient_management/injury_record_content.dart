import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/injury_record.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class InjuryRecordContent extends StatelessWidget {
  const InjuryRecordContent({
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
      title: "Registro de lesión",
      index: 2,
      expandedWidget: traumaDataProvider.patientData!.injuryRecord == null
          ? noDataWidget
          : CustomContainer(
              children: injuryRecordContent(
                customSize: customSize,
                injuryRecord: traumaDataProvider.patientData!.injuryRecord!,
                allowEditFields: allowEditFields,
                traumaDataProvider: traumaDataProvider,
                freeSize: freeSize,
              ),
            ),
    );
  }

  List<Widget> injuryRecordContent({
    required InjuryRecord injuryRecord,
    required CustomSize customSize,
    required bool allowEditFields,
    required TraumaDataProvider traumaDataProvider,
    required bool freeSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Consumo de alcohol",
        hintText: "No registra",
        text: injuryRecord.consumoDeAlcohol ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Valor de alcoholemia",
        hintText: "No registra",
        text: "${injuryRecord.valorDeAlcoholemia ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Unidad de alcohol",
        hintText: "No registra",
        text: injuryRecord.unidadDeAlcohol ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Otra sustancia de abuso",
        hintText: "No registra",
        text: injuryRecord.otraSustanciaDeAbuso ?? "",
        lines: 2,
        width: freeSize ? null : 460,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Dirección / nombre del lugar",
        hintText: "No registra",
        text: injuryRecord.direccionNombreDelLugar ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Ciudad del evento de la lesión",
        hintText: "No registra",
        text: injuryRecord.ciudadDeEventoDeLaLesion ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Condado de lesiones",
        hintText: "No registra",
        text: injuryRecord.condadoDeLesiones ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Estado / provincia de lesiones",
        hintText: "No registra",
        text: injuryRecord.estadoProvinciaDeLesiones ?? "",
        lines: 1,
        width: freeSize ? null : 440,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "País de lesiones",
        hintText: "No registra",
        text: injuryRecord.paisDeLesiones ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Código postal de lesiones",
        hintText: "No registra",
        text: injuryRecord.codigoPostalDeLesiones ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
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
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
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
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tipo de vehículo",
        hintText: "No registra",
        text: injuryRecord.tipoDeVehiculo ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Ocupante",
        hintText: "No registra",
        text: injuryRecord.ocupante ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Velocidad de colisión",
        hintText: "No registra",
        text: injuryRecord.velocidadDeColision ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "SCQ (%)",
        hintText: "No registra",
        text: "${injuryRecord.scq ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
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
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Altura (metros)",
        hintText: "No registra",
        text: "${injuryRecord.alturaMetros ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tipo de superficie",
        hintText: "No registra",
        text: injuryRecord.tipoDeSuperficie ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
    ];
  }
}
