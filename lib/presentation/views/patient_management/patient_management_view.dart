import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/trauma_data.dart';
import 'package:trauma_register_frontend/data/services/navigation_service.dart';
import 'package:trauma_register_frontend/presentation/providers/expandable_title_provider.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/views/patient_management/patient_management.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_checkbox.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_dropdown.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_modal.dart';

class PatientManagementView extends StatefulWidget {
  const PatientManagementView({super.key});

  @override
  State<PatientManagementView> createState() => _PatientManagementViewState();
}

class _PatientManagementViewState extends State<PatientManagementView> {
  bool startSearch = false;
  bool isLoading = false;
  bool isMounted = false;
  bool isCreating = false;
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
      final BuildContext globalContext =
          NavigationService.navigatorKey.currentContext!;
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
        final expandableTitleProvider =
            Provider.of<ExpandableTitleProvider>(context, listen: false);
        const traumaDataProviderCount =
            24; // Number of ExpandableTitleWidget widgets

        // Initialize the expansion state (we only do this once)
        if (traumaDataProviderCount !=
            expandableTitleProvider.currentAmountExpandedStates()) {
          expandableTitleProvider.initializeExpansions(traumaDataProviderCount);
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
                    isCreating: isCreating,
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
                          isCreating: isCreating,
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
                            child: Consumer<TraumaDataProvider>(
                              builder: (context, traumaDataProvider, _) =>
                                  CustomButton(
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
                                    print(
                                        ">>>>>>>               ${traumaDataProvider.patientData}");
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
                                      final expandableTitleProvider =
                                          Provider.of<ExpandableTitleProvider>(
                                        context,
                                        listen: false,
                                      );
                                      expandableTitleProvider
                                          .setAllExpanded(value);
                                      final traumaDataProvider =
                                          Provider.of<TraumaDataProvider>(
                                        context,
                                        listen: false,
                                      );
                                      print(traumaDataProvider.patientData);
                                    },
                                  ),
                                ),
                                Consumer<TraumaDataProvider>(
                                  builder: (context, traumaDataProvider,
                                          child) =>
                                      (query == "Buscar" &&
                                              traumaDataProvider.patientData !=
                                                  null)
                                          ? IconButton(
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
                                                        .updatePatientData(
                                                            null);
                                                    CustomModal.showModal(
                                                      context: NavigationService
                                                          .navigatorKey
                                                          .currentContext!,
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
                                            )
                                          : const SizedBox.shrink(),
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
                          isCreating = value == 'Crear';
                          Provider.of<TraumaDataProvider>(context,
                                  listen: false)
                              .updatePatientData(
                                  isCreating ? PatientData() : null);
                          if (!isCreating) {
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
  final bool isCreating;
  final bool freeSize;
  final bool isCreatingPatientData;

  const _ContentDataPatient({
    required this.customSize,
    required this.isCreating,
    required this.freeSize,
    required this.isCreatingPatientData,
  });

  @override
  Widget build(BuildContext context) {
    const noDataWidget = NormalText(text: "No hay datos en esta categoría");
    final traumaProvider =
        Provider.of<TraumaDataProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PatientDataContent(
          traumaDataProvider: traumaProvider,
          customSize: customSize,
          isCreating: isCreating,
          isCreatingPatientData: isCreatingPatientData,
          freeSize: freeSize,
        ),
        const SizedBox(height: 10),
        HealthcareRecordContent(
          noDataWidget: noDataWidget,
          customSize: customSize,
          isCreating: isCreating,
          freeSize: freeSize,
        ),
        const SizedBox(height: 10),
        InjuryRecordContent(
          noDataWidget: noDataWidget,
          customSize: customSize,
          isCreating: isCreating,
          freeSize: freeSize,
        ),
        const SizedBox(height: 10),
        CollisionContent(
          noDataWidget: noDataWidget,
          customSize: customSize,
          isCreating: isCreating,
          freeSize: freeSize,
        ),
        const SizedBox(height: 10),
        DrugAbuseContent(
          noDataWidget: noDataWidget,
          customSize: customSize,
          isCreating: isCreating,
          freeSize: freeSize,
        ),
        const SizedBox(height: 10),
        VitalSignGcsQualifierContent(
          noDataWidget: noDataWidget,
          customSize: customSize,
          isCreating: isCreating,
          freeSize: freeSize,
        ),
        const SizedBox(height: 10),
        HospitalizationVariableContent(
          noDataWidget: noDataWidget,
          customSize: customSize,
          isCreating: isCreating,
          freeSize: freeSize,
        ),
        const SizedBox(height: 10),
        HospitalizationComplicationContent(
          noDataWidget: noDataWidget,
          isCreating: isCreating,
          freeSize: freeSize,
          customSize: customSize,
        ),
        const SizedBox(height: 10),
        TraumaRegisterIcd10Content(
          noDataWidget: noDataWidget,
          customSize: customSize,
          isCreating: isCreating,
          freeSize: freeSize,
        ),
        const SizedBox(height: 10),
        IntensiveCareUnitContent(
          noDataWidget: noDataWidget,
          customSize: customSize,
          isCreating: isCreating,
          freeSize: freeSize,
        ),
        const SizedBox(height: 10),
        ImagingContent(
          noDataWidget: noDataWidget,
          customSize: customSize,
          isCreating: isCreating,
          freeSize: freeSize,
        ),
        const SizedBox(height: 10),
        ApparentIntentInjuryContent(
          noDataWidget: noDataWidget,
          customSize: customSize,
          isCreating: isCreating,
          freeSize: freeSize,
        ),
        const SizedBox(height: 10),
        BurnInjuryContent(
          noDataWidget: noDataWidget,
          customSize: customSize,
          isCreating: isCreating,
          freeSize: freeSize,
        ),
        const SizedBox(height: 10),
        FirearmInjuryContent(
          noDataWidget: noDataWidget,
          customSize: customSize,
          isCreating: isCreating,
          freeSize: freeSize,
        ),
        const SizedBox(height: 10),
        PenetratingInjuryContent(
          noDataWidget: noDataWidget,
          customSize: customSize,
          isCreating: isCreating,
          freeSize: freeSize,
        ),
        const SizedBox(height: 10),
        PoisoningInjuryContent(
          noDataWidget: noDataWidget,
          customSize: customSize,
          isCreating: isCreating,
          freeSize: freeSize,
        ),
        const SizedBox(height: 10),
        ViolenceInjuryContent(
          noDataWidget: noDataWidget,
          customSize: customSize,
          isCreating: isCreating,
          freeSize: freeSize,
        ),
        const SizedBox(height: 10),
        DeviceContent(
          noDataWidget: noDataWidget,
          customSize: customSize,
          isCreating: isCreating,
          freeSize: freeSize,
        ),
        const SizedBox(height: 10),
        LaboratoryContent(
          noDataWidget: noDataWidget,
          customSize: customSize,
          isCreating: isCreating,
          freeSize: freeSize,
        ),
        const SizedBox(height: 10),
        PhysicalExamBodyPartInjuryContent(
          noDataWidget: noDataWidget,
          isCreating: isCreating,
          freeSize: freeSize,
          customSize: customSize,
        ),
        const SizedBox(height: 10),
        ProcedureContent(
          noDataWidget: noDataWidget,
          customSize: customSize,
          isCreating: isCreating,
          freeSize: freeSize,
        ),
        const SizedBox(height: 10),
        PrehospitalProcedureContent(
          noDataWidget: noDataWidget,
          customSize: customSize,
          isCreating: isCreating,
          freeSize: freeSize,
        ),
        const SizedBox(height: 10),
        TransportationModeContent(
          noDataWidget: noDataWidget,
          customSize: customSize,
          isCreating: isCreating,
          freeSize: freeSize,
        ),
        const SizedBox(height: 10),
        VitalSignContent(
          noDataWidget: noDataWidget,
          customSize: customSize,
          isCreating: isCreating,
          freeSize: freeSize,
        ),
      ],
    );
  }
}
