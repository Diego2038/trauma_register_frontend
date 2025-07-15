import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/action_type.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/enums/input_type.dart';
import 'package:trauma_register_frontend/core/helpers/content_options.dart';
import 'package:trauma_register_frontend/core/helpers/transform_data.dart';
import 'package:trauma_register_frontend/data/models/shared/optional.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/patient_data.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_modal.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class PatientDataContent extends StatelessWidget {
  const PatientDataContent({
    super.key,
    required this.customSize,
    required this.traumaDataProvider,
    required this.action,
    required this.isCreatingPatientData,
    required this.freeSize,
  });

  final CustomSize customSize;
  final TraumaDataProvider traumaDataProvider;
  final ActionType action;
  final bool isCreatingPatientData;
  final bool freeSize;

  @override
  Widget build(BuildContext context) {
    return ExpandableTitleWidget(
      title: "Datos generales",
      index: 0,
      expandedWidget: _Content(
        customSize: customSize,
        traumaDataProvider: traumaDataProvider,
        action: action,
        isCreatingPatientData: isCreatingPatientData,
        freeSize: freeSize,
      ),
    );
  }
}

class _Content extends StatefulWidget {
  const _Content({
    required this.customSize,
    required this.traumaDataProvider,
    required this.action,
    required this.isCreatingPatientData,
    required this.freeSize,
  });

  final CustomSize customSize;
  final TraumaDataProvider traumaDataProvider;
  final ActionType action;
  final bool isCreatingPatientData;
  final bool freeSize;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  late TextEditingController _traumaRegisterRecordIdController;
  late TextEditingController _fechaDeNacimientoController;

  @override
  void initState() {
    //! It's probably TextEditingControllers won't be used
    super.initState();
    final PatientData? patientData = widget.traumaDataProvider.patientData;
    if (patientData == null) return;
    _traumaRegisterRecordIdController = TextEditingController(
        text: patientData.traumaRegisterRecordId?.toString());
    _fechaDeNacimientoController = TextEditingController(
        text: patientData.fechaDeNacimiento == null
            ? null
            : DateFormat('dd/MM/yyyy').format(patientData.fechaDeNacimiento!));
  }

