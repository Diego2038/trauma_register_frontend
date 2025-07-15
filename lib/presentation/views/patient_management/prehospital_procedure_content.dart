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
import 'package:trauma_register_frontend/data/models/trauma_data/prehospital_procedure.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_icon_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_modal.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class PrehospitalProcedureContent extends StatelessWidget {
  const PrehospitalProcedureContent({
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
      title: "Procedimientos prehospitalarios realizados",
      index: 21,
      expandedWidget:
          _getCurrentPatientData(context).prehospitalProcedure == null ||
                  _getCurrentPatientData(context).prehospitalProcedure!.isEmpty
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
                          .prehospitalProcedure!
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
        final currentElements = currentPatientData.prehospitalProcedure;
        final traumaDataProvider = _getCurrentProvider(context);
        traumaDataProvider.updatePatientData(
            currentPatientData.copyWith(
              prehospitalProcedure: [
                if (currentElements != null) ...currentElements,
                PrehospitalProcedure(),
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
  final PrehospitalProcedure value;
  final CustomSize customSize;
  final ActionType action;
  final bool freeSize;

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
        final bool isANewElement = widget.value.id == null;
        final bool confirmFlow = await CustomModal.showModal(
          context: context,
          title: null,
          text: isANewElement
              ? "¿Desea crear el nuevo elemento?"
              : "¿Desea confirmar la actualización?",
        );
        if (!confirmFlow) return;
        final element =
            _getCurrentPatientData(context).prehospitalProcedure![widget.keyy];
        final id = _getCurrentPatientData(context).traumaRegisterRecordId!;
        final result = await (isANewElement
            ? _getCurrentProvider(context)
                .createPrehospitalProcedure(element, id)
            : _getCurrentProvider(context).updatePrehospitalProcedure(element));
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
              .deletePrehospitalProcedureById(_getCurrentPatientData(context)
                  .prehospitalProcedure![widget.keyy]
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
            prehospitalProcedure: _getCurrentPatientData(context)
                .prehospitalProcedure
                ?.asMap()
                .entries
                .where((e) => e.key != widget.keyy)
                .map((e) => e.value)
                .toList(),
          ),
          true,
        );
      },
      children: prehospitalProcedureContent(
        context: context,
        index: widget.keyy,
        prehospitalProcedure: widget.value,
        customSize: widget.customSize,
        isCreating: allowChanges,
        freeSize: widget.freeSize,
      ),
    );
  }

  List<Widget> prehospitalProcedureContent({
    required BuildContext context,
    required int index,
    required PrehospitalProcedure prehospitalProcedure,
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
        text: prehospitalProcedure.procedimientoRealizado ?? "",
        lines: 2,
        width: freeSize ? null : 460,
        suggestions: ContentOptions.prehospitalProcedure.procedimientoRealizado,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            prehospitalProcedure: patientData.prehospitalProcedure
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
    ];
  }

  PatientData _getCurrentPatientData(BuildContext context) {
    return Provider.of<TraumaDataProvider>(context, listen: false).patientData!;
  }

  TraumaDataProvider _getCurrentProvider(BuildContext context) {
    return Provider.of<TraumaDataProvider>(context, listen: false);
  }
}
