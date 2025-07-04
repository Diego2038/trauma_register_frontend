import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/helpers/transform_data.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/healthcare_record.dart';
import 'package:trauma_register_frontend/data/models/custom/time_of_day.dart'
    as t;
import 'package:trauma_register_frontend/data/models/trauma_data/patient_data.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_icon_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class HealthcareRecordContent extends StatelessWidget {
  const HealthcareRecordContent({
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
      title: "Registro de atención médica",
      index: 1,
      expandedWidget: _getCurrentPatientData(context).healthcareRecord == null
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
                            healthcareRecord: HealthcareRecord(),
                          ),
                          true);
                    },
                  ),
                )
              : noDataWidget
          : CustomContainer(
              children: healthcareRecordContent(
                context: context,
                customSize: customSize,
                healthcareRecord:
                    _getCurrentPatientData(context).healthcareRecord!,
                isCreating: isCreating,
                freeSize: freeSize,
              ),
            ),
    );
  }

  List<Widget> healthcareRecordContent({
    required BuildContext context,
    required HealthcareRecord healthcareRecord,
    required CustomSize customSize,
    required bool isCreating,
    required bool freeSize,
  }) {
    final traumaDataProvider = _getCurrentProvider(context);
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  numeroDeHistoriaClinica:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  hospital: TransformData.getTransformedValue<String>(value)),
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
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  fechaYHoraDeLlegadaDelPaciente:
                      TransformData.getTransformedValue<DateTime>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  referido: TransformData.getTransformedValue<bool>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  policiaNotificada:
                      TransformData.getTransformedValue<bool>(value)),
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
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  fechaYHoraDeLlegadaDelMedico:
                      TransformData.getTransformedValue<DateTime>(value)),
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
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  fechaYHoraDeNotificacionAlMedico:
                      TransformData.getTransformedValue<DateTime>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  alertaEquipoDeTrauma:
                      TransformData.getTransformedValue<bool>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  nivelDeAlerta:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  pacienteAsegurado:
                      TransformData.getTransformedValue<bool>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  tipoDeSeguro:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  motivoDeConsulta:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  inmunizacionContraElTetanos:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  descripcionDelExamenFisico:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  mecanismoPrimario:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  numeroDeLesionesSerias:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  descripcionDelDiagnostico:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  disposicionODestinoDelPaciente:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  donacionDeOrganos:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  autopsia: TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  muertePrevenible:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  tipoDeAdmision:
                      TransformData.getTransformedValue<String>(value)),
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
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  fechaYHoraDeLaDisposicion:
                      TransformData.getTransformedValue<DateTime>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  tiempoEnSalaDeEmergenciasHoras:
                      TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  tiempoEnSalaDeEmergenciasMinutos:
                      TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  numeroDeReferenciaDelEd:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  fechaDeAdmision:
                      TransformData.getTransformedValue<DateTime>(value)),
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
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  fechaYHoraDeAlta:
                      TransformData.getTransformedValue<DateTime>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  diasDeHospitalizacion:
                      TransformData.getTransformedValue<double>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  uciDias: TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  detallesDeHospitalizacion:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  disposicionODestinoDelPacienteDelHospitalizacion:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  donacionDeOrganosDelHospitalizacion:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  autopsiaDelHospitalizacion:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  muertePrevenibleDelHospitalizacion:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  numeroDeReferenciaDelHospitalizacion:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  agenciaDeTransporte:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  origenDelTransporte:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  numeroDeRegistroDelTransporte:
                      TransformData.getTransformedValue<String>(value)),
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
        width: freeSize ? null : 460,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  fechaYHoraDeNotificacionPreHospitalaria:
                      TransformData.getTransformedValue<DateTime>(value)),
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
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  fechaYHoraDeLlegadaALaEscena:
                      TransformData.getTransformedValue<DateTime>(value)),
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
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  fechaYHoraDeSalidaDeLaEscena:
                      TransformData.getTransformedValue<DateTime>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  razonDeLaDemora:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  reporteOFormularioPreHospitalarioEntregado:
                      TransformData.getTransformedValue<bool>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  ciudadHospitalMasCercanoAlSitioDelIncidente:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  tiempoDeExtricacionHoras:
                      TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  tiempoDeExtricacionMinutos:
                      TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  duracionDelTransporteHoras:
                      TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  duracionDelTransporteMinutos:
                      TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  procedimientoRealizado:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  frecuenciaCardiacaEnLaEscena:
                      TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  presionArterialSistolicaEnLaEscena:
                      TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  presionArterialDiastolicaEnLaEscena:
                      TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  frecuenciaRespiratoriaEnLaEscena:
                      TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  calificadorDeFrecuenciaRespiratoriaEnLaEscena:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  temperaturaEnLaEscenaCelsius:
                      TransformData.getTransformedValue<double>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  saturacionDeO2EnLaEscena:
                      TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  frecuenciaCardiacaDuranteElTransporte:
                      TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  presionArterialSistolicaDeTransporte:
                      TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  frecuenciaRespiratoriaDuranteElTransporte:
                      TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  calificadorDeFrecuenciaRespiratoriaDuranteElTransporte:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  temperaturaDuranteElTransporteCelsius:
                      TransformData.getTransformedValue<double>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  saturacionDeO2DuranteElTransporte:
                      TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  perdidaDeConciencia:
                      TransformData.getTransformedValue<int>(value)),
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
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  duracionDePerdidaDeConciencia:
                      TransformData.getTransformedValue<t.TimeOfDay>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  gcsOcular: TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  gcsVerbal: TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  gcsMotora: TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  gcsTotal: TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  sangreL: TransformData.getTransformedValue<double>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  coloidesL: TransformData.getTransformedValue<double>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  cristaloidesL:
                      TransformData.getTransformedValue<double>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  hallazgosClinicosTexto:
                      TransformData.getTransformedValue<String>(value)),
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
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  fechaYHoraDeEnvioDeContraReferencia:
                      TransformData.getTransformedValue<DateTime>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  fechaDeAltaDeContrarReferencia:
                      TransformData.getTransformedValue<DateTime>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  hallazgosClinicosExistencia:
                      TransformData.getTransformedValue<bool>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  servicioQueAtendio:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  pacienteAdmitido:
                      TransformData.getTransformedValue<bool>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  hospitalQueRecibe:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  otroServicio:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  servicioQueRecibe:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  recomendaciones:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  numeroDeReferenciaDeReferenciasSalientes:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  fechaDeEnvioDeReferencia:
                      TransformData.getTransformedValue<DateTime>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  fechaDeReferencia:
                      TransformData.getTransformedValue<DateTime>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  razonDeLaReferencia:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  medicoQueRefiere:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  estadoDeReferencia:
                      TransformData.getTransformedValue<String>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  fechaDeAceptacionDeReferencia:
                      TransformData.getTransformedValue<DateTime>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!
                  .copyWith(iss: TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!
                  .copyWith(kts: TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  rts: TransformData.getTransformedValue<double>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  abdomen: TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  torax: TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  externo: TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  extremidades: TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  cara: TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  cabeza: TransformData.getTransformedValue<int>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  trissContuso:
                      TransformData.getTransformedValue<double>(value)),
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
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(
            patientData.copyWith(
              healthcareRecord: patientData.healthcareRecord!.copyWith(
                  trissPenetrante: TransformData.getTransformedValue(value)),
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
