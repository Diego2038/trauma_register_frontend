import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/enums/input_type.dart';
import 'package:trauma_register_frontend/core/helpers/transform_data.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/patient_data.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class PatientDataContent extends StatefulWidget {
  const PatientDataContent({
    super.key,
    required this.customSize,
    required this.traumaDataProvider,
    required this.isCreating,
    required this.isCreatingPatientData,
    required this.freeSize,
  });

  final CustomSize customSize;
  final TraumaDataProvider traumaDataProvider;
  final bool isCreating;
  final bool isCreatingPatientData;
  final bool freeSize;

  @override
  State<PatientDataContent> createState() => _PatientDataContentState();
}

class _PatientDataContentState extends State<PatientDataContent> {
  late TextEditingController _traumaRegisterRecordIdController;
  late TextEditingController _direccionLinea1Controller;
  late TextEditingController _direccionLinea2Controller;
  late TextEditingController _ciudadController;
  late TextEditingController _cantonMunicipioController;
  late TextEditingController _provinciaEstadoController;
  late TextEditingController _codigoPostalController;
  late TextEditingController _paisController;
  late TextEditingController _edadController;
  late TextEditingController _unidadDeEdadController;
  late TextEditingController _generoController;
  late TextEditingController _fechaDeNacimientoController;
  late TextEditingController _ocupacionController;
  late TextEditingController _estadoCivilController;
  late TextEditingController _nacionalidadController;
  late TextEditingController _grupoEtnicoController;
  late TextEditingController _otroGrupoEtnicoController;
  late TextEditingController _numDocDeIdentificacionController;

  @override
  void initState() {
    //! It's probably TextEditingControllers won't be used
    super.initState();
    final PatientData? patientData = widget.traumaDataProvider.patientData;
    if (patientData == null) return;
    _traumaRegisterRecordIdController = TextEditingController(
        text: patientData.traumaRegisterRecordId?.toString());
    _direccionLinea1Controller =
        TextEditingController(text: patientData.direccionLinea1);
    _direccionLinea2Controller =
        TextEditingController(text: patientData.direccionLinea2);
    _ciudadController = TextEditingController(text: patientData.ciudad);
    _cantonMunicipioController =
        TextEditingController(text: patientData.cantonMunicipio);
    _provinciaEstadoController =
        TextEditingController(text: patientData.provinciaEstado);
    _codigoPostalController =
        TextEditingController(text: patientData.codigoPostal);
    _paisController = TextEditingController(text: patientData.pais);
    _edadController = TextEditingController(text: patientData.edad?.toString());
    _unidadDeEdadController =
        TextEditingController(text: patientData.unidadDeEdad);
    _generoController = TextEditingController(text: patientData.genero);
    _fechaDeNacimientoController = TextEditingController(
        text: patientData.fechaDeNacimiento == null
            ? null
            : DateFormat('dd/MM/yyyy').format(patientData.fechaDeNacimiento!));
    _ocupacionController = TextEditingController(text: patientData.ocupacion);
    _estadoCivilController =
        TextEditingController(text: patientData.estadoCivil);
    _nacionalidadController =
        TextEditingController(text: patientData.nacionalidad);
    _grupoEtnicoController =
        TextEditingController(text: patientData.grupoEtnico);
    _otroGrupoEtnicoController =
        TextEditingController(text: patientData.otroGrupoEtnico);
    _numDocDeIdentificacionController =
        TextEditingController(text: patientData.numDocDeIdentificacion);
  }

  @override
  void dispose() {
    _traumaRegisterRecordIdController.dispose();
    _direccionLinea1Controller.dispose();
    _direccionLinea2Controller.dispose();
    _ciudadController.dispose();
    _cantonMunicipioController.dispose();
    _provinciaEstadoController.dispose();
    _codigoPostalController.dispose();
    _paisController.dispose();
    _edadController.dispose();
    _unidadDeEdadController.dispose();
    _generoController.dispose();
    _fechaDeNacimientoController.dispose();
    _ocupacionController.dispose();
    _estadoCivilController.dispose();
    _nacionalidadController.dispose();
    _grupoEtnicoController.dispose();
    _otroGrupoEtnicoController.dispose();
    _numDocDeIdentificacionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableTitleWidget(
      title: "Datos generales",
      index: 0,
      expandedWidget: CustomContainer(
        children: patientDataContent(
          customSize: widget.customSize,
          patientData: widget.traumaDataProvider.patientData!,
          isCreating: widget.isCreating,
          isCreatingPatientData: widget.isCreatingPatientData,
          traumaDataProvider: widget.traumaDataProvider,
          freeSize: widget.freeSize,
        ),
      ),
    );
  }

