import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/action_type.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/enums/input_type.dart';
import 'package:trauma_register_frontend/core/helpers/content_options.dart';
import 'package:trauma_register_frontend/core/helpers/transform_data.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/custom/time_of_day.dart'
    as t;
import 'package:trauma_register_frontend/data/models/shared/optional.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/patient_data.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/vital_sign.dart';
import 'package:trauma_register_frontend/data/services/navigation_service.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_icon_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_modal.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class VitalSignContent extends StatelessWidget {
  const VitalSignContent({
    super.key,
    required this.noDataWidget,
    required this.customSize,
    required this.action,
    required this.freeSize,
  });

  final NormalText noDataWidget;
  final CustomSize customSize;
  final ActionType action;
  final bool freeSize;

  @override
  Widget build(BuildContext context) {
    final bool allowChanges =
        action == ActionType.crear || action == ActionType.actualizar;
    return ExpandableTitleWidget(
      title: "Signos vitales",
      index: 23,
      expandedWidget: _getCurrentPatientData(context).vitalSign == null ||
              _getCurrentPatientData(context).vitalSign!.isEmpty
          ? allowChanges
              ? Center(child: _addNewElement(context))
              : noDataWidget
          : SizedBox(
              width: double.infinity,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 10,
                spacing: 10,
                children: [
                  ..._getCurrentPatientData(context)
                      .vitalSign!
                      .asMap()
                      .entries
                      .map(
                        (entry) => _Content(
                          keyy: entry.key,
                          value: entry.value,
                          customSize: customSize,
                          action: action,
                          freeSize: freeSize,
                        ),
                      ),
                  if (allowChanges) _addNewElement(context),
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

  PatientData _getCurrentPatientData(BuildContext context) {
    return Provider.of<TraumaDataProvider>(context, listen: false).patientData!;
  }

  TraumaDataProvider _getCurrentProvider(BuildContext context) {
    return Provider.of<TraumaDataProvider>(context, listen: false);
  }
}

class _Content extends StatefulWidget {
  const _Content({
    required this.keyy,
    required this.value,
    required this.customSize,
    required this.action,
    required this.freeSize,
  });

  final int keyy;
  final VitalSign value;
  final CustomSize customSize;
  final ActionType action;
  final bool freeSize;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  late TextEditingController _frecuenciaCardiacaController;
  late TextEditingController _duracionPerdidaConcienciaController;

  @override
  void initState() {
    super.initState();
    _frecuenciaCardiacaController = TextEditingController(
        text: widget.value.fechaYHoraDeSignosVitales != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(widget.value.fechaYHoraDeSignosVitales!)
            : "");
    _duracionPerdidaConcienciaController = TextEditingController(
        text: (widget.value.duracionDePerdidaDeConciencia ?? "").toString());
  }

  @override
  void dispose() {
    _frecuenciaCardiacaController.dispose();
    _duracionPerdidaConcienciaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool allowChanges = widget.action == ActionType.crear ||
        widget.action == ActionType.actualizar;
    return CustomContainer(
      maxWidth: 600,
      showUpdateButton: widget.action == ActionType.actualizar,
      onUpdate: () async {
        final bool isANewElement =
            _getCurrentPatientData(context).vitalSign![widget.keyy].id == null;
        final bool confirmFlow = await CustomModal.showModal(
          context: context,
          title: null,
          text: isANewElement
              ? "¿Desea crear el nuevo elemento?"
              : "¿Desea confirmar la actualización?",
        );
        if (!confirmFlow) return;
        CustomModal.loadModal(context: context);
        final element = _getCurrentPatientData(context).vitalSign![widget.keyy];
        final id = _getCurrentPatientData(context).traumaRegisterRecordId!;
        final result = await (isANewElement
            ? _getCurrentProvider(context).createVitalSign(element, id)
            : _getCurrentProvider(context).updateVitalSign(element));
        if (isANewElement) {
          _updateElements(
            context: context,
            id: result.idElement,
            index: widget.keyy,
          );
        }
        NavigationService.pop();
        CustomModal.showModal(
          context: context,
          title: null,
          text: result.message!,
          showCancelButton: false,
        );
      },
      showDeleteButton: allowChanges,
      onDelete: () async {
        final bool isANewElement =
            _getCurrentPatientData(context).vitalSign![widget.keyy].id == null;
        if (widget.action == ActionType.actualizar && !isANewElement) {
          final deleteElement = await CustomModal.showModal(
            context: context,
            title: null,
            text: "¿Está seguro que desea eliminar el elemento?",
          );
          if (!deleteElement) return;
          CustomModal.loadModal(context: context);
          final result = await _getCurrentProvider(context).deleteVitalSignById(
              _getCurrentPatientData(context)
                  .vitalSign![widget.keyy]
                  .id
                  .toString());
          NavigationService.pop();
          CustomModal.showModal(
            context: context,
            title: null,
            text: result.message!,
            showCancelButton: false,
          );
        }
        _getCurrentProvider(context).updatePatientData(
          _getCurrentPatientData(context).copyWith(
            vitalSign: _getCurrentPatientData(context)
                .vitalSign
                ?.asMap()
                .entries
                .where((e) => e.key != widget.keyy)
                .map((e) => e.value)
                .toList(),
          ),
          true,
        );
      },
      children: vitalSignContent(
        context: context,
        index: widget.keyy,
        vitalSign: widget.value,
        customSize: widget.customSize,
        isCreating: allowChanges,
        freeSize: widget.freeSize,
      ),
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
    final bool isACreatedElement =
        _getCurrentPatientData(context).vitalSign?[index].recordId != null;
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: isACreatedElement,
        title: "ID del registro",
        hintText: "No registra",
        text: vitalSign.recordId != null
            ? (vitalSign.recordId ?? '').toString()
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        recordId: Optional<int?>.of(
                            TransformData.getTransformedValue<int>(value)))
                    : e.value)
                .toList(),
          ));
        },
      ),
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
        rightIcon: Icons.calendar_month_outlined,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
        inputType: InputType.datetime,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        fechaYHoraDeSignosVitales: Optional<DateTime?>.of(
                            TransformData.getTransformedValue<DateTime>(value)))
                    : e.value)
                .toList(),
          ));
        },
        controller: _frecuenciaCardiacaController,
        onTap: () async {
          final DateTime? resultDate = await CustomModal.determineDate(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
            includeTime: true,
          );
          _frecuenciaCardiacaController.text = resultDate != null
              ? DateFormat('dd/MM/yyyy HH:mm:ss').format(resultDate)
              : "";
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        fechaYHoraDeSignosVitales: Optional<DateTime?>.of(
                            TransformData.getTransformedValue<DateTime>(
                                _frecuenciaCardiacaController.text)))
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
        inputType: InputType.boolean,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        signosDeVida: Optional<bool?>.of(
                            TransformData.getTransformedValue<bool>(value)))
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
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        frecuenciaCardiaca: Optional<int?>.of(
                            TransformData.getTransformedValue<int>(value)))
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
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        presionArterialSistolica: Optional<int?>.of(
                            TransformData.getTransformedValue<int>(value)))
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
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        presionArterialDiastolica: Optional<int?>.of(
                            TransformData.getTransformedValue<int>(value)))
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
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        frecuenciaRespiratoria: Optional<int?>.of(
                            TransformData.getTransformedValue<int>(value)))
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
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        calificadorDeFrecuenciaRespiratoria:
                            Optional<String?>.of(
                                TransformData.getTransformedValue<String>(
                                    value)))
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
        height: freeSize ? null : 108,
        inputType: InputType.double,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        temperaturaCelsius: Optional<double?>.of(
                            TransformData.getTransformedValue<double>(value)))
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
        inputType: InputType.double,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        pesoKg: Optional<double?>.of(
                            TransformData.getTransformedValue<double>(value)))
                    : e.value)
                .toList(),
          ));
        },
      ),
      if (!freeSize)
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
                inputType: InputType.double,
                onChanged: (String? value) {
                  final patientData = _getCurrentPatientData(context);
                  traumaDataProvider.updatePatientData(patientData.copyWith(
                    vitalSign: patientData.vitalSign
                        ?.asMap()
                        .entries
                        .map((e) => e.key == index
                            ? e.value.copyWith(
                                alturaMetros: Optional<double?>.of(
                                    TransformData.getTransformedValue<double>(
                                        value)))
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
                inputType: InputType.double,
                onChanged: (String? value) {
                  final patientData = _getCurrentPatientData(context);
                  traumaDataProvider.updatePatientData(patientData.copyWith(
                    vitalSign: patientData.vitalSign
                        ?.asMap()
                        .entries
                        .map((e) => e.key == index
                            ? e.value.copyWith(
                                saturacionDeOxigeno: Optional<double?>.of(
                                    TransformData.getTransformedValue<double>(
                                        value)))
                            : e.value)
                        .toList(),
                  ));
                },
              ),
            ],
          ),
        )
      else ...[
        CustomInputWithLabel(
          size: customSize,
          readOnly: !isCreating,
          title: "Altura (metros)",
          hintText: "No registra",
          text: "${vitalSign.alturaMetros ?? ""}",
          lines: 1,
          width: freeSize ? null : 100,
          height: freeSize ? null : 108,
          inputType: InputType.double,
          onChanged: (String? value) {
            final patientData = _getCurrentPatientData(context);
            traumaDataProvider.updatePatientData(patientData.copyWith(
              vitalSign: patientData.vitalSign
                  ?.asMap()
                  .entries
                  .map((e) => e.key == index
                      ? e.value.copyWith(
                          alturaMetros: Optional<double?>.of(
                              TransformData.getTransformedValue<double>(value)))
                      : e.value)
                  .toList(),
            ));
          },
        ),
        CustomInputWithLabel(
          size: customSize,
          readOnly: !isCreating,
          title: "Saturación de oxígeno",
          hintText: "No registra",
          text: "${vitalSign.saturacionDeOxigeno ?? ""}",
          lines: 1,
          width: freeSize ? null : 100,
          height: freeSize ? null : 108,
          inputType: InputType.double,
          onChanged: (String? value) {
            final patientData = _getCurrentPatientData(context);
            traumaDataProvider.updatePatientData(patientData.copyWith(
              vitalSign: patientData.vitalSign
                  ?.asMap()
                  .entries
                  .map((e) => e.key == index
                      ? e.value.copyWith(
                          saturacionDeOxigeno: Optional<double?>.of(
                              TransformData.getTransformedValue<double>(value)))
                      : e.value)
                  .toList(),
            ));
          },
        ),
      ],
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Pérdida de conciencia",
        hintText: "No registra",
        text: vitalSign.perdidaDeConciencia ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        perdidaDeConciencia: Optional<String?>.of(
                            TransformData.getTransformedValue<String>(value)))
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
        rightIcon: FontAwesomeIcons.clock,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
        inputType: InputType.time,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        duracionDePerdidaDeConciencia:
                            Optional<t.TimeOfDay?>.of(
                                TransformData.getTransformedValue<t.TimeOfDay>(
                                    value)))
                    : e.value)
                .toList(),
          ));
        },
        controller: _duracionPerdidaConcienciaController,
        onTap: () async {
          final String? hour = await CustomModal.determineTimeWithSeconds(
            context: context,
            focusNode: FocusNode(),
          );
          _duracionPerdidaConcienciaController.text = hour ?? '';
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        duracionDePerdidaDeConciencia:
                            Optional<t.TimeOfDay?>.of(
                                TransformData.getTransformedValue<t.TimeOfDay>(
                                    _duracionPerdidaConcienciaController.text)))
                    : e.value)
                .toList(),
          ));
        },
      ),
      if (!freeSize)
        SizedBox(
          width: freeSize ? null : 220,
          child: Row(
            children: [
              CustomInputWithLabel(
                size: customSize,
                readOnly: !isCreating,
                title: "GCS motora",
                hintText: "No registra",
                text: "${vitalSign.gcsMotora ?? ""}",
                lines: 1,
                width: freeSize ? null : 100,
                height: freeSize ? null : 108,
                inputType: InputType.integer,
                onChanged: (String? value) {
                  final patientData = _getCurrentPatientData(context);
                  traumaDataProvider.updatePatientData(patientData.copyWith(
                    vitalSign: patientData.vitalSign
                        ?.asMap()
                        .entries
                        .map((e) => e.key == index
                            ? e.value.copyWith(
                                gcsMotora: Optional<int?>.of(
                                    TransformData.getTransformedValue<int>(
                                        value)))
                            : e.value)
                        .toList(),
                  ));
                },
              ),
              const SizedBox(width: 20),
              CustomInputWithLabel(
                size: customSize,
                readOnly: !isCreating,
                title: "GCS ocular",
                hintText: "No registra",
                text: "${vitalSign.gcsOcular ?? ""}",
                lines: 1,
                width: freeSize ? null : 100,
                height: freeSize ? null : 108,
                inputType: InputType.integer,
                onChanged: (String? value) {
                  final patientData = _getCurrentPatientData(context);
                  traumaDataProvider.updatePatientData(patientData.copyWith(
                    vitalSign: patientData.vitalSign
                        ?.asMap()
                        .entries
                        .map((e) => e.key == index
                            ? e.value.copyWith(
                                gcsOcular: Optional<int?>.of(
                                    TransformData.getTransformedValue<int>(
                                        value)))
                            : e.value)
                        .toList(),
                  ));
                },
              ),
            ],
          ),
        )
      else ...[
        CustomInputWithLabel(
          size: customSize,
          readOnly: !isCreating,
          title: "GCS motora",
          hintText: "No registra",
          text: "${vitalSign.gcsMotora ?? ""}",
          lines: 1,
          width: freeSize ? null : 100,
          height: freeSize ? null : 108,
          inputType: InputType.integer,
          onChanged: (String? value) {
            final patientData = _getCurrentPatientData(context);
            traumaDataProvider.updatePatientData(patientData.copyWith(
              vitalSign: patientData.vitalSign
                  ?.asMap()
                  .entries
                  .map((e) => e.key == index
                      ? e.value.copyWith(
                          gcsMotora: Optional<int?>.of(
                              TransformData.getTransformedValue<int>(value)))
                      : e.value)
                  .toList(),
            ));
          },
        ),
        CustomInputWithLabel(
          size: customSize,
          readOnly: !isCreating,
          title: "GCS ocular",
          hintText: "No registra",
          text: "${vitalSign.gcsOcular ?? ""}",
          lines: 1,
          width: freeSize ? null : 100,
          height: freeSize ? null : 108,
          inputType: InputType.integer,
          onChanged: (String? value) {
            final patientData = _getCurrentPatientData(context);
            traumaDataProvider.updatePatientData(patientData.copyWith(
              vitalSign: patientData.vitalSign
                  ?.asMap()
                  .entries
                  .map((e) => e.key == index
                      ? e.value.copyWith(
                          gcsOcular: Optional<int?>.of(
                              TransformData.getTransformedValue<int>(value)))
                      : e.value)
                  .toList(),
            ));
          },
        ),
      ],
      if (!freeSize)
        SizedBox(
          width: freeSize ? null : 220,
          child: Row(
            children: [
              CustomInputWithLabel(
                size: customSize,
                readOnly: !isCreating,
                title: "GCS verbal",
                hintText: "No registra",
                text: "${vitalSign.gcsVerbal ?? ""}",
                lines: 1,
                width: freeSize ? null : 100,
                height: freeSize ? null : 94,
                inputType: InputType.integer,
                onChanged: (String? value) {
                  final patientData = _getCurrentPatientData(context);
                  traumaDataProvider.updatePatientData(patientData.copyWith(
                    vitalSign: patientData.vitalSign
                        ?.asMap()
                        .entries
                        .map((e) => e.key == index
                            ? e.value.copyWith(
                                gcsVerbal: Optional<int?>.of(
                                    TransformData.getTransformedValue<int>(
                                        value)))
                            : e.value)
                        .toList(),
                  ));
                },
              ),
              const SizedBox(width: 20),
              CustomInputWithLabel(
                size: customSize,
                readOnly: !isCreating,
                title: "GCS total",
                hintText: "No registra",
                text: "${vitalSign.gcsTotal ?? ""}",
                lines: 1,
                width: freeSize ? null : 100,
                height: freeSize ? null : 94,
                inputType: InputType.integer,
                onChanged: (String? value) {
                  final patientData = _getCurrentPatientData(context);
                  traumaDataProvider.updatePatientData(patientData.copyWith(
                    vitalSign: patientData.vitalSign
                        ?.asMap()
                        .entries
                        .map((e) => e.key == index
                            ? e.value.copyWith(
                                gcsTotal: Optional<int?>.of(
                                    TransformData.getTransformedValue<int>(
                                        value)))
                            : e.value)
                        .toList(),
                  ));
                },
              ),
            ],
          ),
        )
      else ...[
        CustomInputWithLabel(
          size: customSize,
          readOnly: !isCreating,
          title: "GCS verbal",
          hintText: "No registra",
          text: "${vitalSign.gcsVerbal ?? ""}",
          lines: 1,
          width: freeSize ? null : 100,
          height: freeSize ? null : 94,
          inputType: InputType.integer,
          onChanged: (String? value) {
            final patientData = _getCurrentPatientData(context);
            traumaDataProvider.updatePatientData(patientData.copyWith(
              vitalSign: patientData.vitalSign
                  ?.asMap()
                  .entries
                  .map((e) => e.key == index
                      ? e.value.copyWith(
                          gcsVerbal: Optional<int?>.of(
                              TransformData.getTransformedValue<int>(value)))
                      : e.value)
                  .toList(),
            ));
          },
        ),
        CustomInputWithLabel(
          size: customSize,
          readOnly: !isCreating,
          title: "GCS total",
          hintText: "No registra",
          text: "${vitalSign.gcsTotal ?? ""}",
          lines: 1,
          width: freeSize ? null : 100,
          height: freeSize ? null : 94,
          inputType: InputType.integer,
          onChanged: (String? value) {
            final patientData = _getCurrentPatientData(context);
            traumaDataProvider.updatePatientData(patientData.copyWith(
              vitalSign: patientData.vitalSign
                  ?.asMap()
                  .entries
                  .map((e) => e.key == index
                      ? e.value.copyWith(
                          gcsTotal: Optional<int?>.of(
                              TransformData.getTransformedValue<int>(value)))
                      : e.value)
                  .toList(),
            ));
          },
        ),
      ],
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "AVUP",
        hintText: "No registra",
        text: vitalSign.avup ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 94,
        suggestions: ContentOptions.vitalSign.avup,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            vitalSign: patientData.vitalSign
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        avup: Optional<String?>.of(
                            TransformData.getTransformedValue<String>(value)))
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

  void _updateElements({
    required BuildContext context,
    required int? id,
    required int index,
  }) {
    final traumaDataProvider = _getCurrentProvider(context);
    final patientData = _getCurrentPatientData(context);
    final elements = patientData.vitalSign;
    if (elements == null) return;
    elements[index] = elements[index].copyWith(id: id);
    traumaDataProvider.updatePatientData(patientData.copyWith(
      vitalSign: elements,
    ));
  }
}
