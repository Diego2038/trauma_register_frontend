import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/enums/input_type.dart';
import 'package:trauma_register_frontend/core/helpers/transform_data.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/shared/optional.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/patient_data.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/penetrating_injury.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_icon_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class PenetratingInjuryContent extends StatelessWidget {
  const PenetratingInjuryContent({
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
      title: "Lesiones penetrantes",
      index: 14,
      expandedWidget:
          _getCurrentPatientData(context).penetratingInjury == null ||
                  _getCurrentPatientData(context).penetratingInjury!.isEmpty
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
                          .penetratingInjury!
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
        final currentElements = currentPatientData.penetratingInjury;
        final traumaDataProvider = _getCurrentProvider(context);
        traumaDataProvider.updatePatientData(
            currentPatientData.copyWith(
              penetratingInjury: [
                if (currentElements != null) ...currentElements,
                PenetratingInjury(),
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
  final PenetratingInjury value;
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
            penetratingInjury: _getCurrentPatientData(context)
                .penetratingInjury
                ?.asMap()
                .entries
                .where((e) => e.key != widget.keyy)
                .map((e) => e.value)
                .toList(),
          ),
          true,
        );
      },
      children: penetratingInjuryContent(
        context: context,
        index: widget.keyy,
        penetratingInjury: widget.value,
        customSize: widget.customSize,
        isCreating: widget.isCreating,
        freeSize: widget.freeSize,
      ),
    );
  }

  List<Widget> penetratingInjuryContent({
    required BuildContext context,
    required int index,
    required PenetratingInjury penetratingInjury,
    required CustomSize customSize,
    required bool isCreating,
    required bool freeSize,
  }) {
    final traumaDataProvider = _getCurrentProvider(context);
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Tipo de lesión penetrante",
        hintText: "No registra",
        text: penetratingInjury.tipoDeLesionPenetrante ?? "",
        lines: 1,
        width: freeSize ? null : 460,
        inputType: InputType.string,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            penetratingInjury: patientData.penetratingInjury
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        tipoDeLesionPenetrante: Optional<String?>.of(
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
