import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/patient_data.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class PatientDataContent extends StatelessWidget {
  const PatientDataContent({
    super.key,
    required this.customSize,
    required this.traumaDataProvider,
    required this.allowEditFields,
    required this.isCreatingPatientData,
    required this.freeSize,
  });

  final CustomSize customSize;
  final TraumaDataProvider traumaDataProvider;
  final bool allowEditFields;
  final bool isCreatingPatientData;
  final bool freeSize;

  @override
  Widget build(BuildContext context) {
    return ExpandableTitleWidget(
      title: "Datos generales",
      index: 0,
      expandedWidget: CustomContainer(
        children: patientDataContent(
          customSize: customSize,
          patientData: traumaDataProvider.patientData!,
          allowEditFields: allowEditFields,
          isCreatingPatientData: isCreatingPatientData,
          traumaDataProvider: traumaDataProvider,
          freeSize: freeSize,
        ),
      ),
    );
  }

  List<Widget> patientDataContent({
    required PatientData patientData,
    required CustomSize customSize,
    required bool allowEditFields,
    required bool isCreatingPatientData,
    required TraumaDataProvider traumaDataProvider,
    required bool freeSize,
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
          // onChanged: (String? value) {
          //   traumaDataProvider.updatePatientData(patientData.copyWith(
          //     traumaRegisterRecordId: value!.isEmpty ? null : int.parse(value),
          //   ));
          // },
        ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Dirección línea 1",
        hintText: "No registra",
        text: patientData.direccionLinea1 ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        // onChanged: (String? value) {
        //   traumaDataProvider.updatePatientData(patientData.copyWith(
        //     direccionLinea1: value!.isEmpty ? null : value,
        //   ));
        // },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Dirección línea 2",
        hintText: "No registra",
        text: patientData.direccionLinea2 ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        // onChanged: (String? value) {
        //   traumaDataProvider.updatePatientData(patientData.copyWith(
        //     direccionLinea2:
        //         value, //! Review later
        //   ));
        // },
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
}
