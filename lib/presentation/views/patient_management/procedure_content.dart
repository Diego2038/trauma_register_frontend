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
import 'package:trauma_register_frontend/data/models/trauma_data/patient_data.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/procedure.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_icon_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_modal.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class ProcedureContent extends StatelessWidget {
  const ProcedureContent({
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
      title: "Procedimientos realizados",
      index: 20,
      expandedWidget: _getCurrentPatientData(context).procedure == null ||
              _getCurrentPatientData(context).procedure!.isEmpty
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
                      .procedure!
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
        final currentElements = currentPatientData.procedure;
        final traumaDataProvider = _getCurrentProvider(context);
        traumaDataProvider.updatePatientData(
            currentPatientData.copyWith(
              procedure: [
                if (currentElements != null) ...currentElements,
                Procedure(),
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
    required this.customSize,
    required this.action,
    required this.freeSize,
  });

  final int keyy;
  final Procedure value;
  final CustomSize customSize;
  final ActionType action;
  final bool freeSize;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  late TextEditingController _fechaYHoraDeInicioController;
  late TextEditingController _fechaYHoraDeTerminoController;

  @override
  void initState() {
    super.initState();
    _fechaYHoraDeInicioController = TextEditingController(
        text: widget.value.fechaYHoraDeInicio != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(widget.value.fechaYHoraDeInicio!)
            : "");
    _fechaYHoraDeTerminoController = TextEditingController(
        text: widget.value.fechaYHoraDeTermino != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(widget.value.fechaYHoraDeTermino!)
            : "");
  }

  @override
  void dispose() {
    _fechaYHoraDeInicioController.dispose();
    _fechaYHoraDeTerminoController.dispose();
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
        final bool isANewElement =
            _getCurrentPatientData(context).procedure![widget.keyy].id == null;
        final bool confirmFlow = await CustomModal.showModal(
          context: context,
          title: null,
          text: isANewElement
              ? "¿Desea crear el nuevo elemento?"
              : "¿Desea confirmar la actualización?",
        );
        if (!confirmFlow) return;
        final element = _getCurrentPatientData(context).procedure![widget.keyy];
        final id = _getCurrentPatientData(context).traumaRegisterRecordId!;
        final result = await (isANewElement
            ? _getCurrentProvider(context).createProcedure(element, id)
            : _getCurrentProvider(context).updateProcedure(element));
        if (isANewElement) {
          _updateElements(
            context: context,
            id: result.idElement,
            index: widget.keyy,
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
            _getCurrentPatientData(context).procedure![widget.keyy].id == null;
        if (widget.action == ActionType.actualizar && !isANewElement) {
          final deleteElement = await CustomModal.showModal(
            context: context,
            title: null,
            text: "¿Está seguro que desea eliminar el elemento?",
          );
          if (!deleteElement) return;
          final result = await _getCurrentProvider(context).deleteProcedureById(
              _getCurrentPatientData(context)
                  .procedure![widget.keyy]
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
            procedure: _getCurrentPatientData(context)
                .procedure
                ?.asMap()
                .entries
                .where((e) => e.key != widget.keyy)
                .map((e) => e.value)
                .toList(),
          ),
          true,
        );
      },
      children: procedureContent(
        context: context,
        index: widget.keyy,
        procedure: widget.value,
        customSize: widget.customSize,
        isCreating: allowChanges,
        freeSize: widget.freeSize,
      ),
    );
  }

  List<Widget> procedureContent({
    required BuildContext context,
    required int index,
    required Procedure procedure,
    required CustomSize customSize,
    required bool isCreating,
    required bool freeSize,
  }) {
    final traumaDataProvider = _getCurrentProvider(context);
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Procedimiento realizado",
        hintText: "No registra",
        text: procedure.procedimientoRealizado ?? "",
        lines: 4,
        width: freeSize ? null : 220,
        height: freeSize ? null : 184,
        suggestions: ContentOptions.procedure.procedimientoRealizado,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            procedure: patientData.procedure
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        procedimientoRealizado: Optional<String?>.of(
                            TransformData.getTransformedValue<String>(value)))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Lugar",
        hintText: "No registra",
        text: procedure.lugar ?? "",
        lines: 4,
        width: freeSize ? null : 220,
        height: freeSize ? null : 184,
        suggestions: ContentOptions.procedure.lugar,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            procedure: patientData.procedure
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        lugar: Optional<String?>.of(
                            TransformData.getTransformedValue<String>(value)))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Fecha y hora de inicio",
        hintText: "No registra",
        text: procedure.fechaYHoraDeInicio != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(procedure.fechaYHoraDeInicio!)
            : "",
        lines: 1,
        rightIcon: Icons.calendar_month_outlined,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
        inputType: InputType.datetime,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            procedure: patientData.procedure
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        fechaYHoraDeInicio: Optional<DateTime?>.of(
                            TransformData.getTransformedValue<DateTime>(value)))
                    : e.value)
                .toList(),
          ));
        },
        controller: _fechaYHoraDeInicioController,
        onTap: () async {
          final DateTime? resultDate = await CustomModal.determineDate(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
            includeTime: true,
          );
          _fechaYHoraDeInicioController.text = resultDate != null
              ? DateFormat('dd/MM/yyyy HH:mm:ss').format(resultDate)
              : "";
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            procedure: patientData.procedure
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        fechaYHoraDeInicio: Optional<DateTime?>.of(
                            TransformData.getTransformedValue<DateTime>(
                                _fechaYHoraDeInicioController.text)))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Fecha y hora de terminación",
        hintText: "No registra",
        text: procedure.fechaYHoraDeTermino != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(procedure.fechaYHoraDeTermino!)
            : "",
        lines: 1,
        rightIcon: Icons.calendar_month_outlined,
        width: freeSize ? null : 220,
        height: freeSize ? null : 108,
        inputType: InputType.datetime,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            procedure: patientData.procedure
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        fechaYHoraDeTermino: Optional<DateTime?>.of(
                            TransformData.getTransformedValue<DateTime>(value)))
                    : e.value)
                .toList(),
          ));
        },
        controller: _fechaYHoraDeTerminoController,
        onTap: () async {
          final DateTime? resultDate = await CustomModal.determineDate(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
            includeTime: true,
          );
          _fechaYHoraDeTerminoController.text = resultDate != null
              ? DateFormat('dd/MM/yyyy HH:mm:ss').format(resultDate)
              : "";
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            procedure: patientData.procedure
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        fechaYHoraDeTermino: Optional<DateTime?>.of(
                            TransformData.getTransformedValue<DateTime>(
                                _fechaYHoraDeTerminoController.text)))
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

  void _updateElements({
    required BuildContext context,
    required int? id,
    required int index,
  }) {
    final traumaDataProvider = _getCurrentProvider(context);
    final patientData = _getCurrentPatientData(context);
    final elements = patientData.procedure;
    if (elements == null) return;
    elements[index] = elements[index].copyWith(id: id);
    traumaDataProvider.updatePatientData(patientData.copyWith(
      procedure: elements,
    ));
  }
}
