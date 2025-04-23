import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/patient_data.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/trauma_data.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_checkbox.dart';
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
                      print("Valor del value: $value");
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

  const _ContentDataPatient({
    required this.patientData,
  });

  @override
  Widget build(BuildContext context) {
    const noDataWidget = NormalText(text: "No hay datos en esta categoría");
    return Column(
      children: [
        ExpandableTitleWidget(
          title: "Datos generales",
          index: 0,
          expandedWidget: Text("Datos generales como ${patientData.ciudad}"),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Registro de atención médica",
          index: 1,
          expandedWidget: patientData.healthcareRecord == null
              ? noDataWidget
              : const Text("DATOOOOs"),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Registro de lesión",
          index: 2,
          expandedWidget: patientData.healthcareRecord == null
              ? noDataWidget
              : const Text("DATOOOOs"),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Colisiones",
          index: 3,
          expandedWidget: patientData.healthcareRecord == null
              ? noDataWidget
              : const Text("DATOOOOs"),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Abusos de drogas",
          index: 4,
          expandedWidget: patientData.healthcareRecord == null
              ? noDataWidget
              : const Text("DATOOOOs"),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Calificaciones de signos vitales GCS",
          index: 5,
          expandedWidget: patientData.healthcareRecord == null
              ? noDataWidget
              : const Text("DATOOOOs"),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Variables de hospitalización",
          index: 6,
          expandedWidget: patientData.healthcareRecord == null
              ? noDataWidget
              : const Text("DATOOOOs"),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Complicaciones de hospitalización",
          index: 7,
          expandedWidget: patientData.healthcareRecord == null
              ? noDataWidget
              : const Text("DATOOOOs"),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Registros de trauma ICD10",
          index: 8,
          expandedWidget: patientData.healthcareRecord == null
              ? noDataWidget
              : const Text("DATOOOOs"),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Unidades de cuidados intensivos",
          index: 9,
          expandedWidget: patientData.healthcareRecord == null
              ? noDataWidget
              : const Text("DATOOOOs"),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Imágenes",
          index: 10,
          expandedWidget: patientData.healthcareRecord == null
              ? noDataWidget
              : const Text("DATOOOOs"),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Lesiones intencionales aparentes",
          index: 11,
          expandedWidget: patientData.healthcareRecord == null
              ? noDataWidget
              : const Text("DATOOOOs"),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Lesiones por quemadura",
          index: 12,
          expandedWidget: patientData.healthcareRecord == null
              ? noDataWidget
              : const Text("DATOOOOs"),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Lesiones por armas de fuego",
          index: 1,
          expandedWidget: patientData.healthcareRecord == null
              ? noDataWidget
              : const Text("DATOOOOs"),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Lesiones penetrantes",
          index: 13,
          expandedWidget: patientData.healthcareRecord == null
              ? noDataWidget
              : const Text("DATOOOOs"),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Lesiones por envenenamiento",
          index: 14,
          expandedWidget: patientData.healthcareRecord == null
              ? noDataWidget
              : const Text("DATOOOOs"),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Lesiones violentas",
          index: 15,
          expandedWidget: patientData.healthcareRecord == null
              ? noDataWidget
              : const Text("DATOOOOs"),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Dispositivos utilizados en accidente de tránsito",
          index: 16,
          expandedWidget: patientData.healthcareRecord == null
              ? noDataWidget
              : const Text("DATOOOOs"),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Exámenes de laboratorio",
          index: 17,
          expandedWidget: patientData.healthcareRecord == null
              ? noDataWidget
              : const Text("DATOOOOs"),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Exámenes físicos producto por lesión de partes del cuerpo",
          index: 18,
          expandedWidget: patientData.healthcareRecord == null
              ? noDataWidget
              : const Text("DATOOOOs"),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Procedimientos realizados",
          index: 19,
          expandedWidget: patientData.healthcareRecord == null
              ? noDataWidget
              : const Text("DATOOOOs"),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Procedimientos prehospitalarios realizados",
          index: 20,
          expandedWidget: patientData.healthcareRecord == null
              ? noDataWidget
              : const Text("DATOOOOs"),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Modo de transporte",
          index: 21,
          expandedWidget: patientData.healthcareRecord == null
              ? noDataWidget
              : const Text("DATOOOOs"),
        ),
        const SizedBox(height: 10),
        ExpandableTitleWidget(
          title: "Signos vitales",
          index: 22,
          expandedWidget: patientData.healthcareRecord == null
              ? noDataWidget
              : const Text("DATOOOOs"),
        ),
      ],
    );
  }
}
