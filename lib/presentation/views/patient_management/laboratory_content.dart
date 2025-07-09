import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/helpers/transform_data.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/shared/optional.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/laboratory.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/patient_data.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_icon_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class LaboratoryContent extends StatelessWidget {
  const LaboratoryContent({
    super.key,
    required this.noDataWidget,
    required this.customSize,
    required this.isCreating,
    required this.freeSize,
  });

  final NormalText noDataWidget;
  final CustomSize customSize;
  final bool isCreating;
  final bool freeSize;

  @override
  Widget build(BuildContext context) {
    return ExpandableTitleWidget(
      title: "Exámenes de laboratorio",
      index: 18,
      expandedWidget: _getCurrentPatientData(context).laboratory == null ||
              _getCurrentPatientData(context).laboratory!.isEmpty
          ? isCreating
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
                      .laboratory!
                      .asMap()
                      .entries
                      .map(
                        (entry) => _Content(
                          keyy: entry.key,
                          value: entry.value,
                          customSize: customSize,
                          isCreating: isCreating,
                          freeSize: freeSize,
                        ),
                      ),
                  if (isCreating) _addNewElement(context),
                ],
              ),
            ),
    );
  }

  Widget _addNewElement(BuildContext context) {
    return CustomIconButton(
      onPressed: () {
        final currentPatientData = _getCurrentPatientData(context);
        final currentElements = currentPatientData.laboratory;
        final traumaDataProvider = _getCurrentProvider(context);
        traumaDataProvider.updatePatientData(
            currentPatientData.copyWith(
              laboratory: [
                if (currentElements != null) ...currentElements,
                Laboratory(),
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
    required this.isCreating,
    required this.freeSize,
  });

  final int keyy;
  final Laboratory value;
  final CustomSize customSize;
  final bool isCreating;
  final bool freeSize;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      maxWidth: 600,
      showDeleteButton: widget.isCreating,
      onDelete: () {
        _getCurrentProvider(context).updatePatientData(
          _getCurrentPatientData(context).copyWith(
            laboratory: _getCurrentPatientData(context)
                .laboratory
                ?.asMap()
                .entries
                .where((e) => e.key != widget.keyy)
                .map((e) => e.value)
                .toList(),
          ),
          true,
        );
      },
      children: laboratoryContent(
        context: context,
        index: widget.keyy,
        laboratory: widget.value,
        customSize: widget.customSize,
        isCreating: widget.isCreating,
        freeSize: widget.freeSize,
      ),
    );
  }

  List<Widget> laboratoryContent({
    required BuildContext context,
    required int index,
    required Laboratory laboratory,
    required CustomSize customSize,
    required bool isCreating,
    required bool freeSize,
  }) {
    final traumaDataProvider = _getCurrentProvider(context);
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Resultado de laboratorio",
        hintText: "No registra",
        text: laboratory.resultadoDeLaboratorio ?? "",
        lines: 2,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            laboratory: patientData.laboratory
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        resultadoDeLaboratorio: Optional<String?>.of(
                            TransformData.getTransformedValue<String>(value)))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Fecha y hora de laboratorio",
        hintText: "No registra",
        text: laboratory.fechaYHoraDeLaboratorio != null
            ? DateFormat('dd/MM/yyyy HH:mm:ss')
                .format(laboratory.fechaYHoraDeLaboratorio!)
            : "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 124,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            laboratory: patientData.laboratory
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        fechaYHoraDeLaboratorio: Optional<DateTime?>.of(
                            TransformData.getTransformedValue<DateTime>(value)))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Nombre de la prueba de laboratorio",
        hintText: "No registra",
        text: laboratory.nombreDelLaboratorio ?? "",
        lines: 3,
        width: freeSize ? null : 220,
        height: freeSize ? null : 154,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            laboratory: patientData.laboratory
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        nombreDelLaboratorio: Optional<String?>.of(
                            TransformData.getTransformedValue<String>(value)))
                    : e.value)
                .toList(),
          ));
        },
      ),
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Nombre de la unidad de laboratorio",
        hintText: "No registra",
        text: laboratory.nombreDeLaUnidadDeLaboratorio ?? "",
        lines: 1,
        width: freeSize ? null : 220,
        height: freeSize ? null : 154,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            laboratory: patientData.laboratory
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        nombreDeLaUnidadDeLaboratorio: Optional<String?>.of(
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