  @override
  void dispose() {
    _traumaRegisterRecordIdController.dispose();
    _fechaDeNacimientoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool allowChanges = widget.action == ActionType.crear ||
        widget.action == ActionType.actualizar;
    return CustomContainer(
      showUpdateButton: widget.action == ActionType.actualizar,
      onUpdate: () async {
        final element = _getCurrentPatientData(context);
        final bool confirmFlow = await CustomModal.showModal(
          context: context,
          title: null,
          text: "¿Desea confirmar la actualización?",
        );
        if (!confirmFlow) return;
        final result = await _getCurrentProvider(context).updatePatientDataElement(element);
        CustomModal.showModal(
          context: context,
          title: null,
          text: result.message!,
          showCancelButton: false,
        );
      },
      children: patientDataContent(
        customSize: widget.customSize,
        patientData: widget.traumaDataProvider.patientData!,
        isCreating: allowChanges,
        isCreatingPatientData: widget.isCreatingPatientData,
        traumaDataProvider: widget.traumaDataProvider,
        freeSize: widget.freeSize,
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
              patientData.copyWith(
                  traumaRegisterRecordId:
                      TransformData.getTransformedValue<int>(value)),
              true,
            );
          },
        ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Dirección línea 1",
        hintText: "No registra",
        text: patientData.direccionLinea1,
        lines: 2,
        width: freeSize ? null : 220,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            direccionLinea1: Optional<String?>.of(
                TransformData.getTransformedValue<String>(value)),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Dirección línea 2",
        hintText: "No registra",
        text: patientData.direccionLinea2,
        lines: 2,
        width: freeSize ? null : 220,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            direccionLinea2: Optional<String?>.of(
                TransformData.getTransformedValue<String>(value)),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Ciudad",
        hintText: "No registra",
        text: patientData.ciudad,
        lines: 2,
        width: freeSize ? null : 220,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            ciudad: Optional<String?>.of(
                TransformData.getTransformedValue<String>(value)),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Cantón / municipio",
        hintText: "No registra",
        text: patientData.cantonMunicipio,
        lines: 2,
        width: freeSize ? null : 220,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            cantonMunicipio: Optional<String?>.of(
                TransformData.getTransformedValue<String>(value)),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Provincia / estado",
        hintText: "No registra",
        text: patientData.provinciaEstado,
        lines: 2,
        width: freeSize ? null : 220,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            provinciaEstado: Optional<String?>.of(
                TransformData.getTransformedValue<String>(value)),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Código postal",
        hintText: "No registra",
        text: patientData.codigoPostal,
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            codigoPostal: Optional<String?>.of(
                TransformData.getTransformedValue<String>(value)),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "País",
        hintText: "No registra",
        text: patientData.pais,
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
        suggestions: ContentOptions.patientData.pais,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            pais: Optional<String?>.of(
                TransformData.getTransformedValue<String>(value)),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Edad",
        hintText: "No registra",
        text: (patientData.edad ?? '').toString(),
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
        inputType: InputType.integer,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
              edad: Optional<int?>.of(
                  TransformData.getTransformedValue<int>(value))));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Unidad de edad",
        hintText: "No registra",
        text: patientData.unidadDeEdad,
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
        suggestions: ContentOptions.patientData.unidadEdad,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
              unidadDeEdad: Optional<String?>.of(
                  TransformData.getTransformedValue<String>(value))));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Género",
        hintText: "No registra",
        text: patientData.genero,
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
        suggestions: ContentOptions.patientData.genero,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            genero: Optional<String?>.of(
                TransformData.getTransformedValue<String>(value)),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Fecha de nacimiento",
        hintText: "No registra",
        text: patientData.fechaDeNacimiento != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(patientData.fechaDeNacimiento!)
            : "",
        rightIcon: Icons.calendar_month_outlined,
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
        inputType: InputType.date,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            fechaDeNacimiento: Optional<DateTime?>.of(
                TransformData.getTransformedValue<DateTime>(value)),
          ));
        },
        controller: _fechaDeNacimientoController,
        onTap: () async {
          final DateTime? resultDate = await CustomModal.determineDate(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
          );
          _fechaDeNacimientoController.text = resultDate != null
              ? DateFormat('dd/MM/yyyy').format(resultDate)
              : "";
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            fechaDeNacimiento: Optional<DateTime?>.of(
                TransformData.getTransformedValue<DateTime>(
                    _fechaDeNacimientoController.text)),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Ocupación",
        hintText: "No registra",
        text: patientData.ocupacion,
        lines: 2,
        width: freeSize ? null : 460,
        suggestions: ContentOptions.patientData.ocupacion,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            ocupacion: Optional<String?>.of(
                TransformData.getTransformedValue<String>(value)),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Estado civil",
        hintText: "No registra",
        text: patientData.estadoCivil,
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
        suggestions: ContentOptions.patientData.estadoCivil,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            estadoCivil: Optional<String?>.of(
                TransformData.getTransformedValue<String>(value)),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Nacionalidad",
        hintText: "No registra",
        text: patientData.nacionalidad,
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
        suggestions: ContentOptions.patientData.nacionalidad,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            nacionalidad: Optional<String?>.of(
                TransformData.getTransformedValue<String>(value)),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Grupo étnico",
        hintText: "No registra",
        text: patientData.grupoEtnico,
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
        suggestions: ContentOptions.patientData.grupoEtnico,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            grupoEtnico: Optional<String?>.of(
                TransformData.getTransformedValue<String>(value)),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Otro grupo étnico",
        hintText: "No registra",
        text: patientData.otroGrupoEtnico,
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            otroGrupoEtnico: Optional<String?>.of(
                TransformData.getTransformedValue<String>(value)),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Núm. de identificación",
        hintText: "No registra",
        text: patientData.numDocDeIdentificacion,
        lines: 1,
        width: freeSize ? null : 220,
        height: 94,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            numDocDeIdentificacion: Optional<String?>.of(
                TransformData.getTransformedValue<String>(value)),
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
}
