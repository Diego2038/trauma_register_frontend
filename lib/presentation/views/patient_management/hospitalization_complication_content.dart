import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/action_type.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/enums/input_type.dart';
import 'package:trauma_register_frontend/core/helpers/content_options.dart';
import 'package:trauma_register_frontend/core/helpers/transform_data.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/shared/optional.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/hospitalization_complication.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/patient_data.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_icon_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_modal.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class HospitalizationComplicationContent extends StatelessWidget {
  const HospitalizationComplicationContent({
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
      title: "Complicaciones de hospitalización",
      index: 7,
      expandedWidget:
          _getCurrentPatientData(context).hospitalizationComplication == null ||
                  _getCurrentPatientData(context)
                      .hospitalizationComplication!
                      .isEmpty
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
                          .hospitalizationComplication!
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
        final currentElements = currentPatientData.hospitalizationComplication;
        final traumaDataProvider = _getCurrentProvider(context);
        traumaDataProvider.updatePatientData(
            currentPatientData.copyWith(
              hospitalizationComplication: [
                if (currentElements != null) ...currentElements,
                HospitalizationComplication(),
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
    required this.action,
    required this.freeSize,
    required this.customSize,
  });

  final int keyy;
  final HospitalizationComplication value;
  final ActionType action;
  final bool freeSize;
  final CustomSize customSize;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  late TextEditingController _fechaYHoraDeComplicacionController;

  @override
  void initState() {
    super.initState();
    _fechaYHoraDeComplicacionController = TextEditingController(
        text: widget.value.fechaYHoraDeComplicacion != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(widget.value.fechaYHoraDeComplicacion!)
            : "");
  }

  @override
  void dispose() {
    _fechaYHoraDeComplicacionController.dispose();
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
        final bool isANewElement = widget.value.id == null;
        final bool confirmFlow = await CustomModal.showModal(
          context: context,
          title: null,
          text: isANewElement
              ? "¿Desea crear el nuevo elemento?"
              : "¿Desea confirmar la actualización?",
        );
        if (!confirmFlow) return;
        final element = _getCurrentPatientData(context)
            .hospitalizationComplication![widget.keyy];
        final id = _getCurrentPatientData(context).traumaRegisterRecordId!;
        final result = await (isANewElement
            ? _getCurrentProvider(context)
                .createHospitalizationComplication(element, id)
            : _getCurrentProvider(context)
                .updateHospitalizationComplication(element));
        CustomModal.showModal(
          context: context,
          title: null,
          text: result.message!,
          showCancelButton: false,
        );
      },
      showDeleteButton: allowChanges,
      onDelete: () async {
        if (widget.action == ActionType.actualizar && widget.value.id != null) {
          final deleteElement = await CustomModal.showModal(
            context: context,
            title: null,
            text: "¿Está seguro que desea eliminar el elemento?",
          );
          if (!deleteElement) return;
          final result = await _getCurrentProvider(context)
              .deleteHospitalizationComplicationById(
                  _getCurrentPatientData(context)
                      .hospitalizationComplication![widget.keyy]
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
            hospitalizationComplication: _getCurrentPatientData(context)
                .hospitalizationComplication
                ?.asMap()
                .entries
                .where((e) => e.key != widget.keyy)
                .map((e) => e.value)
                .toList(),
          ),
          true,
        );
      },
      children: hospitalizationComplicationContent(
        context: context,
        index: widget.keyy,
        hospitalizationComplication: widget.value,
        isCreating: allowChanges,
        freeSize: widget.freeSize,
        customSize: widget.customSize,
      ),
    );
  }

  List<Widget> hospitalizationComplicationContent({
    required BuildContext context,
    required int index,
    required HospitalizationComplication hospitalizationComplication,
    required CustomSize customSize,
    required bool isCreating,
    required bool freeSize,
  }) {
    final traumaDataProvider = _getCurrentProvider(context);
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Tipo de complicación",
        hintText: "No registra",
        text: hospitalizationComplication.tipoDeComplicacion ?? "",
        lines: 2,
        width: freeSize ? null : 460,
        suggestions:
            ContentOptions.hospitalizationComplication.tipoDeComplicacion,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            hospitalizationComplication: patientData.hospitalizationComplication
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        tipoDeComplicacion: Optional<String?>.of(
                            TransformData.getTransformedValue<String>(value)))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Fecha y hora de la complicación",
        hintText: "No registra",
        text: hospitalizationComplication.fechaYHoraDeComplicacion != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(hospitalizationComplication.fechaYHoraDeComplicacion!)
            : "",
        lines: 1,
        rightIcon: Icons.calendar_month_outlined,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        inputType: InputType.datetime,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            hospitalizationComplication: patientData.hospitalizationComplication
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        fechaYHoraDeComplicacion: Optional<DateTime?>.of(
                            TransformData.getTransformedValue<DateTime>(value)))
                    : e.value)
                .toList(),
          ));
        },
        controller: _fechaYHoraDeComplicacionController,
        onTap: () async {
          final DateTime? resultDate = await CustomModal.determineDate(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
            includeTime: true,
          );
          _fechaYHoraDeComplicacionController.text = resultDate != null
              ? DateFormat('dd/MM/yyyy HH:mm:ss').format(resultDate)
              : "";
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            hospitalizationComplication: patientData.hospitalizationComplication
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        fechaYHoraDeComplicacion: Optional<DateTime?>.of(
                            TransformData.getTransformedValue<DateTime>(
                                _fechaYHoraDeComplicacionController.text)))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Lugar de la complicación",
        hintText: "No registra",
        text: hospitalizationComplication.lugarDeComplicacion ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        suggestions:
            ContentOptions.hospitalizationComplication.lugarDeComplicacion,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            hospitalizationComplication: patientData.hospitalizationComplication
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        lugarDeComplicacion: Optional<String?>.of(
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
}
