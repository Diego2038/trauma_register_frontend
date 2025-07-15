import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/action_type.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/enums/input_type.dart';
import 'package:trauma_register_frontend/core/helpers/content_options.dart';
import 'package:trauma_register_frontend/core/helpers/transform_data.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/shared/optional.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/injury_record.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/patient_data.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_icon_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_modal.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class InjuryRecordContent extends StatelessWidget {
  const InjuryRecordContent({
    super.key,
    required this.noDataWidget,
    required this.customSize,
    required this.freeSize,
    required this.action,
  });

  final NormalText noDataWidget;
  final CustomSize customSize;
  final bool freeSize;
  final ActionType action;

  @override
  Widget build(BuildContext context) {
    final bool allowChanges =
        action == ActionType.crear || action == ActionType.actualizar;
    return ExpandableTitleWidget(
      title: "Registro de lesión",
      index: 2,
      expandedWidget: _getCurrentPatientData(context).injuryRecord == null
          ? allowChanges
              ? Center(
                  child: CustomIconButton(
                    onPressed: () {
                      final currentPatientData =
                          Provider.of<TraumaDataProvider>(context,
                                  listen: false)
                              .patientData!;
                      _getCurrentProvider(context).updatePatientData(
                          currentPatientData.copyWith(
                            injuryRecord:
                                Optional<InjuryRecord?>.of(InjuryRecord()),
                          ),
                          true);
                    },
                  ),
                )
              : noDataWidget
          : _Content(
              customSize: customSize,
              freeSize: freeSize,
              action: action,
            ),
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
    required this.customSize,
    required this.freeSize,
    required this.action,
  });

  final CustomSize customSize;
  final bool freeSize;
  final ActionType action;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  late TextEditingController _fechaYHoraDelEventoController;

  @override
  void initState() {
    super.initState();
    final injuryRecord = _getCurrentPatientData(context).injuryRecord!;
    _fechaYHoraDelEventoController = TextEditingController(
        text: injuryRecord.fechaYHoraDelEvento != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(injuryRecord.fechaYHoraDelEvento!)
            : "");
  }

  @override
  void dispose() {
    _fechaYHoraDelEventoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool allowChanges = widget.action == ActionType.crear ||
        widget.action == ActionType.actualizar;
    return CustomContainer(
      showUpdateButton: widget.action == ActionType.actualizar,
      onUpdate: () async {
        final element = _getCurrentPatientData(context).injuryRecord!;
        final bool isANewElement = element.id == null;
        final bool confirmFlow = await CustomModal.showModal(
          context: context,
          title: null,
          text: isANewElement
              ? "¿Desea crear el nuevo elemento?"
              : "¿Desea confirmar la actualización?",
        );
        if (!confirmFlow) return;
        final id = _getCurrentPatientData(context).traumaRegisterRecordId!;
        final result = await (isANewElement
            ? _getCurrentProvider(context).createInjuryRecord(element, id)
            : _getCurrentProvider(context).updateInjuryRecord(element, id));
        CustomModal.showModal(
          context: context,
          title: null,
          text: result.message!,
          showCancelButton: false,
        );
      },
      showDeleteButton: allowChanges,
      onDelete: () async {
        final element = _getCurrentPatientData(context).injuryRecord!;
        if (widget.action == ActionType.actualizar && element.id != null) {
          final deleteElement = await CustomModal.showModal(
            context: context,
            title: null,
            text: "¿Está seguro que desea eliminar el elemento?",
          );
          if (!deleteElement) return;
          final result = await _getCurrentProvider(context)
              .deleteInjuryRecordById(_getCurrentPatientData(context)
                  .traumaRegisterRecordId
                  .toString());
          CustomModal.showModal(
            context: context,
            title: null,
            text: result.message!,
            showCancelButton: false,
          );
        }
        _getCurrentProvider(context).updatePatientData(
          _getCurrentPatientData(context).copyWith(
            injuryRecord: const Optional<InjuryRecord?>.of(null),
          ),
          true,
        );
      },
      children: injuryRecordContent(
        context: context,
        customSize: widget.customSize,
        isCreating: allowChanges,
        freeSize: widget.freeSize,
      ),
    );
  }

  List<Widget> injuryRecordContent({
    required BuildContext context,
    required CustomSize customSize,
    required bool isCreating,
    required bool freeSize,
  }) {
    final traumaDataProvider = _getCurrentProvider(context);
    final injuryRecord = _getCurrentPatientData(context).injuryRecord!;
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
        suggestions: ContentOptions.injuryRecord.consumoDeAlcohol,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: Optional<InjuryRecord?>.of(patientData.injuryRecord!
                  .copyWith(
                      consumoDeAlcohol: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
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
        inputType: InputType.double,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: Optional<InjuryRecord?>.of(patientData.injuryRecord!
                  .copyWith(
                      valorDeAlcoholemia: Optional<double?>.of(
                          TransformData.getTransformedValue<double>(value)))),
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
        suggestions: ContentOptions.injuryRecord.unidadDeAlcohol,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: Optional<InjuryRecord?>.of(patientData.injuryRecord!
                  .copyWith(
                      unidadDeAlcohol: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
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
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: Optional<InjuryRecord?>.of(patientData.injuryRecord!
                  .copyWith(
                      otraSustanciaDeAbuso: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
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
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: Optional<InjuryRecord?>.of(patientData.injuryRecord!
                  .copyWith(
                      direccionNombreDelLugar: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
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
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: Optional<InjuryRecord?>.of(patientData.injuryRecord!
                  .copyWith(
                      ciudadDeEventoDeLaLesion: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
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
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: Optional<InjuryRecord?>.of(patientData.injuryRecord!
                  .copyWith(
                      condadoDeLesiones: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
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
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: Optional<InjuryRecord?>.of(patientData.injuryRecord!
                  .copyWith(
                      estadoProvinciaDeLesiones: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
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
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: Optional<InjuryRecord?>.of(patientData.injuryRecord!
                  .copyWith(
                      paisDeLesiones: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
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
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: Optional<InjuryRecord?>.of(patientData.injuryRecord!
                  .copyWith(
                      codigoPostalDeLesiones: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
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
        lines: 1,
        rightIcon: Icons.calendar_month_outlined,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.datetime,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: Optional<InjuryRecord?>.of(patientData.injuryRecord!
                  .copyWith(
                      fechaYHoraDelEvento: Optional<DateTime?>.of(
                          TransformData.getTransformedValue<DateTime>(value)))),
            ),
          );
        },
        controller: _fechaYHoraDelEventoController,
        onTap: () async {
          final DateTime? resultDate = await CustomModal.determineDate(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
            includeTime: true,
          );
          _fechaYHoraDelEventoController.text = resultDate != null
              ? DateFormat('dd/MM/yyyy HH:mm:ss').format(resultDate)
              : "";
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: Optional<InjuryRecord?>.of(patientData.injuryRecord!
                  .copyWith(
                      fechaYHoraDelEvento: Optional<DateTime?>.of(
                          TransformData.getTransformedValue<DateTime>(
                              _fechaYHoraDelEventoController.text)))),
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
        inputType: InputType.boolean,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: Optional<InjuryRecord?>.of(patientData.injuryRecord!
                  .copyWith(
                      accidenteDeTrafico: Optional<bool?>.of(
                          TransformData.getTransformedValue<bool>(value)))),
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
        suggestions: ContentOptions.injuryRecord.tipoDeVehiculo,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: Optional<InjuryRecord?>.of(patientData.injuryRecord!
                  .copyWith(
                      tipoDeVehiculo: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
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
        suggestions: ContentOptions.injuryRecord.ocupante,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: Optional<InjuryRecord?>.of(patientData.injuryRecord!
                  .copyWith(
                      ocupante: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
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
        suggestions: ContentOptions.injuryRecord.velocidadDeColision,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: Optional<InjuryRecord?>.of(patientData.injuryRecord!
                  .copyWith(
                      velocidadDeColision: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
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
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: Optional<InjuryRecord?>.of(patientData.injuryRecord!
                  .copyWith(
                      scq: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
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
        inputType: InputType.boolean,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: Optional<InjuryRecord?>.of(patientData.injuryRecord!
                  .copyWith(
                      caida: Optional<bool?>.of(
                          TransformData.getTransformedValue<bool>(value)))),
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
        inputType: InputType.double,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: Optional<InjuryRecord?>.of(patientData.injuryRecord!
                  .copyWith(
                      alturaMetros: Optional<double?>.of(
                          TransformData.getTransformedValue<double>(value)))),
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
        suggestions: ContentOptions.injuryRecord.tipoDeSuperficie,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              injuryRecord: Optional<InjuryRecord?>.of(patientData.injuryRecord!
                  .copyWith(
                      tipoDeSuperficie: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
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
