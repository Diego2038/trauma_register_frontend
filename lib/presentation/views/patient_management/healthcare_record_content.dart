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
import 'package:trauma_register_frontend/data/models/shared/optional.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/healthcare_record.dart';
import 'package:trauma_register_frontend/data/models/custom/time_of_day.dart'
    as t;
import 'package:trauma_register_frontend/data/models/trauma_data/patient_data.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_icon_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_modal.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class HealthcareRecordContent extends StatelessWidget {
  const HealthcareRecordContent({
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
      title: "Registro de atención médica",
      index: 1,
      expandedWidget: _getCurrentPatientData(context).healthcareRecord == null
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
                            healthcareRecord: Optional<HealthcareRecord?>.of(
                                HealthcareRecord()),
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
  late TextEditingController _fechaYHoraDeLlegadaDelPacienteController;
  late TextEditingController _fechaYHoraDeLlegadaDelMedicoController;
  late TextEditingController _fechaYHoraDeNotificacionAlMedicoController;
  late TextEditingController _fechaYHoraDeLaDisposicionController;
  late TextEditingController _fechaDeAdmisionController;
  late TextEditingController _fechaYHoraDeAltaController;
  late TextEditingController _fechaYHoraDeNotificacionPreHospitalariaController;
  late TextEditingController _fechaYHoraDeLlegadaALaEscenaController;
  late TextEditingController _fechaYHoraDeSalidaDeLaEscenaController;
  late TextEditingController _duracionDePerdidaDeConcienciaController;
  late TextEditingController _fechaYHoraDeEnvioDeContraReferenciaController;
  late TextEditingController _fechaDeAltaDeContrarReferenciaController;
  late TextEditingController _fechaDeEnvioDeReferenciaController;
  late TextEditingController _fechaDeReferenciaController;
  late TextEditingController _fechaDeAceptacionDeReferenciaController;

  @override
  void initState() {
    super.initState();
    final healthcareRecord = _getCurrentPatientData(context).healthcareRecord!;

    _fechaYHoraDeLlegadaDelPacienteController = TextEditingController(
        text: healthcareRecord.fechaYHoraDeLlegadaDelPaciente != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeLlegadaDelPaciente!)
            : "");
    _fechaYHoraDeLlegadaDelMedicoController = TextEditingController(
        text: healthcareRecord.fechaYHoraDeLlegadaDelMedico != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeLlegadaDelMedico!)
            : "");
    _fechaYHoraDeNotificacionAlMedicoController = TextEditingController(
        text: healthcareRecord.fechaYHoraDeNotificacionAlMedico != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeNotificacionAlMedico!)
            : "");
    _fechaYHoraDeLaDisposicionController = TextEditingController(
        text: healthcareRecord.fechaYHoraDeLaDisposicion != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeLaDisposicion!)
            : "");
    _fechaDeAdmisionController = TextEditingController(
        text: healthcareRecord.fechaDeAdmision != null
            ? DateFormat('dd/MM/yyyy').format(healthcareRecord.fechaDeAdmision!)
            : "");
    _fechaYHoraDeAltaController = TextEditingController(
        text: healthcareRecord.fechaYHoraDeAlta != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeAlta!)
            : "");
    _fechaYHoraDeNotificacionPreHospitalariaController = TextEditingController(
        text: healthcareRecord.fechaYHoraDeNotificacionPreHospitalaria != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss').format(
                healthcareRecord.fechaYHoraDeNotificacionPreHospitalaria!)
            : "");
    _fechaYHoraDeLlegadaALaEscenaController = TextEditingController(
        text: healthcareRecord.fechaYHoraDeLlegadaALaEscena != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeLlegadaALaEscena!)
            : "");
    _fechaYHoraDeSalidaDeLaEscenaController = TextEditingController(
        text: healthcareRecord.fechaYHoraDeSalidaDeLaEscena != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeSalidaDeLaEscena!)
            : "");
    _duracionDePerdidaDeConcienciaController = TextEditingController(
        text:
            (healthcareRecord.duracionDePerdidaDeConciencia ?? "").toString());
    _fechaYHoraDeEnvioDeContraReferenciaController = TextEditingController(
        text: healthcareRecord.fechaYHoraDeEnvioDeContraReferencia != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeEnvioDeContraReferencia!)
            : "");
    _fechaDeAltaDeContrarReferenciaController = TextEditingController(
        text: healthcareRecord.fechaDeAltaDeContrarReferencia != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaDeAltaDeContrarReferencia!)
            : "");
    _fechaDeEnvioDeReferenciaController = TextEditingController(
        text: healthcareRecord.fechaDeEnvioDeReferencia != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaDeEnvioDeReferencia!)
            : "");
    _fechaDeReferenciaController = TextEditingController(
        text: healthcareRecord.fechaDeReferencia != null
            ? DateFormat('dd/MM/yyyy')
                .format(healthcareRecord.fechaDeReferencia!)
            : "");
    _fechaDeAceptacionDeReferenciaController = TextEditingController(
        text: healthcareRecord.fechaDeAceptacionDeReferencia != null
            ? DateFormat('dd/MM/yyyy')
                .format(healthcareRecord.fechaDeAceptacionDeReferencia!)
            : "");
  }

  @override
  void dispose() {
    _fechaYHoraDeLlegadaDelPacienteController.dispose();
    _fechaYHoraDeLlegadaDelMedicoController.dispose();
    _fechaYHoraDeNotificacionAlMedicoController.dispose();
    _fechaYHoraDeLaDisposicionController.dispose();
    _fechaDeAdmisionController.dispose();
    _fechaYHoraDeAltaController.dispose();
    _fechaYHoraDeNotificacionPreHospitalariaController.dispose();
    _fechaYHoraDeLlegadaALaEscenaController.dispose();
    _fechaYHoraDeSalidaDeLaEscenaController.dispose();
    _duracionDePerdidaDeConcienciaController.dispose();
    _fechaYHoraDeEnvioDeContraReferenciaController.dispose();
    _fechaDeAltaDeContrarReferenciaController.dispose();
    _fechaDeEnvioDeReferenciaController.dispose();
    _fechaDeReferenciaController.dispose();
    _fechaDeAceptacionDeReferenciaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool allowChanges = widget.action == ActionType.crear ||
        widget.action == ActionType.actualizar;
    return CustomContainer(
      showUpdateButton: widget.action == ActionType.actualizar,
      onUpdate: () async {
        final element = _getCurrentPatientData(context).healthcareRecord!;
        final bool isANewElement =
            _getCurrentPatientData(context).healthcareRecord!.id == null;
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
            ? _getCurrentProvider(context).createHealthcareRecord(element, id)
            : _getCurrentProvider(context).updateHealthcareRecord(element));
        if (isANewElement) {
          _updateElement(
            context: context,
            id: result.idElement,
          );
        }
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
            _getCurrentPatientData(context).healthcareRecord!.id == null;
        if (widget.action == ActionType.actualizar && !isANewElement) {
          final deleteElement = await CustomModal.showModal(
            context: context,
            title: null,
            text: "¿Está seguro que desea eliminar el elemento?",
          );
          if (!deleteElement) return;
          final result = await _getCurrentProvider(context)
              .deleteHealthcareRecordById(_getCurrentPatientData(context)
                  .healthcareRecord!
                  .id
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
            healthcareRecord: const Optional<HealthcareRecord?>.of(null),
          ),
          true,
        );
      },
      children: healthcareRecordContent(
        context: context,
        customSize: widget.customSize,
        isCreating: allowChanges,
        freeSize: widget.freeSize,
      ),
    );
  }

  List<Widget> healthcareRecordContent({
    required BuildContext context,
    required CustomSize customSize,
    required bool isCreating,
    required bool freeSize,
  }) {
    final traumaDataProvider = _getCurrentProvider(context);
    final healthcareRecord = _getCurrentPatientData(context).healthcareRecord!;
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Número de historia clínica",
        hintText: "No registra",
        text: healthcareRecord.numeroDeHistoriaClinica ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      numeroDeHistoriaClinica: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Hospital",
        hintText: "No registra",
        text: healthcareRecord.hospital ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        suggestions: ContentOptions.healthcareRecord.hospital,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      hospital: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Fecha y hora de llegada del paciente",
        hintText: "No registra",
        text: healthcareRecord.fechaYHoraDeLlegadaDelPaciente != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeLlegadaDelPaciente!)
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
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaYHoraDeLlegadaDelPaciente: Optional<DateTime?>.of(
                          TransformData.getTransformedValue<DateTime>(value)))),
            ),
          );
        },
        controller: _fechaYHoraDeLlegadaDelPacienteController,
        onTap: () async {
          final DateTime? resultDate = await CustomModal.determineDate(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
            includeTime: true,
          );
          _fechaYHoraDeLlegadaDelPacienteController.text = resultDate != null
              ? DateFormat('dd/MM/yyyy HH:mm:ss').format(resultDate)
              : "";
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaYHoraDeLlegadaDelPaciente: Optional<DateTime?>.of(
                          TransformData.getTransformedValue<DateTime>(
                              _fechaYHoraDeLlegadaDelPacienteController
                                  .text)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Referido",
        hintText: "No registra",
        text: healthcareRecord.referido != null
            ? healthcareRecord.referido!
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
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      referido: Optional<bool?>.of(
                          TransformData.getTransformedValue<bool>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Policía notificada",
        hintText: "No registra",
        text: healthcareRecord.policiaNotificada != null
            ? healthcareRecord.policiaNotificada!
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
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      policiaNotificada: Optional<bool?>.of(
                          TransformData.getTransformedValue<bool>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Fecha y hora llegada del médico",
        hintText: "No registra",
        text: healthcareRecord.fechaYHoraDeLlegadaDelMedico != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeLlegadaDelMedico!)
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
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaYHoraDeLlegadaDelMedico: Optional<DateTime?>.of(
                          TransformData.getTransformedValue<DateTime>(value)))),
            ),
          );
        },
        controller: _fechaYHoraDeLlegadaDelMedicoController,
        onTap: () async {
          final DateTime? resultDate = await CustomModal.determineDate(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
            includeTime: true,
          );
          _fechaYHoraDeLlegadaDelMedicoController.text = resultDate != null
              ? DateFormat('dd/MM/yyyy HH:mm:ss').format(resultDate)
              : "";
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaYHoraDeLlegadaDelMedico: Optional<DateTime?>.of(
                          TransformData.getTransformedValue<DateTime>(
                              _fechaYHoraDeLlegadaDelMedicoController.text)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Fecha y hora de notificación al médico",
        hintText: "No registra",
        text: healthcareRecord.fechaYHoraDeNotificacionAlMedico != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeNotificacionAlMedico!)
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
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaYHoraDeNotificacionAlMedico: Optional<DateTime?>.of(
                          TransformData.getTransformedValue<DateTime>(value)))),
            ),
          );
        },
        controller: _fechaYHoraDeNotificacionAlMedicoController,
        onTap: () async {
          final DateTime? resultDate = await CustomModal.determineDate(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
            includeTime: true,
          );
          _fechaYHoraDeNotificacionAlMedicoController.text = resultDate != null
              ? DateFormat('dd/MM/yyyy HH:mm:ss').format(resultDate)
              : "";
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaYHoraDeNotificacionAlMedico: Optional<DateTime?>.of(
                          TransformData.getTransformedValue<DateTime>(
                              _fechaYHoraDeNotificacionAlMedicoController
                                  .text)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Alerta a equipo de trauma",
        hintText: "No registra",
        text: healthcareRecord.alertaEquipoDeTrauma != null
            ? healthcareRecord.alertaEquipoDeTrauma!
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
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      alertaEquipoDeTrauma: Optional<bool?>.of(
                          TransformData.getTransformedValue<bool>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Nivel de alerta",
        hintText: "No registra",
        text: healthcareRecord.nivelDeAlerta ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        suggestions: ContentOptions.healthcareRecord.nivelDeAlerta,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      nivelDeAlerta: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Paciente asegurado",
        hintText: "No registra",
        text: healthcareRecord.pacienteAsegurado != null
            ? healthcareRecord.pacienteAsegurado!
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
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      pacienteAsegurado: Optional<bool?>.of(
                          TransformData.getTransformedValue<bool>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Tipo de seguro",
        hintText: "No registra",
        text: healthcareRecord.tipoDeSeguro ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        suggestions: ContentOptions.healthcareRecord.tipoDeSeguro,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      tipoDeSeguro: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Motivo de consulta",
        hintText: "No registra",
        text: healthcareRecord.motivoDeConsulta ?? "",
        lines: 10,
        // width: freeSize ? null : 460,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      motivoDeConsulta: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Inmunización contra el tétanos",
        hintText: "No registra",
        text: healthcareRecord.inmunizacionContraElTetanos ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        suggestions:
            ContentOptions.healthcareRecord.inmunizacionContraElTetanos,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      inmunizacionContraElTetanos: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Descripción del examen físico",
        hintText: "No registra",
        text: healthcareRecord.descripcionDelExamenFisico ?? "",
        lines: 15,
        // width: freeSize ? null : double.infinity,
        // height: freeSize ? null : 124,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      descripcionDelExamenFisico: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Mecanismo primario",
        hintText: "No registra",
        text: healthcareRecord.mecanismoPrimario ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        suggestions: ContentOptions.healthcareRecord.mecanismoPrimario,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      mecanismoPrimario: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Número de lesiones seria",
        hintText: "No registra",
        text: healthcareRecord.numeroDeLesionesSerias ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        suggestions: ContentOptions.healthcareRecord.numeroDeLesionesSerias,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      numeroDeLesionesSerias: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Descripción del diagnóstico",
        hintText: "No registra",
        text: healthcareRecord.descripcionDelDiagnostico ?? "",
        lines: 5,
        // width: freeSize ? null : double.infinity,
        // height: freeSize ? null : 124,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      descripcionDelDiagnostico: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Disposición o destino del paciente",
        hintText: "No registra",
        text: healthcareRecord.disposicionODestinoDelPaciente ?? "",
        lines: 1,
        width: freeSize ? null : 460,
        height: freeSize ? null : 124,
        suggestions:
            ContentOptions.healthcareRecord.disposicionODestinoDelPaciente,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      disposicionODestinoDelPaciente: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Donación de órganos",
        hintText: "No registra",
        text: healthcareRecord.donacionDeOrganos ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        suggestions: ContentOptions.healthcareRecord.donacionDeOrganos,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      donacionDeOrganos: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Autopsia",
        hintText: "No registra",
        text: healthcareRecord.autopsia ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        suggestions: ContentOptions.healthcareRecord.autopsia,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      autopsia: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Muerte prevenible",
        hintText: "No registra",
        text: healthcareRecord.muertePrevenible ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        suggestions: ContentOptions.healthcareRecord.muertePrevenible,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      muertePrevenible: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Tipo de admisión",
        hintText: "No registra",
        text: healthcareRecord.tipoDeAdmision ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        suggestions: ContentOptions.healthcareRecord.tipoDeAdmision,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      tipoDeAdmision: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Fecha y hora de la disposición",
        hintText: "No registra",
        text: healthcareRecord.fechaYHoraDeLaDisposicion != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeLaDisposicion!)
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
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaYHoraDeLaDisposicion: Optional<DateTime?>.of(
                          TransformData.getTransformedValue<DateTime>(value)))),
            ),
          );
        },
        controller: _fechaYHoraDeLaDisposicionController,
        onTap: () async {
          final DateTime? resultDate = await CustomModal.determineDate(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
            includeTime: true,
          );
          _fechaYHoraDeLaDisposicionController.text = resultDate != null
              ? DateFormat('dd/MM/yyyy HH:mm:ss').format(resultDate)
              : "";
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaYHoraDeLaDisposicion: Optional<DateTime?>.of(
                          TransformData.getTransformedValue<DateTime>(
                              _fechaYHoraDeLaDisposicionController.text)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Tiempo en sala de emergencias (horas)",
        hintText: "No registra",
        text: "${healthcareRecord.tiempoEnSalaDeEmergenciasHoras ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      tiempoEnSalaDeEmergenciasHoras: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Tiempo en sala de emergencias (minutos)",
        hintText: "No registra",
        text: "${healthcareRecord.tiempoEnSalaDeEmergenciasMinutos ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      tiempoEnSalaDeEmergenciasMinutos: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Número de referencia del ED",
        hintText: "No registra",
        text: healthcareRecord.numeroDeReferenciaDelEd ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      numeroDeReferenciaDelEd: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Fecha de admisión",
        hintText: "No registra",
        text: healthcareRecord.fechaDeAdmision != null
            ? DateFormat('dd/MM/yyyy').format(healthcareRecord.fechaDeAdmision!)
            : "",
        rightIcon: Icons.calendar_month_outlined,
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.date,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaDeAdmision: Optional<DateTime?>.of(
                          TransformData.getTransformedValue<DateTime>(value)))),
            ),
          );
        },
        controller: _fechaDeAdmisionController,
        onTap: () async {
          final DateTime? resultDate = await CustomModal.determineDate(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
          );
          _fechaDeAdmisionController.text = resultDate != null
              ? DateFormat('dd/MM/yyyy').format(resultDate)
              : "";
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaDeAdmision: Optional<DateTime?>.of(
                          TransformData.getTransformedValue<DateTime>(
                              _fechaDeAdmisionController.text)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Fecha y hora de alta",
        hintText: "No registra",
        text: healthcareRecord.fechaYHoraDeAlta != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeAlta!)
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
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaYHoraDeAlta: Optional<DateTime?>.of(
                          TransformData.getTransformedValue<DateTime>(value)))),
            ),
          );
        },
        controller: _fechaYHoraDeAltaController,
        onTap: () async {
          final DateTime? resultDate = await CustomModal.determineDate(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
            includeTime: true,
          );
          _fechaYHoraDeAltaController.text = resultDate != null
              ? DateFormat('dd/MM/yyyy HH:mm:ss').format(resultDate)
              : "";
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaYHoraDeAlta: Optional<DateTime?>.of(
                          TransformData.getTransformedValue<DateTime>(
                              _fechaYHoraDeAltaController.text)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Días de hospitalización",
        hintText: "No registra",
        text: "${healthcareRecord.diasDeHospitalizacion ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.double,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      diasDeHospitalizacion: Optional<double?>.of(
                          TransformData.getTransformedValue<double>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Días en UCI",
        hintText: "No registra",
        text: "${healthcareRecord.uciDias ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      uciDias: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Detalles de hospitalización",
        hintText: "No registra",
        text: healthcareRecord.detallesDeHospitalizacion ?? "",
        lines: 5,
        // width: freeSize ? null : double.infinity,
        // height: freeSize ? null : 124,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      detallesDeHospitalizacion: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Disposición o destino del paciente (hospitalización)",
        hintText: "No registra",
        text:
            healthcareRecord.disposicionODestinoDelPacienteDelHospitalizacion ??
                "",
        lines: 1,
        width: freeSize ? null : 460,
        height: freeSize ? null : 124,
        suggestions: ContentOptions
            .healthcareRecord.disposicionODestinoDelPacienteDeHospitalizacion,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      disposicionODestinoDelPacienteDelHospitalizacion:
                          Optional<String?>.of(
                              TransformData.getTransformedValue<String>(
                                  value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Donación de órganos (hospitalización)",
        hintText: "No registra",
        text: healthcareRecord.donacionDeOrganosDelHospitalizacion ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        suggestions:
            ContentOptions.healthcareRecord.donacionDeOrganosDeHospitalizacion,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      donacionDeOrganosDelHospitalizacion: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Autopsia (hospitalización)",
        hintText: "No registra",
        text: healthcareRecord.autopsiaDelHospitalizacion ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        suggestions: ContentOptions.healthcareRecord.autopsiaDeHospitalizacion,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      autopsiaDelHospitalizacion: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Muerte prevenible (hospitalización)",
        hintText: "No registra",
        text: healthcareRecord.muertePrevenibleDelHospitalizacion ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        suggestions:
            ContentOptions.healthcareRecord.muertePrevenibleDeHospitalizacion,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      muertePrevenibleDelHospitalizacion: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Número de referencia (hospitalización)",
        hintText: "No registra",
        text: healthcareRecord.numeroDeReferenciaDelHospitalizacion ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      numeroDeReferenciaDelHospitalizacion:
                          Optional<String?>.of(
                              TransformData.getTransformedValue<String>(
                                  value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Agencia de transporte",
        hintText: "No registra",
        text: healthcareRecord.agenciaDeTransporte ?? "",
        lines: 2,
        width: freeSize ? null : 460,
        height: freeSize ? null : 124,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      agenciaDeTransporte: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Origen del transporte",
        hintText: "No registra",
        text: healthcareRecord.origenDelTransporte ?? "",
        lines: 2,
        width: freeSize ? null : 460,
        height: freeSize ? null : 124,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      origenDelTransporte: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Número de registro del transporte",
        hintText: "No registra",
        text: healthcareRecord.numeroDeRegistroDelTransporte ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      numeroDeRegistroDelTransporte: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Fecha y hora de notificación prehospitalaria",
        hintText: "No registra",
        text: healthcareRecord.fechaYHoraDeNotificacionPreHospitalaria != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss').format(
                healthcareRecord.fechaYHoraDeNotificacionPreHospitalaria!)
            : "",
        lines: 1,
        rightIcon: Icons.calendar_month_outlined,
        width: freeSize ? null : 460,
        height: freeSize ? null : 124,
        inputType: InputType.datetime,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaYHoraDeNotificacionPreHospitalaria:
                          Optional<DateTime?>.of(
                              TransformData.getTransformedValue<DateTime>(
                                  value)))),
            ),
          );
        },
        controller: _fechaYHoraDeNotificacionPreHospitalariaController,
        onTap: () async {
          final DateTime? resultDate = await CustomModal.determineDate(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
            includeTime: true,
          );
          _fechaYHoraDeNotificacionPreHospitalariaController.text =
              resultDate != null
                  ? DateFormat('dd/MM/yyyy HH:mm:ss').format(resultDate)
                  : "";
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaYHoraDeNotificacionPreHospitalaria: Optional<
                              DateTime?>.of(
                          TransformData.getTransformedValue<DateTime>(
                              _fechaYHoraDeNotificacionPreHospitalariaController
                                  .text)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Fecha y hora de llegada a la escena",
        hintText: "No registra",
        text: healthcareRecord.fechaYHoraDeLlegadaALaEscena != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeLlegadaALaEscena!)
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
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaYHoraDeLlegadaALaEscena: Optional<DateTime?>.of(
                          TransformData.getTransformedValue<DateTime>(value)))),
            ),
          );
        },
        controller: _fechaYHoraDeLlegadaALaEscenaController,
        onTap: () async {
          final DateTime? resultDate = await CustomModal.determineDate(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
            includeTime: true,
          );
          _fechaYHoraDeLlegadaALaEscenaController.text = resultDate != null
              ? DateFormat('dd/MM/yyyy HH:mm:ss').format(resultDate)
              : "";
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaYHoraDeLlegadaALaEscena: Optional<DateTime?>.of(
                          TransformData.getTransformedValue<DateTime>(
                              _fechaYHoraDeLlegadaALaEscenaController.text)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Fecha y hora de salida de la escena",
        hintText: "No registra",
        text: healthcareRecord.fechaYHoraDeSalidaDeLaEscena != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeSalidaDeLaEscena!)
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
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaYHoraDeSalidaDeLaEscena: Optional<DateTime?>.of(
                          TransformData.getTransformedValue<DateTime>(value)))),
            ),
          );
        },
        controller: _fechaYHoraDeSalidaDeLaEscenaController,
        onTap: () async {
          final DateTime? resultDate = await CustomModal.determineDate(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
            includeTime: true,
          );
          _fechaYHoraDeSalidaDeLaEscenaController.text = resultDate != null
              ? DateFormat('dd/MM/yyyy HH:mm:ss').format(resultDate)
              : "";
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaYHoraDeSalidaDeLaEscena: Optional<DateTime?>.of(
                          TransformData.getTransformedValue<DateTime>(
                              _fechaYHoraDeSalidaDeLaEscenaController.text)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Razón de la demora",
        hintText: "No registra",
        text: healthcareRecord.razonDeLaDemora ?? "",
        lines: 2,
        width: freeSize ? null : 460,
        height: freeSize ? null : 124,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      razonDeLaDemora: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Reporte o formulario prehospitalario entregado",
        hintText: "No registra",
        text:
            healthcareRecord.reporteOFormularioPreHospitalarioEntregado != null
                ? healthcareRecord.reporteOFormularioPreHospitalarioEntregado!
                    ? 'Sí'
                    : 'No'
                : "",
        lines: 1,
        width: freeSize ? null : 460,
        height: freeSize ? null : 124,
        inputType: InputType.boolean,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      reporteOFormularioPreHospitalarioEntregado:
                          Optional<bool?>.of(
                              TransformData.getTransformedValue<bool>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Ciudad del hospital más cercano al sitio del incidente",
        hintText: "No registra",
        text:
            healthcareRecord.ciudadHospitalMasCercanoAlSitioDelIncidente ?? "",
        lines: 2,
        width: freeSize ? null : 460,
        height: freeSize ? null : 124,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      ciudadHospitalMasCercanoAlSitioDelIncidente:
                          Optional<String?>.of(
                              TransformData.getTransformedValue<String>(
                                  value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Tiempo de extricación (horas)",
        hintText: "No registra",
        text: "${healthcareRecord.tiempoDeExtricacionHoras ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      tiempoDeExtricacionHoras: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Tiempo de extricación (minutos)",
        hintText: "No registra",
        text: "${healthcareRecord.tiempoDeExtricacionMinutos ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      tiempoDeExtricacionMinutos: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Duración del transporte (horas)",
        hintText: "No registra",
        text: "${healthcareRecord.duracionDelTransporteHoras ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      duracionDelTransporteHoras: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Duración del transporte (minutos)",
        hintText: "No registra",
        text: "${healthcareRecord.duracionDelTransporteMinutos ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      duracionDelTransporteMinutos: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Procedimiento realizado",
        hintText: "No registra",
        text: healthcareRecord.procedimientoRealizado ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      procedimientoRealizado: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Frecuencia cardíaca en la escena",
        hintText: "No registra",
        text: "${healthcareRecord.frecuenciaCardiacaEnLaEscena ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      frecuenciaCardiacaEnLaEscena: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Presión arterial sistólica en la escena",
        hintText: "No registra",
        text: "${healthcareRecord.presionArterialSistolicaEnLaEscena ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      presionArterialSistolicaEnLaEscena: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Presión arterial diastólica en la escena",
        hintText: "No registra",
        text: "${healthcareRecord.presionArterialDiastolicaEnLaEscena ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      presionArterialDiastolicaEnLaEscena: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Frecuencia respiratoria en la escena",
        hintText: "No registra",
        text: "${healthcareRecord.frecuenciaRespiratoriaEnLaEscena ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      frecuenciaRespiratoriaEnLaEscena: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Calificador de frecuencia respiratoria en la escena",
        hintText: "No registra",
        text: healthcareRecord.calificadorDeFrecuenciaRespiratoriaEnLaEscena ??
            "",
        lines: 2,
        width: freeSize ? null : 460,
        height: freeSize ? null : 124,
        suggestions: ContentOptions
            .healthcareRecord.calificadorDeFrecuenciaRespiratoriaEnLaEscena,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      calificadorDeFrecuenciaRespiratoriaEnLaEscena:
                          Optional<String?>.of(
                              TransformData.getTransformedValue<String>(
                                  value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Temperatura en la escena (°C)",
        hintText: "No registra",
        text: "${healthcareRecord.temperaturaEnLaEscenaCelsius ?? ""}",
        rightIcon: Icons.device_thermostat_outlined,
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.double,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      temperaturaEnLaEscenaCelsius: Optional<double?>.of(
                          TransformData.getTransformedValue<double>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Saturación de O₂ en la escena",
        hintText: "No registra",
        text: "${healthcareRecord.saturacionDeO2EnLaEscena ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      saturacionDeO2EnLaEscena: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Frecuencia cardíaca durante el transporte",
        hintText: "No registra",
        text: "${healthcareRecord.frecuenciaCardiacaDuranteElTransporte ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      frecuenciaCardiacaDuranteElTransporte: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Presión arterial sistólica durante el transporte",
        hintText: "No registra",
        text: "${healthcareRecord.presionArterialSistolicaDeTransporte ?? ""}",
        lines: 1,
        width: freeSize ? null : 460,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      presionArterialSistolicaDeTransporte: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Presión diastólica durante el transporte",
        hintText: "No registra",
        text: "${healthcareRecord.presionDiastolicaDuranteElTransporte ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      presionDiastolicaDuranteElTransporte: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Frecuencia respiratoria durante el transporte",
        hintText: "No registra",
        text:
            "${healthcareRecord.frecuenciaRespiratoriaDuranteElTransporte ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      frecuenciaRespiratoriaDuranteElTransporte:
                          Optional<int?>.of(
                              TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Calificador de frecuencia respiratoria durante el transporte",
        hintText: "No registra",
        text: healthcareRecord
                .calificadorDeFrecuenciaRespiratoriaDuranteElTransporte ??
            "",
        lines: 2,
        width: freeSize ? null : 460,
        height: freeSize ? null : 124,
        suggestions: ContentOptions.healthcareRecord
            .calificadorDeFrecuenciaRespiratoriaDuranteElTransporte,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      calificadorDeFrecuenciaRespiratoriaDuranteElTransporte:
                          Optional<String?>.of(
                              TransformData.getTransformedValue<String>(
                                  value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Temperatura durante el transporte (°C)",
        hintText: "No registra",
        text: "${healthcareRecord.temperaturaDuranteElTransporteCelsius ?? ""}",
        rightIcon: Icons.device_thermostat_outlined,
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.double,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(patientData
                  .healthcareRecord!
                  .copyWith(
                      temperaturaDuranteElTransporteCelsius:
                          Optional<double?>.of(
                              TransformData.getTransformedValue<double>(
                                  value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Saturación de O₂ durante el transporte",
        hintText: "No registra",
        text: "${healthcareRecord.saturacionDeO2DuranteElTransporte ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      saturacionDeO2DuranteElTransporte: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Pérdida de conciencia",
        hintText: "No registra",
        text: "${healthcareRecord.perdidaDeConciencia ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      perdidaDeConciencia: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Duración de pérdida de conciencia",
        hintText: "No registra",
        text: (healthcareRecord.duracionDePerdidaDeConciencia ?? "").toString(),
        lines: 1,
        rightIcon: FontAwesomeIcons.clock,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.time,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      duracionDePerdidaDeConciencia: Optional<t.TimeOfDay?>.of(
                          TransformData.getTransformedValue<t.TimeOfDay>(
                              value)))),
            ),
          );
        },
        controller: _duracionDePerdidaDeConcienciaController,
        onTap: () async {
          final String? hour = await CustomModal.determineTimeWithSeconds(
            context: context,
            focusNode: FocusNode(),
          );
          _duracionDePerdidaDeConcienciaController.text = hour ?? '';
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      duracionDePerdidaDeConciencia: Optional<t.TimeOfDay?>.of(
                          TransformData.getTransformedValue<t.TimeOfDay>(
                              _duracionDePerdidaDeConcienciaController.text)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "GCS ocular",
        hintText: "No registra",
        text: "${healthcareRecord.gcsOcular ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      gcsOcular: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "GCS verbal",
        hintText: "No registra",
        text: "${healthcareRecord.gcsVerbal ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      gcsVerbal: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "GCS motora",
        hintText: "No registra",
        text: "${healthcareRecord.gcsMotora ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      gcsMotora: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "GCS total",
        hintText: "No registra",
        text: "${healthcareRecord.gcsTotal ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      gcsTotal: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Sangre (L)",
        hintText: "No registra",
        text: "${healthcareRecord.sangreL ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.double,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      sangreL: Optional<double?>.of(
                          TransformData.getTransformedValue<double>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Coloides (L)",
        hintText: "No registra",
        text: "${healthcareRecord.coloidesL ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.double,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      coloidesL: Optional<double?>.of(
                          TransformData.getTransformedValue<double>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Cristaloides (L)",
        hintText: "No registra",
        text: "${healthcareRecord.cristaloidesL ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.double,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      cristaloidesL: Optional<double?>.of(
                          TransformData.getTransformedValue<double>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Hallazgos clínicos (texto)",
        hintText: "No registra",
        text: healthcareRecord.hallazgosClinicosTexto ?? "",
        lines: 5,
        // width: freeSize ? null : double.infinity,
        // height: freeSize ? null : 124,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      hallazgosClinicosTexto: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Fecha y hora de envío de contrarreferencia",
        hintText: "No registra",
        text: healthcareRecord.fechaYHoraDeEnvioDeContraReferencia != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeEnvioDeContraReferencia!)
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
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaYHoraDeEnvioDeContraReferencia:
                          Optional<DateTime?>.of(
                              TransformData.getTransformedValue<DateTime>(
                                  value)))),
            ),
          );
        },
        controller: _fechaYHoraDeEnvioDeContraReferenciaController,
        onTap: () async {
          final DateTime? resultDate = await CustomModal.determineDate(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
            includeTime: true,
          );
          _fechaYHoraDeEnvioDeContraReferenciaController.text =
              resultDate != null
                  ? DateFormat('dd/MM/yyyy HH:mm:ss').format(resultDate)
                  : "";
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaYHoraDeEnvioDeContraReferencia:
                          Optional<DateTime?>.of(
                              TransformData.getTransformedValue<DateTime>(
                                  _fechaYHoraDeEnvioDeContraReferenciaController
                                      .text)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Fecha de alta de contrarreferencia",
        hintText: "No registra",
        text: healthcareRecord.fechaDeAltaDeContrarReferencia != null
            ? DateFormat('dd/MM/yyyy')
                .format(healthcareRecord.fechaDeAltaDeContrarReferencia!)
            : "",
        rightIcon: Icons.calendar_month_outlined,
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.datetime,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaDeAltaDeContrarReferencia: Optional<DateTime?>.of(
                          TransformData.getTransformedValue<DateTime>(value)))),
            ),
          );
        },
        controller: _fechaDeAltaDeContrarReferenciaController,
        onTap: () async {
          final DateTime? resultDate = await CustomModal.determineDate(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
            includeTime: true,
          );
          _fechaDeAltaDeContrarReferenciaController.text = resultDate != null
              ? DateFormat('dd/MM/yyyy HH:mm:ss').format(resultDate)
              : "";
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaDeAltaDeContrarReferencia: Optional<DateTime?>.of(
                          TransformData.getTransformedValue<DateTime>(
                              _fechaDeAltaDeContrarReferenciaController
                                  .text)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Hallazgos clínicos (existencia)",
        hintText: "No registra",
        text: healthcareRecord.hallazgosClinicosExistencia != null
            ? healthcareRecord.hallazgosClinicosExistencia!
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
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      hallazgosClinicosExistencia: Optional<bool?>.of(
                          TransformData.getTransformedValue<bool>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Servicio que atendió",
        hintText: "No registra",
        text: healthcareRecord.servicioQueAtendio ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      servicioQueAtendio: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Paciente admitido",
        hintText: "No registra",
        text: healthcareRecord.pacienteAdmitido != null
            ? healthcareRecord.pacienteAdmitido!
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
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      pacienteAdmitido: Optional<bool?>.of(
                          TransformData.getTransformedValue<bool>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Hospital que recibe",
        hintText: "No registra",
        text: healthcareRecord.hospitalQueRecibe ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      hospitalQueRecibe: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Otro servicio",
        hintText: "No registra",
        text: healthcareRecord.otroServicio ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      otroServicio: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Servicio que recibe",
        hintText: "No registra",
        text: healthcareRecord.servicioQueRecibe ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      servicioQueRecibe: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Recomendaciones",
        hintText: "No registra",
        text: healthcareRecord.recomendaciones ?? "",
        lines: 2,
        width: freeSize ? null : 460,
        height: freeSize ? null : 124,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      recomendaciones: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Número de referencia de referencias salientes",
        hintText: "No registra",
        text: healthcareRecord.numeroDeReferenciaDeReferenciasSalientes ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      numeroDeReferenciaDeReferenciasSalientes:
                          Optional<String?>.of(
                              TransformData.getTransformedValue<String>(
                                  value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Fecha de envío de referencia",
        hintText: "No registra",
        text: healthcareRecord.fechaDeEnvioDeReferencia != null
            ? DateFormat('dd/MM/yyyy')
                .format(healthcareRecord.fechaDeEnvioDeReferencia!)
            : "",
        rightIcon: Icons.calendar_month_outlined,
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.datetime,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaDeEnvioDeReferencia: Optional<DateTime?>.of(
                          TransformData.getTransformedValue<DateTime>(value)))),
            ),
          );
        },
        controller: _fechaDeEnvioDeReferenciaController,
        onTap: () async {
          final DateTime? resultDate = await CustomModal.determineDate(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
            includeTime: true,
          );
          _fechaDeEnvioDeReferenciaController.text = resultDate != null
              ? DateFormat('dd/MM/yyyy HH:mm:ss').format(resultDate)
              : "";
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaDeEnvioDeReferencia: Optional<DateTime?>.of(
                          TransformData.getTransformedValue<DateTime>(
                              _fechaDeEnvioDeReferenciaController.text)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Fecha de referencia",
        hintText: "No registra",
        text: healthcareRecord.fechaDeReferencia != null
            ? DateFormat('dd/MM/yyyy')
                .format(healthcareRecord.fechaDeReferencia!)
            : "",
        rightIcon: Icons.calendar_month_outlined,
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.date,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaDeReferencia: Optional<DateTime?>.of(
                          TransformData.getTransformedValue<DateTime>(value)))),
            ),
          );
        },
        controller: _fechaDeReferenciaController,
        onTap: () async {
          final DateTime? resultDate = await CustomModal.determineDate(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
          );
          _fechaDeReferenciaController.text = resultDate != null
              ? DateFormat('dd/MM/yyyy').format(resultDate)
              : "";
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaDeReferencia: Optional<DateTime?>.of(
                          TransformData.getTransformedValue<DateTime>(
                              _fechaDeReferenciaController.text)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Razón de la referencia",
        hintText: "No registra",
        text: healthcareRecord.razonDeLaReferencia ?? "",
        lines: 5,
        // width: freeSize ? null : double.infinity,
        // height: freeSize ? null : 124,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      razonDeLaReferencia: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Médico que refiere",
        hintText: "No registra",
        text: healthcareRecord.medicoQueRefiere ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      medicoQueRefiere: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Estado de la referencia",
        hintText: "No registra",
        text: healthcareRecord.estadoDeReferencia ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        suggestions: ContentOptions.healthcareRecord.estadoDeReferencia,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      estadoDeReferencia: Optional<String?>.of(
                          TransformData.getTransformedValue<String>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Fecha de aceptación de la referencia",
        hintText: "No registra",
        text: healthcareRecord.fechaDeAceptacionDeReferencia != null
            ? DateFormat('dd/MM/yyyy')
                .format(healthcareRecord.fechaDeAceptacionDeReferencia!)
            : "",
        rightIcon: Icons.calendar_month_outlined,
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.date,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaDeAceptacionDeReferencia: Optional<DateTime?>.of(
                          TransformData.getTransformedValue<DateTime>(value)))),
            ),
          );
        },
        controller: _fechaDeAceptacionDeReferenciaController,
        onTap: () async {
          final DateTime? resultDate = await CustomModal.determineDate(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
          );
          _fechaDeAceptacionDeReferenciaController.text = resultDate != null
              ? DateFormat('dd/MM/yyyy').format(resultDate)
              : "";
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      fechaDeAceptacionDeReferencia: Optional<DateTime?>.of(
                          TransformData.getTransformedValue<DateTime>(
                              _fechaDeAceptacionDeReferenciaController.text)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "ISS",
        hintText: "No registra",
        text: "${healthcareRecord.iss ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      iss: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "KTS",
        hintText: "No registra",
        text: "${healthcareRecord.kts ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      kts: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "RTS",
        hintText: "No registra",
        text: "${healthcareRecord.rts ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.double,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      rts: Optional<double?>.of(
                          TransformData.getTransformedValue<double>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Abdomen",
        hintText: "No registra",
        text: "${healthcareRecord.abdomen ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      abdomen: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Tórax",
        hintText: "No registra",
        text: "${healthcareRecord.torax ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      torax: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Externo",
        hintText: "No registra",
        text: "${healthcareRecord.externo ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      externo: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Extremidades",
        hintText: "No registra",
        text: "${healthcareRecord.extremidades ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      extremidades: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Cara",
        hintText: "No registra",
        text: "${healthcareRecord.cara ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      cara: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Cabeza",
        hintText: "No registra",
        text: "${healthcareRecord.cabeza ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      cabeza: Optional<int?>.of(
                          TransformData.getTransformedValue<int>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "TRISS contuso",
        hintText: "No registra",
        text: "${healthcareRecord.trissContuso ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.double,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: Optional<HealthcareRecord?>.of(
                  patientData.healthcareRecord!.copyWith(
                      trissContuso: Optional<double?>.of(
                          TransformData.getTransformedValue<double>(value)))),
            ),
          );
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "TRISS penetrante",
        hintText: "No registra",
        text: "${healthcareRecord.trissPenetrante ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.double,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            healthcareRecord: Optional<HealthcareRecord?>.of(
              patientData.healthcareRecord!.copyWith(
                  trissPenetrante: Optional<double?>.of(
                      TransformData.getTransformedValue<double>(value))),
            ),
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

  void _updateElement({
    required BuildContext context,
    required int? id,
  }) {
    final traumaDataProvider = _getCurrentProvider(context);
    final patientData = _getCurrentPatientData(context);
    final element = patientData.healthcareRecord;
    if (element == null) return;
    traumaDataProvider.updatePatientData(patientData.copyWith(
      healthcareRecord:
          Optional<HealthcareRecord?>.of(element.copyWith(id: id)),
    ));
  }
}
