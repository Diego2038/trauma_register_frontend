import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/trauma_data.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_checkbox.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class PatientManagementView extends StatefulWidget {
  const PatientManagementView({super.key});

  @override
  State<PatientManagementView> createState() => _PatientManagementViewState();
}

class _PatientManagementViewState extends State<PatientManagementView> {
  bool startSearch = false;
  bool isThereDataAnswer = false;
  bool isLoading = false;
  PatientData? patientData;
  bool isMounted = false;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isMounted && context.mounted) {
        isMounted = true;
        final traumaDataProvider =
            Provider.of<TraumaDataProvider>(context, listen: false);
        const traumaDataProviderCount =
            23; // Number of ExpandableTitleWidget widgets

        // Initialize the expansion state (we only do this once)
        if (traumaDataProviderCount !=
            traumaDataProvider.currentAmountExpandedStates()) {
          traumaDataProvider.initializeExpansions(traumaDataProviderCount);
        }
      }
    });

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _customSearchBox(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!startSearch)
                  const H4(
                    text: "Inserte un ID para realizar la búsqueda.",
                  )
                else if (isLoading)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const H4(
                        text: "Realizando búsqueda...",
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: const Center(
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(
                              color: AppColors.base,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                if (patientData == null && startSearch && !isLoading)
                  H4(
                    text:
                        "No se encontró ningún registro con el ID ${controller.text}.",
                  ),
                if (patientData != null && startSearch && !isLoading)
                  _ContentDataPatient(
                    patientData: patientData!,
                    customSize: CustomSize.h5,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Center _customSearchBox() {
    return Center(
      child: Container(
        // height: 140,
        // width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.base50,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: const Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            // width: double.infinity,
            child: Wrap(
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 20,
              spacing: 30,
              children: [
                CustomInputWithLabel(
                  size: CustomSize.h2,
                  width: 400,
                  controller: controller,
                  allowOnlyNumbers: true,
                  title: "Buscar paciente por ID",
                  text: "",
                  hintText: "3155805",
                  leftIcon: Icons.person_search_outlined,
                  rightIcon: Icons.search,
                  onPressedRightIcon: () async {
                    await searchPatient(controller.text);
                  },
                ),
                SizedBox(
                  child: CustomCheckbox(
                    size: CustomSize.h3,
                    text: "Desplegar todas las secciones",
                    onChanged: (bool value) {
                      final traumaDataProvider =
                          Provider.of<TraumaDataProvider>(context,
                              listen: false);
                      traumaDataProvider.setAllExpanded(value);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> searchPatient(String id) async {
    if (isLoading) return;
    startSearch = true;
    setState(() => isLoading = true);
    final traumaDataProvider = context.read<TraumaDataProvider>();
    patientData = await traumaDataProvider.getPatientDataById(id);
    setState(() => isLoading = false);
  }
}

class _ContentDataPatient extends StatelessWidget {
  final PatientData patientData;
  final CustomSize customSize;

  const _ContentDataPatient({
    required this.patientData,
    required this.customSize,
  });

  @override
  Widget build(BuildContext context) {
    const noDataWidget = NormalText(text: "No hay datos en esta categoría");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpandableTitleWidget(
          title: "Datos generales",
          index: 0,
          expandedWidget: CustomContainer(
            children: patientDataContent(
              customSize: customSize,
              patientData: patientData,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Registro de atención médica",
          index: 1,
          expandedWidget: patientData.healthcareRecord == null
              ? noDataWidget
              : CustomContainer(
                  children: healthcareRecordContent(
                    customSize: customSize,
                    healthcareRecord: patientData.healthcareRecord!,
                  ),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Registro de lesión",
          index: 2,
          expandedWidget: patientData.injuryRecord == null
              ? noDataWidget
              : CustomContainer(
                  children: injuryRecordContent(
                    customSize: customSize,
                    injuryRecord: patientData.injuryRecord!,
                  ),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Colisiones",
          index: 3,
          expandedWidget:
              patientData.collision == null || patientData.collision!.isEmpty
                  ? noDataWidget
                  : Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: patientData.collision!
                          .map(
                            (collision) => CustomContainer(
                              children: collisionContent(
                                collision: collision,
                                customSize: customSize,
                              ),
                            ),
                          )
                          .toList(),
                    ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Abusos de drogas",
          index: 4,
          expandedWidget:
              patientData.drugAbuse == null || patientData.drugAbuse!.isEmpty
                  ? noDataWidget
                  : Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: patientData.drugAbuse!
                          .map(
                            (drugAbuse) => CustomContainer(
                              children: drugAbuseContent(
                                drugAbuse: drugAbuse,
                                customSize: customSize,
                              ),
                            ),
                          )
                          .toList(),
                    ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Calificaciones de signos vitales GCS",
          index: 5,
          expandedWidget: patientData.vitalSignGcsQualifier == null ||
                  patientData.vitalSignGcsQualifier!.isEmpty
              ? noDataWidget
              : Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children: patientData.vitalSignGcsQualifier!
                      .map(
                        (vitalSignGcsQualifier) => CustomContainer(
                          maxWidth: 600,
                          children: vitalSignGcsQualifierContent(
                            vitalSignGcsQualifier: vitalSignGcsQualifier,
                            customSize: customSize,
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Variables de hospitalización",
          index: 6,
          expandedWidget: patientData.hospitalizationVariable == null ||
                  patientData.hospitalizationVariable!.isEmpty
              ? noDataWidget
              : Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children: patientData.hospitalizationVariable!
                      .map(
                        (hospitalizationVariable) => CustomContainer(
                          maxWidth: 600,
                          children: hospitalizationVariableContent(
                            hospitalizationVariable: hospitalizationVariable,
                            customSize: customSize,
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Complicaciones de hospitalización",
          index: 7,
          expandedWidget: patientData.hospitalizationComplication == null ||
                  patientData.hospitalizationComplication!.isEmpty
              ? noDataWidget
              : Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children: patientData.hospitalizationComplication!
                      .map(
                        (hospitalizationComplication) => CustomContainer(
                          maxWidth: 600,
                          children: hospitalizationComplicationContent(
                            hospitalizationComplication:
                                hospitalizationComplication,
                            customSize: customSize,
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Registros de trauma ICD10",
          index: 8,
          expandedWidget: patientData.traumaRegisterIcd10 == null ||
                  patientData.traumaRegisterIcd10!.isEmpty
              ? noDataWidget
              : Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children: patientData.traumaRegisterIcd10!
                      .map(
                        (traumaRegisterIcd10) => CustomContainer(
                          maxWidth: 600,
                          children: traumaRegisterIcd10Content(
                            traumaRegisterIcd10: traumaRegisterIcd10,
                            customSize: customSize,
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Unidades de cuidados intensivos",
          index: 9,
          expandedWidget: patientData.intensiveCareUnit == null ||
                  patientData.intensiveCareUnit!.isEmpty
              ? noDataWidget
              : Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children: patientData.intensiveCareUnit!
                      .map(
                        (intensiveCareUnit) => CustomContainer(
                          maxWidth: 600,
                          children: intensiveCareUnitContent(
                            intensiveCareUnit: intensiveCareUnit,
                            customSize: customSize,
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Imágenes",
          index: 10,
          expandedWidget:
              patientData.imaging == null || patientData.imaging!.isEmpty
                  ? noDataWidget
                  : Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: patientData.imaging!
                          .map(
                            (imaging) => CustomContainer(
                              maxWidth: 600,
                              children: imagingContent(
                                imaging: imaging,
                                customSize: customSize,
                              ),
                            ),
                          )
                          .toList(),
                    ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Lesiones intencionales aparentes",
          index: 11,
          expandedWidget: patientData.apparentIntentInjury == null ||
                  patientData.apparentIntentInjury!.isEmpty
              ? noDataWidget
              : Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children: patientData.apparentIntentInjury!
                      .map(
                        (apparentIntentInjury) => CustomContainer(
                          maxWidth: 600,
                          children: apparentIntentInjuryContent(
                            apparentIntentInjury: apparentIntentInjury,
                            customSize: customSize,
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Lesiones por quemadura",
          index: 12,
          expandedWidget:
              patientData.burnInjury == null || patientData.burnInjury!.isEmpty
                  ? noDataWidget
                  : Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: patientData.burnInjury!
                          .map(
                            (burnInjury) => CustomContainer(
                              maxWidth: 600,
                              children: burnInjuryContent(
                                burnInjury: burnInjury,
                                customSize: customSize,
                              ),
                            ),
                          )
                          .toList(),
                    ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Lesiones por armas de fuego",
          index: 11,
          expandedWidget: patientData.firearmInjury == null ||
                  patientData.firearmInjury!.isEmpty
              ? noDataWidget
              : Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children: patientData.firearmInjury!
                      .map(
                        (firearmInjury) => CustomContainer(
                          maxWidth: 600,
                          children: firearmInjuryContent(
                            firearmInjury: firearmInjury,
                            customSize: customSize,
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Lesiones penetrantes",
          index: 13,
          expandedWidget: patientData.penetratingInjury == null ||
                  patientData.penetratingInjury!.isEmpty
              ? noDataWidget
              : Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children: patientData.penetratingInjury!
                      .map(
                        (penetratingInjury) => CustomContainer(
                          maxWidth: 600,
                          children: penetratingInjuryContent(
                            penetratingInjury: penetratingInjury,
                            customSize: customSize,
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Lesiones por envenenamiento",
          index: 14,
          expandedWidget: patientData.poisoningInjury == null ||
                  patientData.poisoningInjury!.isEmpty
              ? noDataWidget
              : Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children: patientData.poisoningInjury!
                      .map(
                        (poisoningInjury) => CustomContainer(
                          maxWidth: 600,
                          children: poisoningInjuryContent(
                            poisoningInjury: poisoningInjury,
                            customSize: customSize,
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Lesiones violentas",
          index: 15,
          expandedWidget: patientData.violenceInjury == null ||
                  patientData.violenceInjury!.isEmpty
              ? noDataWidget
              : Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children: patientData.violenceInjury!
                      .map(
                        (violenceInjury) => CustomContainer(
                          maxWidth: 600,
                          children: violenceInjuryContent(
                            violenceInjury: violenceInjury,
                            customSize: customSize,
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Dispositivos utilizados en accidente de tránsito",
          index: 16,
          expandedWidget:
              patientData.device == null || patientData.device!.isEmpty
                  ? noDataWidget
                  : Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: patientData.device!
                          .map(
                            (device) => CustomContainer(
                              maxWidth: 600,
                              children: deviceContent(
                                device: device,
                                customSize: customSize,
                              ),
                            ),
                          )
                          .toList(),
                    ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Exámenes de laboratorio",
          index: 17,
          expandedWidget:
              patientData.laboratory == null || patientData.laboratory!.isEmpty
                  ? noDataWidget
                  : Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: patientData.laboratory!
                          .map(
                            (laboratory) => CustomContainer(
                              maxWidth: 600,
                              children: laboratoryContent(
                                laboratory: laboratory,
                                customSize: customSize,
                              ),
                            ),
                          )
                          .toList(),
                    ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Exámenes físicos producto por lesión de partes del cuerpo",
          index: 18,
          expandedWidget: patientData.physicalExamBodyPartInjury == null ||
                  patientData.physicalExamBodyPartInjury!.isEmpty
              ? noDataWidget
              : Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children: patientData.physicalExamBodyPartInjury!
                      .map(
                        (physicalExamBodyPartInjury) => CustomContainer(
                          maxWidth: 600,
                          children: physicalExamBodyPartInjuryContent(
                            physicalExamBodyPartInjury:
                                physicalExamBodyPartInjury,
                            customSize: customSize,
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Procedimientos realizados",
          index: 19,
          expandedWidget:
              patientData.procedure == null || patientData.procedure!.isEmpty
                  ? noDataWidget
                  : Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: patientData.procedure!
                          .map(
                            (procedure) => CustomContainer(
                              maxWidth: 600,
                              children: procedureContent(
                                procedure: procedure,
                                customSize: customSize,
                              ),
                            ),
                          )
                          .toList(),
                    ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Procedimientos prehospitalarios realizados",
          index: 20,
          expandedWidget: patientData.prehospitalProcedure == null ||
                  patientData.prehospitalProcedure!.isEmpty
              ? noDataWidget
              : Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children: patientData.prehospitalProcedure!
                      .map(
                        (prehospitalProcedure) => CustomContainer(
                          maxWidth: 600,
                          children: prehospitalProcedureContent(
                            prehospitalProcedure: prehospitalProcedure,
                            customSize: customSize,
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Modo de transporte",
          index: 21,
          expandedWidget: patientData.transportationMode == null ||
                  patientData.transportationMode!.isEmpty
              ? noDataWidget
              : Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children: patientData.transportationMode!
                      .map(
                        (transportationMode) => CustomContainer(
                          maxWidth: 600,
                          children: transportationModeContent(
                            transportationMode: transportationMode,
                            customSize: customSize,
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Signos vitales",
          index: 22,
          expandedWidget:
              patientData.vitalSign == null || patientData.vitalSign!.isEmpty
                  ? noDataWidget
                  : Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: patientData.vitalSign!
                          .map(
                            (vitalSign) => CustomContainer(
                              maxWidth: 600,
                              children: vitalSignContent(
                                vitalSign: vitalSign,
                                customSize: customSize,
                              ),
                            ),
                          )
                          .toList(),
                    ),
        ),
      ],
    );
  }

  List<Widget> patientDataContent({
    required PatientData patientData,
    required CustomSize customSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        title: "Dirección línea 1",
        hintText: "",
        text: patientData.direccionLinea1 ?? "No registra",
        lines: 2,
        width: 220,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Dirección línea 2",
        hintText: "",
        text: patientData.direccionLinea2 ?? "No registra",
        lines: 2,
        width: 220,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Ciudad",
        hintText: "",
        text: patientData.ciudad ?? "No registra",
        lines: 2,
        width: 220,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Cantón / municipio",
        hintText: "",
        text: patientData.cantonMunicipio ?? "No registra",
        lines: 2,
        width: 220,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Provincia / estado",
        hintText: "",
        text: patientData.provinciaEstado ?? "No registra",
        lines: 2,
        width: 220,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Código postal",
        hintText: "",
        text: patientData.codigoPostal ?? "No registra",
        lines: 1,
        width: 220,
        height: 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "País",
        hintText: "",
        text: patientData.pais ?? "No registra",
        lines: 1,
        width: 220,
        height: 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Edad",
        hintText: "",
        text: "${patientData.edad ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Unidad de edad",
        hintText: "",
        text: patientData.unidadDeEdad ?? "No registra",
        lines: 1,
        width: 220,
        height: 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Género",
        hintText: "",
        text: patientData.genero ?? "No registra",
        lines: 1,
        width: 220,
        height: 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Fecha de nacimiento",
        hintText: "",
        text: patientData.fechaDeNacimiento != null
            ? DateFormat('dd/MM/yyyy').format(patientData.fechaDeNacimiento!)
            : "No registra",
        rightIcon: Icons.calendar_month_outlined,
        lines: 1,
        width: 220,
        height: 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Ocupación",
        hintText: "",
        text: patientData.ocupacion ?? "No registra",
        lines: 2,
        width: 460,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Estado civil",
        hintText: "",
        text: patientData.estadoCivil ?? "No registra",
        lines: 1,
        width: 220,
        height: 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Nacionalidad",
        hintText: "",
        text: patientData.nacionalidad ?? "No registra",
        lines: 1,
        width: 220,
        height: 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Grupo étnico",
        hintText: "",
        text: patientData.grupoEtnico ?? "No registra",
        lines: 1,
        width: 220,
        height: 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Otro grupo étnico",
        hintText: "",
        text: patientData.otroGrupoEtnico ?? "No registra",
        lines: 1,
        width: 220,
        height: 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Núm. de identificación",
        hintText: "",
        text: patientData.numDocDeIdentificacion ?? "No registra",
        lines: 1,
        width: 220,
        height: 94,
      ),
    ];
  }

  List<Widget> healthcareRecordContent({
    required HealthcareRecord healthcareRecord,
    required CustomSize customSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        title: "Número de historia clínica",
        hintText: "",
        text: healthcareRecord.numeroDeHistoriaClinica ?? "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Hospital",
        hintText: "",
        text: healthcareRecord.hospital ?? "No registra",
        lines: 2,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Fecha y hora de llegada del paciente",
        hintText: "",
        text: healthcareRecord.fechaYHoraDeLlegadaDelPaciente != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeLlegadaDelPaciente!)
            : "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Referido",
        hintText: "",
        text: healthcareRecord.referido != null
            ? healthcareRecord.referido!
                ? 'Sí'
                : 'No'
            : "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Policía notificada",
        hintText: "",
        text: healthcareRecord.policiaNotificada != null
            ? healthcareRecord.policiaNotificada!
                ? 'Sí'
                : 'No'
            : "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Fecha y hora llegada del médico",
        hintText: "",
        text: healthcareRecord.fechaYHoraDeLlegadaDelMedico != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeLlegadaDelMedico!)
            : "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Fecha y hora de notificación al médico",
        hintText: "",
        text: healthcareRecord.fechaYHoraDeNotificacionAlMedico != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeNotificacionAlMedico!)
            : "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Alerta a equipo de trauma",
        hintText: "",
        text: healthcareRecord.alertaEquipoDeTrauma != null
            ? healthcareRecord.alertaEquipoDeTrauma!
                ? 'Sí'
                : 'No'
            : "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Nivel de alerta",
        hintText: "",
        text: healthcareRecord.nivelDeAlerta ?? "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Paciente asegurado",
        hintText: "",
        text: healthcareRecord.pacienteAsegurado != null
            ? healthcareRecord.pacienteAsegurado!
                ? 'Sí'
                : 'No'
            : "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Tipo de seguro",
        hintText: "",
        text: healthcareRecord.tipoDeSeguro ?? "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Motivo de consulta",
        hintText: "",
        text: healthcareRecord.motivoDeConsulta ?? "No registra",
        lines: 10,
        // width: 460,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Inmunización contra el tétanos",
        hintText: "",
        text: healthcareRecord.inmunizacionContraElTetanos ?? "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Descripción del examen físico",
        hintText: "",
        text: healthcareRecord.descripcionDelExamenFisico ?? "No registra",
        lines: 15,
        // width: double.infinity,
        // height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Mecanismo primario",
        hintText: "",
        text: healthcareRecord.mecanismoPrimario ?? "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Número de lesiones seria",
        hintText: "",
        text: healthcareRecord.numeroDeLesionesSerias ?? "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Descripción del diagnóstico",
        hintText: "",
        text: healthcareRecord.descripcionDelDiagnostico ?? "No registra",
        lines: 5,
        // width: double.infinity,
        // height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Disposición o destino del paciente",
        hintText: "",
        text: healthcareRecord.disposicionODestinoDelPaciente ?? "No registra",
        lines: 1,
        width: 460,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Donación de órganos",
        hintText: "",
        text: healthcareRecord.donacionDeOrganos ?? "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Autopsia",
        hintText: "",
        text: healthcareRecord.autopsia ?? "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Muerte prevenible",
        hintText: "",
        text: healthcareRecord.muertePrevenible ?? "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Tipo de admisión",
        hintText: "",
        text: healthcareRecord.tipoDeAdmision ?? "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Fecha y hora de la disposición",
        hintText: "",
        text: healthcareRecord.fechaYHoraDeLaDisposicion != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeLaDisposicion!)
            : "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Tiempo en sala de emergencias (horas)",
        hintText: "",
        text:
            "${healthcareRecord.tiempoEnSalaDeEmergenciasHoras ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Tiempo en sala de emergencias (minutos)",
        hintText: "",
        text:
            "${healthcareRecord.tiempoEnSalaDeEmergenciasMinutos ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Número de referencia del ED",
        hintText: "",
        text: healthcareRecord.numeroDeReferenciaDelEd ?? "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Fecha de admisión",
        hintText: "",
        text: healthcareRecord.fechaDeAdmision != null
            ? DateFormat('dd/MM/yyyy').format(healthcareRecord.fechaDeAdmision!)
            : "No registra",
        rightIcon: Icons.calendar_month_outlined,
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Fecha y hora de alta",
        hintText: "",
        text: healthcareRecord.fechaYHoraDeAlta != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeAlta!)
            : "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Días de hospitalización",
        hintText: "",
        text: "${healthcareRecord.diasDeHospitalizacion ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Días en UCI",
        hintText: "",
        text: "${healthcareRecord.uciDias ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Detalles de hospitalización",
        hintText: "",
        text: healthcareRecord.detallesDeHospitalizacion ?? "No registra",
        lines: 5,
        // width: double.infinity,
        // height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Disposición o destino del paciente (hospitalización)",
        hintText: "",
        text:
            healthcareRecord.disposicionODestinoDelPacienteDelHospitalizacion ??
                "No registra",
        lines: 1,
        width: 460,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Donación de órganos (hospitalización)",
        hintText: "",
        text: healthcareRecord.donacionDeOrganosDelHospitalizacion ??
            "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Autopsia (hospitalización)",
        hintText: "",
        text: healthcareRecord.autopsiaDelHospitalizacion ?? "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Muerte prevenible (hospitalización)",
        hintText: "",
        text: healthcareRecord.muertePrevenibleDelHospitalizacion ??
            "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Número de referencia (hospitalización)",
        hintText: "",
        text: healthcareRecord.numeroDeReferenciaDelHospitalizacion ??
            "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Agencia de transporte",
        hintText: "",
        text: healthcareRecord.agenciaDeTransporte ?? "No registra",
        lines: 2,
        width: 460,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Origen del transporte",
        hintText: "",
        text: healthcareRecord.origenDelTransporte ?? "No registra",
        lines: 2,
        width: 460,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Número de registro del transporte",
        hintText: "",
        text: healthcareRecord.numeroDeRegistroDelTransporte ?? "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Fecha y hora de notificación prehospitalaria",
        hintText: "",
        text: healthcareRecord.fechaYHoraDeNotificacionPreHospitalaria != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss').format(
                healthcareRecord.fechaYHoraDeNotificacionPreHospitalaria!)
            : "No registra",
        lines: 1,
        width: 460,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Fecha y hora de llegada a la escena",
        hintText: "",
        text: healthcareRecord.fechaYHoraDeLlegadaALaEscena != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeLlegadaALaEscena!)
            : "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Fecha y hora de salida de la escena",
        hintText: "",
        text: healthcareRecord.fechaYHoraDeSalidaDeLaEscena != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeSalidaDeLaEscena!)
            : "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Razón de la demora",
        hintText: "",
        text: healthcareRecord.razonDeLaDemora ?? "No registra",
        lines: 2,
        width: 460,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Reporte o formulario prehospitalario entregado",
        hintText: "",
        text:
            healthcareRecord.reporteOFormularioPreHospitalarioEntregado != null
                ? healthcareRecord.reporteOFormularioPreHospitalarioEntregado!
                    ? 'Sí'
                    : 'No'
                : "No registra",
        lines: 1,
        width: 460,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Ciudad del hospital más cercano al sitio del incidente",
        hintText: "",
        text: healthcareRecord.ciudadHospitalMasCercanoAlSitioDelIncidente ??
            "No registra",
        lines: 2,
        width: 460,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Tiempo de extricación (horas)",
        hintText: "",
        text: "${healthcareRecord.tiempoDeExtricacionHoras ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Tiempo de extricación (minutos)",
        hintText: "",
        text: "${healthcareRecord.tiempoDeExtricacionMinutos ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Duración del transporte (horas)",
        hintText: "",
        text: "${healthcareRecord.duracionDelTransporteHoras ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Duración del transporte (minutos)",
        hintText: "",
        text:
            "${healthcareRecord.duracionDelTransporteMinutos ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Procedimiento realizado",
        hintText: "",
        text: healthcareRecord.procedimientoRealizado ?? "No registra",
        lines: 2,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Frecuencia cardíaca en la escena",
        hintText: "",
        text:
            "${healthcareRecord.frecuenciaCardiacaEnLaEscena ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Presión arterial sistólica en la escena",
        hintText: "",
        text:
            "${healthcareRecord.presionArterialSistolicaEnLaEscena ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Presión arterial diastólica en la escena",
        hintText: "",
        text:
            "${healthcareRecord.presionArterialDiastolicaEnLaEscena ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Frecuencia respiratoria en la escena",
        hintText: "",
        text:
            "${healthcareRecord.frecuenciaRespiratoriaEnLaEscena ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Calificador de frecuencia respiratoria en la escena",
        hintText: "",
        text: healthcareRecord.calificadorDeFrecuenciaRespiratoriaEnLaEscena ??
            "No registra",
        lines: 2,
        width: 460,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Temperatura en la escena (°C)",
        hintText: "",
        text:
            "${healthcareRecord.temperaturaEnLaEscenaCelsius ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Saturación de O₂ en la escena",
        hintText: "",
        text: "${healthcareRecord.saturacionDeO2EnLaEscena ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Frecuencia cardíaca durante el transporte",
        hintText: "",
        text:
            "${healthcareRecord.frecuenciaCardiacaDuranteElTransporte ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Presión arterial sistólica durante el transporte",
        hintText: "",
        text:
            "${healthcareRecord.presionArterialSistolicaDeTransporte ?? "No registra"}",
        lines: 1,
        width: 460,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Frecuencia respiratoria durante el transporte",
        hintText: "",
        text:
            "${healthcareRecord.frecuenciaRespiratoriaDuranteElTransporte ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Calificador de frecuencia respiratoria durante el transporte",
        hintText: "",
        text: healthcareRecord
                .calificadorDeFrecuenciaRespiratoriaDuranteElTransporte ??
            "No registra",
        lines: 2,
        width: 460,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Temperatura durante el transporte (°C)",
        hintText: "",
        text:
            "${healthcareRecord.temperaturaDuranteElTransporteCelsius ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Saturación de O₂ durante el transporte",
        hintText: "",
        text:
            "${healthcareRecord.saturacionDeO2DuranteElTransporte ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Pérdida de conciencia",
        hintText: "",
        text: "${healthcareRecord.perdidaDeConciencia ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Duración de pérdida de conciencia",
        hintText: "",
        text: (healthcareRecord.duracionDePerdidaDeConciencia ?? "No registra")
            .toString(),
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "GCS ocular",
        hintText: "",
        text: "${healthcareRecord.gcsOcular ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "GCS verbal",
        hintText: "",
        text: "${healthcareRecord.gcsVerbal ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "GCS motora",
        hintText: "",
        text: "${healthcareRecord.gcsMotora ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "GCS total",
        hintText: "",
        text: "${healthcareRecord.gcsTotal ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Sangre (L)",
        hintText: "",
        text: "${healthcareRecord.sangreL ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Coloides (L)",
        hintText: "",
        text: "${healthcareRecord.coloidesL ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Cristaloides (L)",
        hintText: "",
        text: "${healthcareRecord.cristaloidesL ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Hallazgos clínicos (texto)",
        hintText: "",
        text: healthcareRecord.hallazgosClinicosTexto ?? "No registra",
        lines: 5,
        // width: double.infinity,
        // height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Fecha y hora de envío de contrarreferencia",
        hintText: "",
        text: healthcareRecord.fechaYHoraDeEnvioDeContraReferencia != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeEnvioDeContraReferencia!)
            : "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Fecha de alta de contrarreferencia",
        hintText: "",
        text: healthcareRecord.fechaDeAltaDeContrarReferencia != null
            ? DateFormat('dd/MM/yyyy')
                .format(healthcareRecord.fechaDeAltaDeContrarReferencia!)
            : "No registra",
        rightIcon: Icons.calendar_month_outlined,
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Hallazgos clínicos (existencia)",
        hintText: "",
        text: healthcareRecord.hallazgosClinicosExistencia != null
            ? healthcareRecord.hallazgosClinicosExistencia!
                ? 'Sí'
                : 'No'
            : "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Servicio que atendió",
        hintText: "",
        text: healthcareRecord.servicioQueAtendio ?? "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Paciente admitido",
        hintText: "",
        text: healthcareRecord.pacienteAdmitido != null
            ? healthcareRecord.pacienteAdmitido!
                ? 'Sí'
                : 'No'
            : "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Hospital que recibe",
        hintText: "",
        text: healthcareRecord.hospitalQueRecibe ?? "No registra",
        lines: 2,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Otro servicio",
        hintText: "",
        text: healthcareRecord.otroServicio ?? "No registra",
        lines: 2,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Servicio que recibe",
        hintText: "",
        text: healthcareRecord.servicioQueRecibe ?? "No registra",
        lines: 2,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Recomendaciones",
        hintText: "",
        text: healthcareRecord.recomendaciones ?? "No registra",
        lines: 2,
        width: 460,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Número de referencia de referencias salientes",
        hintText: "",
        text: healthcareRecord.numeroDeReferenciaDeReferenciasSalientes ??
            "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Fecha de envío de referencia",
        hintText: "",
        text: healthcareRecord.fechaDeEnvioDeReferencia != null
            ? DateFormat('dd/MM/yyyy')
                .format(healthcareRecord.fechaDeEnvioDeReferencia!)
            : "No registra",
        rightIcon: Icons.calendar_month_outlined,
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Fecha de referencia",
        hintText: "",
        text: healthcareRecord.fechaDeReferencia != null
            ? DateFormat('dd/MM/yyyy')
                .format(healthcareRecord.fechaDeReferencia!)
            : "No registra",
        rightIcon: Icons.calendar_month_outlined,
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Razón de la referencia",
        hintText: "",
        text: healthcareRecord.razonDeLaReferencia ?? "No registra",
        lines: 5,
        // width: double.infinity,
        // height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Médico que refiere",
        hintText: "",
        text: healthcareRecord.medicoQueRefiere ?? "No registra",
        lines: 2,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Estado de la referencia",
        readOnly: true,
        hintText: "",
        text: healthcareRecord.estadoDeReferencia ?? "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Fecha de aceptación de la referencia",
        hintText: "",
        text: healthcareRecord.fechaDeAceptacionDeReferencia != null
            ? DateFormat('dd/MM/yyyy')
                .format(healthcareRecord.fechaDeAceptacionDeReferencia!)
            : "No registra",
        rightIcon: Icons.calendar_month_outlined,
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "ISS",
        hintText: "",
        text: "${healthcareRecord.iss ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "KTS",
        hintText: "",
        text: "${healthcareRecord.kts ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "RTS",
        hintText: "",
        text: "${healthcareRecord.rts ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Abdomen",
        hintText: "",
        text: "${healthcareRecord.abdomen ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Tórax",
        hintText: "",
        text: "${healthcareRecord.torax ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Externo",
        hintText: "",
        text: "${healthcareRecord.externo ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Extremidades",
        hintText: "",
        text: "${healthcareRecord.extremidades ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Cara",
        hintText: "",
        text: "${healthcareRecord.cara ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Cabeza",
        hintText: "",
        text: "${healthcareRecord.cabeza ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "TRISS contuso",
        hintText: "",
        text: "${healthcareRecord.trissContuso ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "TRISS penetrante",
        hintText: "",
        text: "${healthcareRecord.trissPenetrante ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
    ];
  }

  List<Widget> injuryRecordContent({
    required InjuryRecord injuryRecord,
    required CustomSize customSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        title: "Consumo de alcohol",
        hintText: "",
        text: injuryRecord.consumoDeAlcohol ?? "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Valor de alcoholemia",
        hintText: "",
        text: "${injuryRecord.valorDeAlcoholemia ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Unidad de alcohol",
        hintText: "",
        text: injuryRecord.unidadDeAlcohol ?? "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Otra sustancia de abuso",
        hintText: "",
        text: injuryRecord.otraSustanciaDeAbuso ?? "No registra",
        lines: 2,
        width: 460,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Dirección / nombre del lugar",
        hintText: "",
        text: injuryRecord.direccionNombreDelLugar ?? "No registra",
        lines: 2,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Ciudad del evento de la lesión",
        hintText: "",
        text: injuryRecord.ciudadDeEventoDeLaLesion ?? "No registra",
        lines: 2,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Condado de lesiones",
        hintText: "",
        text: injuryRecord.condadoDeLesiones ?? "No registra",
        lines: 2,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Estado / provincia de lesiones",
        hintText: "",
        text: injuryRecord.estadoProvinciaDeLesiones ?? "No registra",
        lines: 1,
        width: 440,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "País de lesiones",
        hintText: "",
        text: injuryRecord.paisDeLesiones ?? "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Código postal de lesiones",
        hintText: "",
        text: injuryRecord.codigoPostalDeLesiones ?? "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Fecha y hora del evento",
        hintText: "",
        text: injuryRecord.fechaYHoraDelEvento != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(injuryRecord.fechaYHoraDelEvento!)
            : "No registra",
        // rightIcon: Icons.calendar_month_outlined,
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Accidente de tráfico",
        hintText: "",
        text: injuryRecord.accidenteDeTrafico != null
            ? injuryRecord.accidenteDeTrafico!
                ? 'Sí'
                : 'No'
            : "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Tipo de vehículo",
        hintText: "",
        text: injuryRecord.tipoDeVehiculo ?? "No registra",
        lines: 2,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Ocupante",
        hintText: "",
        text: injuryRecord.ocupante ?? "No registra",
        lines: 2,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Velocidad de colisión",
        hintText: "",
        text: injuryRecord.velocidadDeColision ?? "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "SCQ (%)",
        hintText: "",
        text: "${injuryRecord.scq ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Caída",
        hintText: "",
        text: injuryRecord.caida != null
            ? injuryRecord.caida!
                ? 'Sí'
                : 'No'
            : "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Altura (metros)",
        hintText: "",
        text: "${injuryRecord.alturaMetros ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Tipo de superficie",
        hintText: "",
        text: injuryRecord.tipoDeSuperficie ?? "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
    ];
  }

  List<Widget> collisionContent({
    required Collision collision,
    required CustomSize customSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        title: "Tipo de colisión",
        hintText: "",
        text: collision.tipoDeColision ?? "No registra",
        lines: 2,
        width: 460,
      ),
    ];
  }

  List<Widget> drugAbuseContent({
    required DrugAbuse drugAbuse,
    required CustomSize customSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        title: "Tipo de droga",
        hintText: "",
        text: drugAbuse.tipoDeDroga ?? "No registra",
        lines: 2,
        width: 460,
      ),
    ];
  }

  List<Widget> vitalSignGcsQualifierContent({
    required VitalSignGcsQualifier vitalSignGcsQualifier,
    required CustomSize customSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        title: "Calificador GCS",
        hintText: "",
        text: vitalSignGcsQualifier.calificadorGcs ?? "No registra",
        lines: 2,
        width: 460,
      ),
    ];
  }

  List<Widget> hospitalizationVariableContent({
    required HospitalizationVariable hospitalizationVariable,
    required CustomSize customSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        title: "Tipo de variable",
        hintText: "",
        text: hospitalizationVariable.tipoDeVariable ?? "No registra",
        lines: 2,
        width: 220,
        height: 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Valor de la variable",
        hintText: "",
        text: hospitalizationVariable.valorDeLaVariable ?? "No registra",
        lines: 1,
        width: 220,
        height: 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Fecha y hora de la variable",
        hintText: "",
        text: hospitalizationVariable.fechaYHoraDeLaVariable != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(hospitalizationVariable.fechaYHoraDeLaVariable!)
            : "No registra",
        lines: 1,
        width: 220,
        height: 153,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Localización de la variable",
        hintText: "",
        text: hospitalizationVariable.localizacionDeVariable ?? "No registra",
        lines: 3,
        width: 220,
        height: 153,
      ),
    ];
  }

  List<Widget> hospitalizationComplicationContent({
    required HospitalizationComplication hospitalizationComplication,
    required CustomSize customSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        title: "Tipo de complicación",
        hintText: "",
        text: hospitalizationComplication.tipoDeComplicacion ?? "No registra",
        lines: 2,
        width: 460,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Fecha y hora de la complicación",
        hintText: "",
        text: hospitalizationComplication.fechaYHoraDeComplicacion != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(hospitalizationComplication.fechaYHoraDeComplicacion!)
            : "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Lugar de la complicación",
        hintText: "",
        text: hospitalizationComplication.lugarDeComplicacion ?? "No registra",
        lines: 2,
        width: 220,
        height: 124,
      ),
    ];
  }

  List<Widget> traumaRegisterIcd10Content({
    required TraumaRegisterIcd10 traumaRegisterIcd10,
    required CustomSize customSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        title: "Descripción",
        hintText: "",
        text: traumaRegisterIcd10.descripcion ?? "No registra",
        lines: 4,
        width: 460,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Mecanismo ICD",
        hintText: "",
        text: traumaRegisterIcd10.mecanismoIcd ?? "No registra",
        lines: 1,
        width: 460,
      ),
    ];
  }

  List<Widget> intensiveCareUnitContent({
    required IntensiveCareUnit intensiveCareUnit,
    required CustomSize customSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        title: "Tipo",
        hintText: "",
        text: intensiveCareUnit.tipo ?? "No registra",
        lines: 2,
        width: 460,
        height: 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Fecha y hora de inicio",
        hintText: "",
        text: intensiveCareUnit.fechaYHoraDeInicio != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(intensiveCareUnit.fechaYHoraDeInicio!)
            : "No registra",
        lines: 1,
        width: 220,
        height: 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Fecha y hora de terminación",
        hintText: "",
        text: intensiveCareUnit.fechaYHoraDeTermino != null
            ? DateFormat('dd/MM/yyyy')
                .format(intensiveCareUnit.fechaYHoraDeTermino!)
            : "No registra",
        lines: 1,
        width: 220,
        height: 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Lugar",
        hintText: "",
        text: intensiveCareUnit.lugar ?? "No registra",
        lines: 3,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Días de UCI",
        hintText: "",
        text: "${intensiveCareUnit.icuDays ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
    ];
  }

  List<Widget> imagingContent({
    required Imaging imaging,
    required CustomSize customSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        title: "Tipo de imagen",
        hintText: "",
        text: imaging.tipoDeImagen ?? "No registra",
        lines: 2,
        width: 220,
        height: 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Parte del cuerpo",
        hintText: "",
        text: imaging.parteDelCuerpo ?? "No registra",
        lines: 2,
        width: 220,
        height: 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Opción",
        hintText: "",
        text: imaging.opcion != null
            ? imaging.opcion!
                ? 'Sí'
                : 'No'
            : "No registra",
        lines: 1,
        width: 220,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Descripción",
        hintText: "",
        text: imaging.descripcion ?? "No registra",
        lines: 9,
        width: 460,
      ),
    ];
  }

  List<Widget> apparentIntentInjuryContent({
    required ApparentIntentInjury apparentIntentInjury,
    required CustomSize customSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        title: "Intesión aparente",
        hintText: "",
        text: apparentIntentInjury.intencionAparente ?? "No registra",
        lines: 1,
        width: 460,
      ),
    ];
  }

  List<Widget> burnInjuryContent({
    required BurnInjury burnInjury,
    required CustomSize customSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        title: "Tipo de quemadura",
        hintText: "",
        text: burnInjury.tipoDeQuemadura ?? "No registra",
        lines: 1,
        width: 460,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Grado de quemadura",
        hintText: "",
        text: burnInjury.gradoDeQuemadura ?? "No registra",
        lines: 1,
        width: 460,
      ),
    ];
  }

  List<Widget> firearmInjuryContent({
    required FirearmInjury firearmInjury,
    required CustomSize customSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        title: "Tipo de arma de fuego",
        hintText: "",
        text: firearmInjury.tipoDeArmaDeFuego ?? "No registra",
        lines: 1,
        width: 460,
      ),
    ];
  }

  List<Widget> penetratingInjuryContent({
    required PenetratingInjury penetratingInjury,
    required CustomSize customSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        title: "Tipo de lesión penetrante",
        hintText: "",
        text: penetratingInjury.tipoDeLesionPenetrante ?? "No registra",
        lines: 1,
        width: 460,
      ),
    ];
  }

  List<Widget> poisoningInjuryContent({
    required PoisoningInjury poisoningInjury,
    required CustomSize customSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        title: "Tipo de envenenamiento",
        hintText: "",
        text: poisoningInjury.tipoDeEnvenenamiento ?? "No registra",
        lines: 1,
        width: 460,
      ),
    ];
  }

  List<Widget> violenceInjuryContent({
    required ViolenceInjury violenceInjury,
    required CustomSize customSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        title: "Tipo de violencia",
        hintText: "",
        text: violenceInjury.tipoDeViolencia ?? "No registra",
        lines: 1,
        width: 460,
      ),
    ];
  }

  List<Widget> deviceContent({
    required Device device,
    required CustomSize customSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        title: "Tipo de dispositivo",
        hintText: "",
        text: device.tipoDeDispositivo ?? "No registra",
        lines: 1,
        width: 460,
      ),
    ];
  }

  List<Widget> laboratoryContent({
    required Laboratory laboratory,
    required CustomSize customSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        title: "Resultado de laboratorio",
        hintText: "",
        text: laboratory.resultadoDeLaboratorio ?? "No registra",
        lines: 2,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Fecha y hora de laboratorio",
        hintText: "",
        text: laboratory.fechaYHoraDeLaboratorio != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(laboratory.fechaYHoraDeLaboratorio!)
            : "No registra",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Nombre de la prueba de laboratorio",
        hintText: "",
        text: laboratory.nombreDelLaboratorio ?? "No registra",
        lines: 3,
        width: 220,
        height: 154,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Nombre de la unidad de laboratorio",
        hintText: "",
        text: laboratory.nombreDeLaUnidadDeLaboratorio ?? "No registra",
        lines: 1,
        width: 220,
        height: 154,
      ),
    ];
  }

  List<Widget> physicalExamBodyPartInjuryContent({
    required PhysicalExamBodyPartInjury physicalExamBodyPartInjury,
    required CustomSize customSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        title: "Parte del cuerpo",
        hintText: "",
        text: physicalExamBodyPartInjury.parteDelCuerpo ?? "No registra",
        lines: 1,
        width: 460,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Tipo de lesión",
        hintText: "",
        text: physicalExamBodyPartInjury.tipoDeLesion ?? "No registra",
        lines: 1,
        width: 460,
      ),
    ];
  }

  List<Widget> procedureContent({
    required Procedure procedure,
    required CustomSize customSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        title: "Procedimiento realizado",
        hintText: "",
        text: procedure.procedimientoRealizado ?? "No registra",
        lines: 4,
        width: 220,
        height: 184,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Lugar",
        hintText: "",
        text: procedure.lugar ?? "No registra",
        lines: 4,
        width: 220,
        height: 184,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Fecha y hora de inicio",
        hintText: "",
        text: procedure.fechaYHoraDeInicio != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(procedure.fechaYHoraDeInicio!)
            : "No registra",
        lines: 1,
        width: 220,
        height: 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Fecha y hora de terminación",
        hintText: "",
        text: procedure.fechaYHoraDeTermino != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(procedure.fechaYHoraDeTermino!)
            : "No registra",
        lines: 1,
        width: 220,
        height: 108,
      ),
    ];
  }

  List<Widget> prehospitalProcedureContent({
    required PrehospitalProcedure prehospitalProcedure,
    required CustomSize customSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        title: "Procedimiento realizado",
        hintText: "",
        text: prehospitalProcedure.procedimientoRealizado ?? "No registra",
        lines: 2,
        width: 460,
      ),
    ];
  }

  List<Widget> transportationModeContent({
    required TransportationMode transportationMode,
    required CustomSize customSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        title: "Modo de transporte",
        hintText: "",
        text: transportationMode.modoDeTransporte ?? "No registra",
        lines: 1,
        width: 460,
      ),
    ];
  }

  List<Widget> vitalSignContent({
    required VitalSign vitalSign,
    required CustomSize customSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        title: "Fecha y hora de la variable",
        hintText: "",
        text: vitalSign.fechaYHoraDeSignosVitales != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(vitalSign.fechaYHoraDeSignosVitales!)
            : "No registra",
        lines: 1,
        width: 220,
        height: 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Signos de vida",
        hintText: "",
        text: vitalSign.signosDeVida != null
            ? vitalSign.signosDeVida!
                ? 'Sí'
                : 'No'
            : "No registra",
        lines: 1,
        width: 220,
        height: 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Frecuencia cardiaca",
        hintText: "",
        text: "${vitalSign.frecuenciaCardiaca ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Presión arterial sistólica",
        hintText: "",
        text: "${vitalSign.presionArterialSistolica ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Presión arterial diastólica",
        hintText: "",
        text: "${vitalSign.presionArterialDiastolica ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Frecuencia respiratoria",
        hintText: "",
        text: "${vitalSign.frecuenciaRespiratoria ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Calificador de frecuencia respiratoria",
        hintText: "",
        text: vitalSign.calificadorDeFrecuenciaRespiratoria ?? "No registra",
        lines: 2,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Temperatura (celsius)",
        hintText: "",
        text: "${vitalSign.temperaturaCelsius ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Peso (kilogramos)",
        hintText: "",
        text: "${vitalSign.pesoKg ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Altura (metros)",
        hintText: "",
        text: "${vitalSign.alturaMetros ?? "No registra"}",
        lines: 1,
        width: 100,
        height: 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Saturación de oxígeno",
        hintText: "",
        text: "${vitalSign.saturacionDeOxigeno ?? "No registra"}",
        lines: 1,
        width: 100,
        height: 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Pérdida de conciencia",
        hintText: "",
        text: vitalSign.perdidaDeConciencia ?? "No registra",
        lines: 1,
        width: 220,
        height: 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "Duración de pérdida de conciencia",
        hintText: "",
        text: (vitalSign.duracionDePerdidaDeConciencia ?? "No registra")
            .toString(),
        lines: 1,
        width: 220,
        height: 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "GCS motora",
        hintText: "",
        text: "${vitalSign.gcsMotora ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "GCS ocular",
        hintText: "",
        text: "${vitalSign.gcsOcular ?? "No registra"}",
        lines: 1,
        width: 100,
        height: 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "GCS verbal",
        hintText: "",
        text: "${vitalSign.gcsVerbal ?? "No registra"}",
        lines: 1,
        width: 100,
        height: 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "GCS total",
        hintText: "",
        text: "${vitalSign.gcsTotal ?? "No registra"}",
        lines: 1,
        width: 220,
        height: 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        title: "AVUP",
        hintText: "",
        text: vitalSign.avup ?? "No registra",
        lines: 2,
        width: 220,
        height: 94,
      ),
    ];
  }
}