  List<Widget> patientDataContent({
    required PatientData patientData,
    required CustomSize customSize,
    required bool isCreating,
    required bool isCreatingPatientData,
    required TraumaDataProvider traumaDataProvider,
    required bool freeSize,
  }) {
    return [
      if (isCreatingPatientData)
        CustomInputWithLabel(
          size: customSize,
          readOnly: !isCreating,
          title: "ID registro de trauma",
          hintText: "No registra",
          controller: _traumaRegisterRecordIdController,
          lines: 2,
          width: freeSize ? null : 220,
          inputType: InputType.integer,
          onChanged: (String? value) {
            print("value: $value");
            final patientData = _getCurrentPatientData(context);
            traumaDataProvider.updatePatientData(
              patientData.copyWith(traumaRegisterRecordId: TransformData.getTransformedValue<int>(value)),
              true,
            );
          },
        ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Dirección línea 1",
        hintText: "No registra",
        controller: _direccionLinea1Controller,
        lines: 2,
        width: freeSize ? null : 220,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            direccionLinea1: TransformData.getTransformedValue<String>(value),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Dirección línea 2",
        hintText: "No registra",
        controller: _direccionLinea2Controller,
        lines: 2,
        width: freeSize ? null : 220,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            direccionLinea2: TransformData.getTransformedValue<String>(value),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Ciudad",
        hintText: "No registra",
        controller: _ciudadController,
        lines: 2,
        width: freeSize ? null : 220,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            ciudad: TransformData.getTransformedValue<String>(value),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Cantón / municipio",
        hintText: "No registra",
        controller: _cantonMunicipioController,
        lines: 2,
        width: freeSize ? null : 220,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            cantonMunicipio: TransformData.getTransformedValue<String>(value),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Provincia / estado",
        hintText: "No registra",
        controller: _provinciaEstadoController,
        lines: 2,
        width: freeSize ? null : 220,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            provinciaEstado: TransformData.getTransformedValue<String>(value),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Código postal",
        hintText: "No registra",
        controller: _codigoPostalController,
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            codigoPostal: TransformData.getTransformedValue<String>(value),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "País",
        hintText: "No registra",
        controller: _paisController,
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            pais: TransformData.getTransformedValue<String>(value),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Edad",
        hintText: "No registra",
        controller: _edadController,
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider
              .updatePatientData(patientData.copyWith(edad: TransformData.getTransformedValue<int>(value)));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Unidad de edad",
        hintText: "No registra",
        controller: _unidadDeEdadController,
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            unidadDeEdad: TransformData.getTransformedValue<String>(value)
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Género",
        hintText: "No registra",
        controller: _generoController,
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            genero: TransformData.getTransformedValue<String>(value),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Fecha de nacimiento",
        hintText: "No registra",
        controller: _fechaDeNacimientoController,
        rightIcon: Icons.calendar_month_outlined,
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            fechaDeNacimiento: TransformData.getTransformedValue<DateTime>(value),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Ocupación",
        hintText: "No registra",
        controller: _ocupacionController,
        lines: 2,
        width: freeSize ? null : 460,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            ocupacion: TransformData.getTransformedValue<String>(value),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Estado civil",
        hintText: "No registra",
        controller: _estadoCivilController,
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            estadoCivil: TransformData.getTransformedValue<String>(value),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Nacionalidad",
        hintText: "No registra",
        controller: _nacionalidadController,
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            nacionalidad: TransformData.getTransformedValue<String>(value),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Grupo étnico",
        hintText: "No registra",
        controller: _grupoEtnicoController,
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            grupoEtnico: TransformData.getTransformedValue<String>(value),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Otro grupo étnico",
        hintText: "No registra",
        controller: _otroGrupoEtnicoController,
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            otroGrupoEtnico: TransformData.getTransformedValue<String>(value),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Núm. de identificación",
        hintText: "No registra",
        controller: _numDocDeIdentificacionController,
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            numDocDeIdentificacion: TransformData.getTransformedValue<String>(value),
          ));
        },
      ),
    ];
  }

  PatientData _getCurrentPatientData(BuildContext context) {
    return Provider.of<TraumaDataProvider>(context, listen: false).patientData!;
  }
  
}
