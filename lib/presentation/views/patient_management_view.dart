import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/trauma_data.dart';
import 'package:trauma_register_frontend/data/services/navigation_service.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_checkbox.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_dropdown.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_modal.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class PatientManagementView extends StatefulWidget {
  const PatientManagementView({super.key});

  @override
  State<PatientManagementView> createState() => _PatientManagementViewState();
}

class _PatientManagementViewState extends State<PatientManagementView> {
  bool startSearch = false;
  bool isLoading = false;
  bool isMounted = false;
  bool allowEditFields = false;
  bool freeSize = false;
  String query = "Buscar";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final size = MediaQuery.of(context).size;
    freeSize = size.width < 585;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final BuildContext globalContext = NavigationService.navigatorKey.currentContext!;
      Provider.of<TraumaDataProvider>(globalContext, listen: false)
          .updatePatientData(null);
    });
    super.dispose();
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isMounted && context.mounted) {
        isMounted = true;
        final traumaDataProvider =
            Provider.of<TraumaDataProvider>(context, listen: false);
        const traumaDataProviderCount =
            24; // Number of ExpandableTitleWidget widgets

        // Initialize the expansion state (we only do this once)
        if (traumaDataProviderCount !=
            traumaDataProvider.currentAmountExpandedStates()) {
          traumaDataProvider.initializeExpansions(traumaDataProviderCount);
        }
      }
    });

    final PatientData? patientData =
        Provider.of<TraumaDataProvider>(context, listen: true).patientData;

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
            child: query == 'Crear'
                ? _ContentDataPatient(
                    allowEditFields: allowEditFields,
                    freeSize: freeSize,
                    customSize: CustomSize.h5,
                    isCreatingPatientData: true,
                  )
                : Column(
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
                          allowEditFields: allowEditFields,
                          freeSize: freeSize,
                          customSize: CustomSize.h5,
                          isCreatingPatientData: false,
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Center _customSearchBox() {
    final traumaDataProvider = Provider.of<TraumaDataProvider>(
      context,
      listen: true,
    );
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
            child: Column(
              children: [
                const SizedBox(width: double.infinity),
                Wrap(
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 20,
                  spacing: 30,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (query == 'Buscar')
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
                            onSubmitted: (String? value) async =>
                                await searchPatient(value ?? ''),
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.only(top: 40, bottom: 4),
                            child: CustomButton(
                              size: CustomSize.h2,
                              text: "Guardar datos",
                              width: 350,
                              centerButtonContent: true,
                              isAvailable: traumaDataProvider
                                      .patientData?.traumaRegisterRecordId !=
                                  null,
                              onPressed: () async => CustomModal.showModal(
                                context: context,
                                title: null,
                                text: "¿Desea crear el usuario?",
                                onPressedAccept: () async {
                                  final bool result = await traumaDataProvider
                                      .createPatientData(
                                          traumaDataProvider.patientData!);
                                  CustomModal.showModal(
                                    context: NavigationService
                                        .navigatorKey.currentContext!,
                                    title: null,
                                    showCancelButton: false,
                                    text: result
                                        ? "El usuario se ha creado satisfactoriamente."
                                        : "El usuario no se pudo crear, por favor inténtelo nuevamente.",
                                  );
                                },
                              ),
                            ),
                          ),
                        const SizedBox(height: 8),
                        Container(
                          constraints: const BoxConstraints(
                            maxWidth: 400,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Wrap(
                              runSpacing: 10,
                              alignment: WrapAlignment.spaceBetween,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 6,
                                    bottom: 6,
                                  ),
                                  child: CustomCheckbox(
                                    size: CustomSize.h5,
                                    text: "Desplegar todas las secciones",
                                    minWidthToCollapse: 440,
                                    onChanged: (bool value) {
                                      final traumaDataProvider =
                                          Provider.of<TraumaDataProvider>(
                                        context,
                                        listen: false,
                                      );
                                      traumaDataProvider.setAllExpanded(value);
                                    },
                                  ),
                                ),
                                if (query == "Buscar" &&
                                    traumaDataProvider.patientData != null)
                                  IconButton(
                                    onPressed: () {
                                      CustomModal.showModal(
                                        context: context,
                                        title: "Eliminar usuario",
                                        text:
                                            "¿Está seguro que desea eliminar éste usuario?",
                                        onPressedAccept: () async {
                                          final bool result =
                                              await traumaDataProvider
                                                  .deletePatientDataById(
                                                      traumaDataProvider
                                                          .patientData!
                                                          .traumaRegisterRecordId!
                                                          .toString());
                                          traumaDataProvider
                                              .updatePatientData(null);
                                          CustomModal.showModal(
                                            context: NavigationService
                                                .navigatorKey.currentContext!,
                                            title: null,
                                            showCancelButton: false,
                                            text: result
                                                ? "El usuario se ha eliminado satisfactoriamente."
                                                : "El usuario no se pudo eliminar, por favor inténtelo nuevamente.",
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.delete),
                                    iconSize: 25,
                                    color: AppColors.modalCancel,
                                    padding: EdgeInsets.zero,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: CustomDropdown(
                        size: CustomSize.h5,
                        title: "Selecciona la opción",
                        hintText: "Crear",
                        selectedValue: query,
                        width: 190,
                        items: const [
                          "Crear",
                          "Buscar",
                        ],
                        onItemSelected: (String? value) {
                          if (query == value) return;
                          allowEditFields = value == 'Crear';
                          traumaDataProvider.updatePatientData(
                              allowEditFields ? PatientData() : null);
                          if (!allowEditFields) {
                            startSearch = false;
                            isLoading = false;
                          }
                          setState(() => query = value!);
                        },
                      ),
                    ),
                  ],
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
    traumaDataProvider
        .updatePatientData(await traumaDataProvider.getPatientDataById(id));
    setState(() => isLoading = false);
  }
}

class _ContentDataPatient extends StatelessWidget {
  final CustomSize customSize;
  final bool allowEditFields;
  final bool freeSize;
  final bool isCreatingPatientData;

  const _ContentDataPatient({
    required this.customSize,
    required this.allowEditFields,
    required this.freeSize,
    required this.isCreatingPatientData,
  });

  @override
  Widget build(BuildContext context) {
    const noDataWidget = NormalText(text: "No hay datos en esta categoría");
    final patientData =
        Provider.of<TraumaDataProvider>(context, listen: true).patientData!;
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
              allowEditFields: allowEditFields,
              isCreatingPatientData: isCreatingPatientData,
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
                    allowEditFields: allowEditFields,
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
                    allowEditFields: allowEditFields,
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
                  : SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        children: patientData.collision!
                            .map(
                              (collision) => CustomContainer(
                                children: collisionContent(
                                  collision: collision,
                                  customSize: customSize,
                                  allowEditFields: allowEditFields,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Abusos de drogas",
          index: 4,
          expandedWidget:
              patientData.drugAbuse == null || patientData.drugAbuse!.isEmpty
                  ? noDataWidget
                  : SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        children: patientData.drugAbuse!
                            .map(
                              (drugAbuse) => CustomContainer(
                                children: drugAbuseContent(
                                  drugAbuse: drugAbuse,
                                  customSize: customSize,
                                  allowEditFields: allowEditFields,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Calificaciones de signos vitales GCS",
          index: 5,
          expandedWidget: patientData.vitalSignGcsQualifier == null ||
                  patientData.vitalSignGcsQualifier!.isEmpty
              ? noDataWidget
              : SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: patientData.vitalSignGcsQualifier!
                        .map(
                          (vitalSignGcsQualifier) => CustomContainer(
                            maxWidth: 600,
                            children: vitalSignGcsQualifierContent(
                              vitalSignGcsQualifier: vitalSignGcsQualifier,
                              customSize: customSize,
                              allowEditFields: allowEditFields,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Variables de hospitalización",
          index: 6,
          expandedWidget: patientData.hospitalizationVariable == null ||
                  patientData.hospitalizationVariable!.isEmpty
              ? noDataWidget
              : SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: patientData.hospitalizationVariable!
                        .map(
                          (hospitalizationVariable) => CustomContainer(
                            maxWidth: 600,
                            children: hospitalizationVariableContent(
                              hospitalizationVariable: hospitalizationVariable,
                              customSize: customSize,
                              allowEditFields: allowEditFields,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Complicaciones de hospitalización",
          index: 7,
          expandedWidget: patientData.hospitalizationComplication == null ||
                  patientData.hospitalizationComplication!.isEmpty
              ? noDataWidget
              : SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: patientData.hospitalizationComplication!
                        .map(
                          (hospitalizationComplication) => CustomContainer(
                            maxWidth: 600,
                            children: hospitalizationComplicationContent(
                              hospitalizationComplication:
                                  hospitalizationComplication,
                              allowEditFields: allowEditFields,
                              customSize: customSize,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Registros de trauma ICD10",
          index: 8,
          expandedWidget: patientData.traumaRegisterIcd10 == null ||
                  patientData.traumaRegisterIcd10!.isEmpty
              ? noDataWidget
              : SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: patientData.traumaRegisterIcd10!
                        .map(
                          (traumaRegisterIcd10) => CustomContainer(
                            maxWidth: 600,
                            children: traumaRegisterIcd10Content(
                              traumaRegisterIcd10: traumaRegisterIcd10,
                              customSize: customSize,
                              allowEditFields: allowEditFields,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Unidades de cuidados intensivos",
          index: 9,
          expandedWidget: patientData.intensiveCareUnit == null ||
                  patientData.intensiveCareUnit!.isEmpty
              ? noDataWidget
              : SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: patientData.intensiveCareUnit!
                        .map(
                          (intensiveCareUnit) => CustomContainer(
                            maxWidth: 600,
                            children: intensiveCareUnitContent(
                              intensiveCareUnit: intensiveCareUnit,
                              customSize: customSize,
                              allowEditFields: allowEditFields,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Imágenes",
          index: 10,
          expandedWidget:
              patientData.imaging == null || patientData.imaging!.isEmpty
                  ? noDataWidget
                  : SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        children: patientData.imaging!
                            .map(
                              (imaging) => CustomContainer(
                                maxWidth: 600,
                                children: imagingContent(
                                  imaging: imaging,
                                  customSize: customSize,
                                  allowEditFields: allowEditFields,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Lesiones intencionales aparentes",
          index: 11,
          expandedWidget: patientData.apparentIntentInjury == null ||
                  patientData.apparentIntentInjury!.isEmpty
              ? noDataWidget
              : SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: patientData.apparentIntentInjury!
                        .map(
                          (apparentIntentInjury) => CustomContainer(
                            maxWidth: 600,
                            children: apparentIntentInjuryContent(
                              apparentIntentInjury: apparentIntentInjury,
                              customSize: customSize,
                              allowEditFields: allowEditFields,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Lesiones por quemadura",
          index: 12,
          expandedWidget:
              patientData.burnInjury == null || patientData.burnInjury!.isEmpty
                  ? noDataWidget
                  : SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        children: patientData.burnInjury!
                            .map(
                              (burnInjury) => CustomContainer(
                                maxWidth: 600,
                                children: burnInjuryContent(
                                  burnInjury: burnInjury,
                                  customSize: customSize,
                                  allowEditFields: allowEditFields,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Lesiones por armas de fuego",
          index: 13,
          expandedWidget: patientData.firearmInjury == null ||
                  patientData.firearmInjury!.isEmpty
              ? noDataWidget
              : SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: patientData.firearmInjury!
                        .map(
                          (firearmInjury) => CustomContainer(
                            maxWidth: 600,
                            children: firearmInjuryContent(
                              firearmInjury: firearmInjury,
                              customSize: customSize,
                              allowEditFields: allowEditFields,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Lesiones penetrantes",
          index: 14,
          expandedWidget: patientData.penetratingInjury == null ||
                  patientData.penetratingInjury!.isEmpty
              ? noDataWidget
              : SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: patientData.penetratingInjury!
                        .map(
                          (penetratingInjury) => CustomContainer(
                            maxWidth: 600,
                            children: penetratingInjuryContent(
                              penetratingInjury: penetratingInjury,
                              customSize: customSize,
                              allowEditFields: allowEditFields,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Lesiones por envenenamiento",
          index: 15,
          expandedWidget: patientData.poisoningInjury == null ||
                  patientData.poisoningInjury!.isEmpty
              ? noDataWidget
              : SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: patientData.poisoningInjury!
                        .map(
                          (poisoningInjury) => CustomContainer(
                            maxWidth: 600,
                            children: poisoningInjuryContent(
                              poisoningInjury: poisoningInjury,
                              customSize: customSize,
                              allowEditFields: allowEditFields,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Lesiones violentas",
          index: 16,
          expandedWidget: patientData.violenceInjury == null ||
                  patientData.violenceInjury!.isEmpty
              ? noDataWidget
              : SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: patientData.violenceInjury!
                        .map(
                          (violenceInjury) => CustomContainer(
                            maxWidth: 600,
                            children: violenceInjuryContent(
                              violenceInjury: violenceInjury,
                              customSize: customSize,
                              allowEditFields: allowEditFields,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Dispositivos utilizados en accidente de tránsito",
          index: 17,
          expandedWidget:
              patientData.device == null || patientData.device!.isEmpty
                  ? noDataWidget
                  : SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        children: patientData.device!
                            .map(
                              (device) => CustomContainer(
                                maxWidth: 600,
                                children: deviceContent(
                                  device: device,
                                  customSize: customSize,
                                  allowEditFields: allowEditFields,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Exámenes de laboratorio",
          index: 18,
          expandedWidget:
              patientData.laboratory == null || patientData.laboratory!.isEmpty
                  ? noDataWidget
                  : SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        children: patientData.laboratory!
                            .map(
                              (laboratory) => CustomContainer(
                                maxWidth: 600,
                                children: laboratoryContent(
                                  laboratory: laboratory,
                                  customSize: customSize,
                                  allowEditFields: allowEditFields,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Exámenes físicos producto por lesión de partes del cuerpo",
          index: 19,
          expandedWidget: patientData.physicalExamBodyPartInjury == null ||
                  patientData.physicalExamBodyPartInjury!.isEmpty
              ? noDataWidget
              : SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: patientData.physicalExamBodyPartInjury!
                        .map(
                          (physicalExamBodyPartInjury) => CustomContainer(
                            maxWidth: 600,
                            children: physicalExamBodyPartInjuryContent(
                              physicalExamBodyPartInjury:
                                  physicalExamBodyPartInjury,
                              allowEditFields: allowEditFields,
                              customSize: customSize,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Procedimientos realizados",
          index: 20,
          expandedWidget:
              patientData.procedure == null || patientData.procedure!.isEmpty
                  ? noDataWidget
                  : SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        children: patientData.procedure!
                            .map(
                              (procedure) => CustomContainer(
                                maxWidth: 600,
                                children: procedureContent(
                                  procedure: procedure,
                                  customSize: customSize,
                                  allowEditFields: allowEditFields,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Procedimientos prehospitalarios realizados",
          index: 21,
          expandedWidget: patientData.prehospitalProcedure == null ||
                  patientData.prehospitalProcedure!.isEmpty
              ? noDataWidget
              : SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: patientData.prehospitalProcedure!
                        .map(
                          (prehospitalProcedure) => CustomContainer(
                            maxWidth: 600,
                            children: prehospitalProcedureContent(
                              prehospitalProcedure: prehospitalProcedure,
                              customSize: customSize,
                              allowEditFields: allowEditFields,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Modo de transporte",
          index: 22,
          expandedWidget: patientData.transportationMode == null ||
                  patientData.transportationMode!.isEmpty
              ? noDataWidget
              : SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: patientData.transportationMode!
                        .map(
                          (transportationMode) => CustomContainer(
                            maxWidth: 600,
                            children: transportationModeContent(
                              transportationMode: transportationMode,
                              customSize: customSize,
                              allowEditFields: allowEditFields,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Signos vitales",
          index: 23,
          expandedWidget:
              patientData.vitalSign == null || patientData.vitalSign!.isEmpty
                  ? noDataWidget
                  : SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        children: patientData.vitalSign!
                            .map(
                              (vitalSign) => CustomContainer(
                                maxWidth: 600,
                                children: vitalSignContent(
                                  vitalSign: vitalSign,
                                  customSize: customSize,
                                  allowEditFields: allowEditFields,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
        ),
      ],
    );
  }

  List<Widget> patientDataContent({
    required PatientData patientData,
    required CustomSize customSize,
    required bool allowEditFields,
    required bool isCreatingPatientData,
  }) {
    return [
      if (isCreatingPatientData)
        CustomInputWithLabel(
          size: customSize,
          readOnly: !allowEditFields,
          title: "ID registro de trauma",
          hintText: "No registra",
          text: (patientData.traumaRegisterRecordId ?? "").toString(),
          lines: 2,
          width: freeSize ? null : 220,
        ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Dirección línea 1",
        hintText: "No registra",
        text: patientData.direccionLinea1 ?? "",
        lines: 2,
        width: freeSize ? null : 220,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Dirección línea 2",
        hintText: "No registra",
        text: patientData.direccionLinea2 ?? "",
        lines: 2,
        width: freeSize ? null : 220,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Ciudad",
        hintText: "No registra",
        text: patientData.ciudad ?? "",
        lines: 2,
        width: freeSize ? null : 220,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Cantón / municipio",
        hintText: "No registra",
        text: patientData.cantonMunicipio ?? "",
        lines: 2,
        width: freeSize ? null : 220,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Provincia / estado",
        hintText: "No registra",
        text: patientData.provinciaEstado ?? "",
        lines: 2,
        width: freeSize ? null : 220,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Código postal",
        hintText: "No registra",
        text: patientData.codigoPostal ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "País",
        hintText: "No registra",
        text: patientData.pais ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Edad",
        hintText: "No registra",
        text: "${patientData.edad ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Unidad de edad",
        hintText: "No registra",
        text: patientData.unidadDeEdad ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Género",
        hintText: "No registra",
        text: patientData.genero ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Fecha de nacimiento",
        hintText: "No registra",
        text: patientData.fechaDeNacimiento != null
            ? DateFormat('dd/MM/yyyy').format(patientData.fechaDeNacimiento!)
            : "",
        rightIcon: Icons.calendar_month_outlined,
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Ocupación",
        hintText: "No registra",
        text: patientData.ocupacion ?? "",
        lines: 2,
        width: freeSize ? null : 460,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Estado civil",
        hintText: "No registra",
        text: patientData.estadoCivil ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Nacionalidad",
        hintText: "No registra",
        text: patientData.nacionalidad ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Grupo étnico",
        hintText: "No registra",
        text: patientData.grupoEtnico ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Otro grupo étnico",
        hintText: "No registra",
        text: patientData.otroGrupoEtnico ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Núm. de identificación",
        hintText: "No registra",
        text: patientData.numDocDeIdentificacion ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
      ),
    ];
  }

  List<Widget> healthcareRecordContent({
    required HealthcareRecord healthcareRecord,
    required CustomSize customSize,
    required bool allowEditFields,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Número de historia clínica",
        hintText: "No registra",
        text: healthcareRecord.numeroDeHistoriaClinica ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Hospital",
        hintText: "No registra",
        text: healthcareRecord.hospital ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Fecha y hora de llegada del paciente",
        hintText: "No registra",
        text: healthcareRecord.fechaYHoraDeLlegadaDelPaciente != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeLlegadaDelPaciente!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
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
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
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
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Fecha y hora llegada del médico",
        hintText: "No registra",
        text: healthcareRecord.fechaYHoraDeLlegadaDelMedico != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeLlegadaDelMedico!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Fecha y hora de notificación al médico",
        hintText: "No registra",
        text: healthcareRecord.fechaYHoraDeNotificacionAlMedico != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeNotificacionAlMedico!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
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
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Nivel de alerta",
        hintText: "No registra",
        text: healthcareRecord.nivelDeAlerta ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
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
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tipo de seguro",
        hintText: "No registra",
        text: healthcareRecord.tipoDeSeguro ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Motivo de consulta",
        hintText: "No registra",
        text: healthcareRecord.motivoDeConsulta ?? "",
        lines: 10,
        // width: freeSize ? null : 460,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Inmunización contra el tétanos",
        hintText: "No registra",
        text: healthcareRecord.inmunizacionContraElTetanos ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Descripción del examen físico",
        hintText: "No registra",
        text: healthcareRecord.descripcionDelExamenFisico ?? "",
        lines: 15,
        // width: freeSize ? null : double.infinity,
        // height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Mecanismo primario",
        hintText: "No registra",
        text: healthcareRecord.mecanismoPrimario ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Número de lesiones seria",
        hintText: "No registra",
        text: healthcareRecord.numeroDeLesionesSerias ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Descripción del diagnóstico",
        hintText: "No registra",
        text: healthcareRecord.descripcionDelDiagnostico ?? "",
        lines: 5,
        // width: freeSize ? null : double.infinity,
        // height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Disposición o destino del paciente",
        hintText: "No registra",
        text: healthcareRecord.disposicionODestinoDelPaciente ?? "",
        lines: 1,
        width: freeSize ? null : 460,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Donación de órganos",
        hintText: "No registra",
        text: healthcareRecord.donacionDeOrganos ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Autopsia",
        hintText: "No registra",
        text: healthcareRecord.autopsia ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Muerte prevenible",
        hintText: "No registra",
        text: healthcareRecord.muertePrevenible ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tipo de admisión",
        hintText: "No registra",
        text: healthcareRecord.tipoDeAdmision ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Fecha y hora de la disposición",
        hintText: "No registra",
        text: healthcareRecord.fechaYHoraDeLaDisposicion != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeLaDisposicion!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tiempo en sala de emergencias (horas)",
        hintText: "No registra",
        text: "${healthcareRecord.tiempoEnSalaDeEmergenciasHoras ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tiempo en sala de emergencias (minutos)",
        hintText: "No registra",
        text: "${healthcareRecord.tiempoEnSalaDeEmergenciasMinutos ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Número de referencia del ED",
        hintText: "No registra",
        text: healthcareRecord.numeroDeReferenciaDelEd ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Fecha de admisión",
        hintText: "No registra",
        text: healthcareRecord.fechaDeAdmision != null
            ? DateFormat('dd/MM/yyyy').format(healthcareRecord.fechaDeAdmision!)
            : "",
        rightIcon: Icons.calendar_month_outlined,
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Fecha y hora de alta",
        hintText: "No registra",
        text: healthcareRecord.fechaYHoraDeAlta != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeAlta!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Días de hospitalización",
        hintText: "No registra",
        text: "${healthcareRecord.diasDeHospitalizacion ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Días en UCI",
        hintText: "No registra",
        text: "${healthcareRecord.uciDias ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Detalles de hospitalización",
        hintText: "No registra",
        text: healthcareRecord.detallesDeHospitalizacion ?? "",
        lines: 5,
        // width: freeSize ? null : double.infinity,
        // height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Disposición o destino del paciente (hospitalización)",
        hintText: "No registra",
        text:
            healthcareRecord.disposicionODestinoDelPacienteDelHospitalizacion ??
                "",
        lines: 1,
        width: freeSize ? null : 460,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Donación de órganos (hospitalización)",
        hintText: "No registra",
        text: healthcareRecord.donacionDeOrganosDelHospitalizacion ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Autopsia (hospitalización)",
        hintText: "No registra",
        text: healthcareRecord.autopsiaDelHospitalizacion ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Muerte prevenible (hospitalización)",
        hintText: "No registra",
        text: healthcareRecord.muertePrevenibleDelHospitalizacion ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Número de referencia (hospitalización)",
        hintText: "No registra",
        text: healthcareRecord.numeroDeReferenciaDelHospitalizacion ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Agencia de transporte",
        hintText: "No registra",
        text: healthcareRecord.agenciaDeTransporte ?? "",
        lines: 2,
        width: freeSize ? null : 460,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Origen del transporte",
        hintText: "No registra",
        text: healthcareRecord.origenDelTransporte ?? "",
        lines: 2,
        width: freeSize ? null : 460,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Número de registro del transporte",
        hintText: "No registra",
        text: healthcareRecord.numeroDeRegistroDelTransporte ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Fecha y hora de notificación prehospitalaria",
        hintText: "No registra",
        text: healthcareRecord.fechaYHoraDeNotificacionPreHospitalaria != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss').format(
                healthcareRecord.fechaYHoraDeNotificacionPreHospitalaria!)
            : "",
        lines: 1,
        width: freeSize ? null : 460,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Fecha y hora de llegada a la escena",
        hintText: "No registra",
        text: healthcareRecord.fechaYHoraDeLlegadaALaEscena != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeLlegadaALaEscena!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Fecha y hora de salida de la escena",
        hintText: "No registra",
        text: healthcareRecord.fechaYHoraDeSalidaDeLaEscena != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeSalidaDeLaEscena!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Razón de la demora",
        hintText: "No registra",
        text: healthcareRecord.razonDeLaDemora ?? "",
        lines: 2,
        width: freeSize ? null : 460,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
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
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Ciudad del hospital más cercano al sitio del incidente",
        hintText: "No registra",
        text:
            healthcareRecord.ciudadHospitalMasCercanoAlSitioDelIncidente ?? "",
        lines: 2,
        width: freeSize ? null : 460,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tiempo de extricación (horas)",
        hintText: "No registra",
        text: "${healthcareRecord.tiempoDeExtricacionHoras ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tiempo de extricación (minutos)",
        hintText: "No registra",
        text: "${healthcareRecord.tiempoDeExtricacionMinutos ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Duración del transporte (horas)",
        hintText: "No registra",
        text: "${healthcareRecord.duracionDelTransporteHoras ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Duración del transporte (minutos)",
        hintText: "No registra",
        text: "${healthcareRecord.duracionDelTransporteMinutos ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Procedimiento realizado",
        hintText: "No registra",
        text: healthcareRecord.procedimientoRealizado ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Frecuencia cardíaca en la escena",
        hintText: "No registra",
        text: "${healthcareRecord.frecuenciaCardiacaEnLaEscena ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Presión arterial sistólica en la escena",
        hintText: "No registra",
        text: "${healthcareRecord.presionArterialSistolicaEnLaEscena ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Presión arterial diastólica en la escena",
        hintText: "No registra",
        text: "${healthcareRecord.presionArterialDiastolicaEnLaEscena ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Frecuencia respiratoria en la escena",
        hintText: "No registra",
        text: "${healthcareRecord.frecuenciaRespiratoriaEnLaEscena ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Calificador de frecuencia respiratoria en la escena",
        hintText: "No registra",
        text: healthcareRecord.calificadorDeFrecuenciaRespiratoriaEnLaEscena ??
            "",
        lines: 2,
        width: freeSize ? null : 460,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Temperatura en la escena (°C)",
        hintText: "No registra",
        text: "${healthcareRecord.temperaturaEnLaEscenaCelsius ?? ""}",
        rightIcon: Icons.device_thermostat_outlined,
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Saturación de O₂ en la escena",
        hintText: "No registra",
        text: "${healthcareRecord.saturacionDeO2EnLaEscena ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Frecuencia cardíaca durante el transporte",
        hintText: "No registra",
        text: "${healthcareRecord.frecuenciaCardiacaDuranteElTransporte ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Presión arterial sistólica durante el transporte",
        hintText: "No registra",
        text: "${healthcareRecord.presionArterialSistolicaDeTransporte ?? ""}",
        lines: 1,
        width: freeSize ? null : 460,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Frecuencia respiratoria durante el transporte",
        hintText: "No registra",
        text:
            "${healthcareRecord.frecuenciaRespiratoriaDuranteElTransporte ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Calificador de frecuencia respiratoria durante el transporte",
        hintText: "No registra",
        text: healthcareRecord
                .calificadorDeFrecuenciaRespiratoriaDuranteElTransporte ??
            "",
        lines: 2,
        width: freeSize ? null : 460,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Temperatura durante el transporte (°C)",
        hintText: "No registra",
        text: "${healthcareRecord.temperaturaDuranteElTransporteCelsius ?? ""}",
        rightIcon: Icons.device_thermostat_outlined,
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Saturación de O₂ durante el transporte",
        hintText: "No registra",
        text: "${healthcareRecord.saturacionDeO2DuranteElTransporte ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Pérdida de conciencia",
        hintText: "No registra",
        text: "${healthcareRecord.perdidaDeConciencia ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Duración de pérdida de conciencia",
        hintText: "No registra",
        text: (healthcareRecord.duracionDePerdidaDeConciencia ?? "").toString(),
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "GCS ocular",
        hintText: "No registra",
        text: "${healthcareRecord.gcsOcular ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "GCS verbal",
        hintText: "No registra",
        text: "${healthcareRecord.gcsVerbal ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "GCS motora",
        hintText: "No registra",
        text: "${healthcareRecord.gcsMotora ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "GCS total",
        hintText: "No registra",
        text: "${healthcareRecord.gcsTotal ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Sangre (L)",
        hintText: "No registra",
        text: "${healthcareRecord.sangreL ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Coloides (L)",
        hintText: "No registra",
        text: "${healthcareRecord.coloidesL ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Cristaloides (L)",
        hintText: "No registra",
        text: "${healthcareRecord.cristaloidesL ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Hallazgos clínicos (texto)",
        hintText: "No registra",
        text: healthcareRecord.hallazgosClinicosTexto ?? "",
        lines: 5,
        // width: freeSize ? null : double.infinity,
        // height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Fecha y hora de envío de contrarreferencia",
        hintText: "No registra",
        text: healthcareRecord.fechaYHoraDeEnvioDeContraReferencia != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(healthcareRecord.fechaYHoraDeEnvioDeContraReferencia!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
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
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
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
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Servicio que atendió",
        hintText: "No registra",
        text: healthcareRecord.servicioQueAtendio ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
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
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Hospital que recibe",
        hintText: "No registra",
        text: healthcareRecord.hospitalQueRecibe ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Otro servicio",
        hintText: "No registra",
        text: healthcareRecord.otroServicio ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Servicio que recibe",
        hintText: "No registra",
        text: healthcareRecord.servicioQueRecibe ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Recomendaciones",
        hintText: "No registra",
        text: healthcareRecord.recomendaciones ?? "",
        lines: 2,
        width: freeSize ? null : 460,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Número de referencia de referencias salientes",
        hintText: "No registra",
        text: healthcareRecord.numeroDeReferenciaDeReferenciasSalientes ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
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
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
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
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Razón de la referencia",
        hintText: "No registra",
        text: healthcareRecord.razonDeLaReferencia ?? "",
        lines: 5,
        // width: freeSize ? null : double.infinity,
        // height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Médico que refiere",
        hintText: "No registra",
        text: healthcareRecord.medicoQueRefiere ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Estado de la referencia",
        hintText: "No registra",
        text: healthcareRecord.estadoDeReferencia ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
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
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "ISS",
        hintText: "No registra",
        text: "${healthcareRecord.iss ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "KTS",
        hintText: "No registra",
        text: "${healthcareRecord.kts ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "RTS",
        hintText: "No registra",
        text: "${healthcareRecord.rts ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Abdomen",
        hintText: "No registra",
        text: "${healthcareRecord.abdomen ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tórax",
        hintText: "No registra",
        text: "${healthcareRecord.torax ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Externo",
        hintText: "No registra",
        text: "${healthcareRecord.externo ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Extremidades",
        hintText: "No registra",
        text: "${healthcareRecord.extremidades ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Cara",
        hintText: "No registra",
        text: "${healthcareRecord.cara ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Cabeza",
        hintText: "No registra",
        text: "${healthcareRecord.cabeza ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "TRISS contuso",
        hintText: "No registra",
        text: "${healthcareRecord.trissContuso ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "TRISS penetrante",
        hintText: "No registra",
        text: "${healthcareRecord.trissPenetrante ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
    ];
  }

  List<Widget> injuryRecordContent({
    required InjuryRecord injuryRecord,
    required CustomSize customSize,
    required bool allowEditFields,
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

  List<Widget> collisionContent({
    required Collision collision,
    required CustomSize customSize,
    required bool allowEditFields,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tipo de colisión",
        hintText: "No registra",
        text: collision.tipoDeColision ?? "",
        lines: 2,
        width: freeSize ? null : 460,
      ),
    ];
  }

  List<Widget> drugAbuseContent({
    required DrugAbuse drugAbuse,
    required CustomSize customSize,
    required bool allowEditFields,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tipo de droga",
        hintText: "No registra",
        text: drugAbuse.tipoDeDroga ?? "",
        lines: 2,
        width: freeSize ? null : 460,
      ),
    ];
  }

  List<Widget> vitalSignGcsQualifierContent({
    required VitalSignGcsQualifier vitalSignGcsQualifier,
    required CustomSize customSize,
    required bool allowEditFields,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Calificador GCS",
        hintText: "No registra",
        text: vitalSignGcsQualifier.calificadorGcs ?? "",
        lines: 2,
        width: freeSize ? null : 460,
      ),
    ];
  }

  List<Widget> hospitalizationVariableContent({
    required HospitalizationVariable hospitalizationVariable,
    required CustomSize customSize,
    required bool allowEditFields,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tipo de variable",
        hintText: "No registra",
        text: hospitalizationVariable.tipoDeVariable ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Valor de la variable",
        hintText: "No registra",
        text: hospitalizationVariable.valorDeLaVariable ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Fecha y hora de la variable",
        hintText: "No registra",
        text: hospitalizationVariable.fechaYHoraDeLaVariable != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(hospitalizationVariable.fechaYHoraDeLaVariable!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 153,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Localización de la variable",
        hintText: "No registra",
        text: hospitalizationVariable.localizacionDeVariable ?? "",
        lines: 3,
        width: freeSize ? null : 220,
        height: freeSize ? null : 153,
      ),
    ];
  }

  List<Widget> hospitalizationComplicationContent({
    required HospitalizationComplication hospitalizationComplication,
    required CustomSize customSize,
    required bool allowEditFields,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tipo de complicación",
        hintText: "No registra",
        text: hospitalizationComplication.tipoDeComplicacion ?? "",
        lines: 2,
        width: freeSize ? null : 460,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Fecha y hora de la complicación",
        hintText: "No registra",
        text: hospitalizationComplication.fechaYHoraDeComplicacion != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(hospitalizationComplication.fechaYHoraDeComplicacion!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Lugar de la complicación",
        hintText: "No registra",
        text: hospitalizationComplication.lugarDeComplicacion ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
    ];
  }

  List<Widget> traumaRegisterIcd10Content({
    required TraumaRegisterIcd10 traumaRegisterIcd10,
    required CustomSize customSize,
    required bool allowEditFields,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Descripción",
        hintText: "No registra",
        text: traumaRegisterIcd10.descripcion ?? "",
        lines: 4,
        width: freeSize ? null : 460,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Mecanismo ICD",
        hintText: "No registra",
        text: traumaRegisterIcd10.mecanismoIcd ?? "",
        lines: 1,
        width: freeSize ? null : 460,
      ),
    ];
  }

  List<Widget> intensiveCareUnitContent({
    required IntensiveCareUnit intensiveCareUnit,
    required CustomSize customSize,
    required bool allowEditFields,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tipo",
        hintText: "No registra",
        text: intensiveCareUnit.tipo ?? "",
        lines: 2,
        width: freeSize ? null : 460,
        height: freeSize ? null : 94,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Fecha y hora de inicio",
        hintText: "No registra",
        text: intensiveCareUnit.fechaYHoraDeInicio != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(intensiveCareUnit.fechaYHoraDeInicio!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Fecha y hora de terminación",
        hintText: "No registra",
        text: intensiveCareUnit.fechaYHoraDeTermino != null
            ? DateFormat('dd/MM/yyyy')
                .format(intensiveCareUnit.fechaYHoraDeTermino!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Lugar",
        hintText: "No registra",
        text: intensiveCareUnit.lugar ?? "",
        lines: 3,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Días de UCI",
        hintText: "No registra",
        text: "${intensiveCareUnit.icuDays ?? ""}",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
    ];
  }

  List<Widget> imagingContent({
    required Imaging imaging,
    required CustomSize customSize,
    required bool allowEditFields,
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

  List<Widget> apparentIntentInjuryContent({
    required ApparentIntentInjury apparentIntentInjury,
    required CustomSize customSize,
    required bool allowEditFields,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Intesión aparente",
        hintText: "No registra",
        text: apparentIntentInjury.intencionAparente ?? "",
        lines: 1,
        width: freeSize ? null : 460,
      ),
    ];
  }

  List<Widget> burnInjuryContent({
    required BurnInjury burnInjury,
    required CustomSize customSize,
    required bool allowEditFields,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tipo de quemadura",
        hintText: "No registra",
        text: burnInjury.tipoDeQuemadura ?? "",
        lines: 1,
        width: freeSize ? null : 460,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Grado de quemadura",
        hintText: "No registra",
        text: burnInjury.gradoDeQuemadura ?? "",
        lines: 1,
        width: freeSize ? null : 460,
      ),
    ];
  }

  List<Widget> firearmInjuryContent({
    required FirearmInjury firearmInjury,
    required CustomSize customSize,
    required bool allowEditFields,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tipo de arma de fuego",
        hintText: "No registra",
        text: firearmInjury.tipoDeArmaDeFuego ?? "",
        lines: 1,
        width: freeSize ? null : 460,
      ),
    ];
  }

  List<Widget> penetratingInjuryContent({
    required PenetratingInjury penetratingInjury,
    required CustomSize customSize,
    required bool allowEditFields,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tipo de lesión penetrante",
        hintText: "No registra",
        text: penetratingInjury.tipoDeLesionPenetrante ?? "",
        lines: 1,
        width: freeSize ? null : 460,
      ),
    ];
  }

  List<Widget> poisoningInjuryContent({
    required PoisoningInjury poisoningInjury,
    required CustomSize customSize,
    required bool allowEditFields,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tipo de envenenamiento",
        hintText: "No registra",
        text: poisoningInjury.tipoDeEnvenenamiento ?? "",
        lines: 1,
        width: freeSize ? null : 460,
      ),
    ];
  }

  List<Widget> violenceInjuryContent({
    required ViolenceInjury violenceInjury,
    required CustomSize customSize,
    required bool allowEditFields,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tipo de violencia",
        hintText: "No registra",
        text: violenceInjury.tipoDeViolencia ?? "",
        lines: 1,
        width: freeSize ? null : 460,
      ),
    ];
  }

  List<Widget> deviceContent({
    required Device device,
    required CustomSize customSize,
    required bool allowEditFields,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tipo de dispositivo",
        hintText: "No registra",
        text: device.tipoDeDispositivo ?? "",
        lines: 1,
        width: freeSize ? null : 460,
      ),
    ];
  }

  List<Widget> laboratoryContent({
    required Laboratory laboratory,
    required CustomSize customSize,
    required bool allowEditFields,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Resultado de laboratorio",
        hintText: "No registra",
        text: laboratory.resultadoDeLaboratorio ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Fecha y hora de laboratorio",
        hintText: "No registra",
        text: laboratory.fechaYHoraDeLaboratorio != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(laboratory.fechaYHoraDeLaboratorio!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Nombre de la prueba de laboratorio",
        hintText: "No registra",
        text: laboratory.nombreDelLaboratorio ?? "",
        lines: 3,
        width: freeSize ? null : 220,
        height: freeSize ? null : 154,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Nombre de la unidad de laboratorio",
        hintText: "No registra",
        text: laboratory.nombreDeLaUnidadDeLaboratorio ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 154,
      ),
    ];
  }

  List<Widget> physicalExamBodyPartInjuryContent({
    required PhysicalExamBodyPartInjury physicalExamBodyPartInjury,
    required CustomSize customSize,
    required bool allowEditFields,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Parte del cuerpo",
        hintText: "No registra",
        text: physicalExamBodyPartInjury.parteDelCuerpo ?? "",
        lines: 1,
        width: freeSize ? null : 460,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tipo de lesión",
        hintText: "No registra",
        text: physicalExamBodyPartInjury.tipoDeLesion ?? "",
        lines: 1,
        width: freeSize ? null : 460,
      ),
    ];
  }

  List<Widget> procedureContent({
    required Procedure procedure,
    required CustomSize customSize,
    required bool allowEditFields,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Procedimiento realizado",
        hintText: "No registra",
        text: procedure.procedimientoRealizado ?? "",
        lines: 4,
        width: freeSize ? null : 220,
        height: freeSize ? null : 184,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Lugar",
        hintText: "No registra",
        text: procedure.lugar ?? "",
        lines: 4,
        width: freeSize ? null : 220,
        height: freeSize ? null : 184,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Fecha y hora de inicio",
        hintText: "No registra",
        text: procedure.fechaYHoraDeInicio != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(procedure.fechaYHoraDeInicio!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Fecha y hora de terminación",
        hintText: "No registra",
        text: procedure.fechaYHoraDeTermino != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(procedure.fechaYHoraDeTermino!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
      ),
    ];
  }

  List<Widget> prehospitalProcedureContent({
    required PrehospitalProcedure prehospitalProcedure,
    required CustomSize customSize,
    required bool allowEditFields,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Procedimiento realizado",
        hintText: "No registra",
        text: prehospitalProcedure.procedimientoRealizado ?? "",
        lines: 2,
        width: freeSize ? null : 460,
      ),
    ];
  }

  List<Widget> transportationModeContent({
    required TransportationMode transportationMode,
    required CustomSize customSize,
    required bool allowEditFields,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Modo de transporte",
        hintText: "No registra",
        text: transportationMode.modoDeTransporte ?? "",
        lines: 1,
        width: freeSize ? null : 460,
      ),
    ];
  }

  List<Widget> vitalSignContent({
    required VitalSign vitalSign,
    required CustomSize customSize,
    required bool allowEditFields,
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
