import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/action_type.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/enums/input_type.dart';
import 'package:trauma_register_frontend/core/helpers/content_options.dart';
import 'package:trauma_register_frontend/core/helpers/transform_data.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/shared/optional.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/patient_data.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/physical_exam_body_part_injury.dart';
import 'package:trauma_register_frontend/data/services/navigation_service.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_icon_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_modal.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class PhysicalExamBodyPartInjuryContent extends StatelessWidget {
  const PhysicalExamBodyPartInjuryContent({
    super.key,
    required this.noDataWidget,
    required this.action,
    required this.freeSize,
    required this.customSize,
  });

  final NormalText noDataWidget;
  final ActionType action;
  final bool freeSize;
  final CustomSize customSize;

  @override
  Widget build(BuildContext context) {
    final bool allowChanges =
        action == ActionType.crear || action == ActionType.actualizar;
    return ExpandableTitleWidget(
      title: "Exámenes físicos producto por lesión de partes del cuerpo",
      index: 19,
      expandedWidget:
          _getCurrentPatientData(context).physicalExamBodyPartInjury == null ||
                  _getCurrentPatientData(context)
                      .physicalExamBodyPartInjury!
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
                          .physicalExamBodyPartInjury!
                          .asMap()
                          .entries
                          .map(
                            (entry) => _Content(
                              keyy: entry.key,
                              value: entry.value,
                              action: action,
                              freeSize: freeSize,
                              customSize: customSize,
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
        final currentElements = currentPatientData.physicalExamBodyPartInjury;
        final traumaDataProvider = _getCurrentProvider(context);
        traumaDataProvider.updatePatientData(
            currentPatientData.copyWith(
              physicalExamBodyPartInjury: [
                if (currentElements != null) ...currentElements,
                PhysicalExamBodyPartInjury(),
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
  final PhysicalExamBodyPartInjury value;
  final ActionType action;
  final bool freeSize;
  final CustomSize customSize;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  @override
  Widget build(BuildContext context) {
    final bool allowChanges = widget.action == ActionType.crear ||
        widget.action == ActionType.actualizar;
    return CustomContainer(
      maxWidth: 600,
      showUpdateButton: widget.action == ActionType.actualizar,
      onUpdate: () async {
        final bool isANewElement = _getCurrentPatientData(context)
                .physicalExamBodyPartInjury![widget.keyy]
                .id ==
            null;
        final bool confirmFlow = await CustomModal.showModal(
          context: context,
          title: null,
          text: isANewElement
              ? "¿Desea crear el nuevo elemento?"
              : "¿Desea confirmar la actualización?",
        );
        if (!confirmFlow) return;
        CustomModal.loadModal(context: context);
        final element = _getCurrentPatientData(context)
            .physicalExamBodyPartInjury![widget.keyy];
        final id = _getCurrentPatientData(context).traumaRegisterRecordId!;
        final result = await (isANewElement
            ? _getCurrentProvider(context)
                .createPhysicalExamBodyPartInjury(element, id)
            : _getCurrentProvider(context)
                .updatePhysicalExamBodyPartInjury(element));
        if (isANewElement) {
          _updateElements(
            context: context,
            id: result.idElement,
            index: widget.keyy,
          );
        }
        NavigationService.pop();
        CustomModal.showModal(
          context: context,
          title: null,
          text: result.message!,
          showCancelButton: false,
        );
      },
      showDeleteButton: allowChanges,
      onDelete: () async {
        final bool isANewElement = _getCurrentPatientData(context)
                .physicalExamBodyPartInjury![widget.keyy]
                .id ==
            null;
        if (widget.action == ActionType.actualizar && !isANewElement) {
          final deleteElement = await CustomModal.showModal(
            context: context,
            title: null,
            text: "¿Está seguro que desea eliminar el elemento?",
          );
          if (!deleteElement) return;
          CustomModal.loadModal(context: context);
          final result = await _getCurrentProvider(context)
              .deletePhysicalExamBodyPartInjuryById(
                  _getCurrentPatientData(context)
                      .physicalExamBodyPartInjury![widget.keyy]
                      .id
                      .toString());
          NavigationService.pop();
          CustomModal.showModal(
            context: context,
            title: null,
            text: result.message!,
            showCancelButton: false,
          );
        }
        _getCurrentProvider(context).updatePatientData(
          _getCurrentPatientData(context).copyWith(
            physicalExamBodyPartInjury: _getCurrentPatientData(context)
                .physicalExamBodyPartInjury
                ?.asMap()
                .entries
                .where((e) => e.key != widget.keyy)
                .map((e) => e.value)
                .toList(),
          ),
          true,
        );
      },
      children: physicalExamBodyPartInjuryContent(
        context: context,
        index: widget.keyy,
        physicalExamBodyPartInjury: widget.value,
        isCreating: allowChanges,
        freeSize: widget.freeSize,
        customSize: widget.customSize,
      ),
    );
  }

  List<Widget> physicalExamBodyPartInjuryContent({
    required BuildContext context,
    required int index,
    required PhysicalExamBodyPartInjury physicalExamBodyPartInjury,
    required CustomSize customSize,
    required bool isCreating,
    required bool freeSize,
  }) {
    final traumaDataProvider = _getCurrentProvider(context);
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Parte del cuerpo",
        hintText: "No registra",
        text: physicalExamBodyPartInjury.parteDelCuerpo ?? "",
        lines: 1,
        width: freeSize ? null : 460,
        suggestions: ContentOptions.physicalExamBodyPartInjury.parteDelCuerpo,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            physicalExamBodyPartInjury: patientData.physicalExamBodyPartInjury
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        parteDelCuerpo: Optional<String?>.of(
                            TransformData.getTransformedValue<String>(value)))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Tipo de lesión",
        hintText: "No registra",
        text: physicalExamBodyPartInjury.tipoDeLesion ?? "",
        lines: 1,
        width: freeSize ? null : 460,
        suggestions: ContentOptions.physicalExamBodyPartInjury.tipoDeLesion,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            physicalExamBodyPartInjury: patientData.physicalExamBodyPartInjury
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        tipoDeLesion: Optional<String?>.of(
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

  void _updateElements({
    required BuildContext context,
    required int? id,
    required int index,
  }) {
    final traumaDataProvider = _getCurrentProvider(context);
    final patientData = _getCurrentPatientData(context);
    final elements = patientData.physicalExamBodyPartInjury;
    if (elements == null) return;
    elements[index] = elements[index].copyWith(id: id);
    traumaDataProvider.updatePatientData(patientData.copyWith(
      physicalExamBodyPartInjury: elements,
    ));
  }
}
