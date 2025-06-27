import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/helpers/transform_data.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/collision.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/patient_data.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_icon_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class CollisionContent extends StatelessWidget {
  const CollisionContent({
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
      title: "Colisiones",
      index: 3,
      expandedWidget: _getCurrentPatientData(context).collision == null ||
              _getCurrentPatientData(context).collision!.isEmpty
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
                      .collision!
                      .asMap()
                      .entries
                      .map(
                        (entry) => CustomContainer(
                          children: collisionContent(
                            context: context,
                            collision: entry.value,
                            index: entry.key,
                            customSize: customSize,
                            isCreating: isCreating,
                            freeSize: freeSize,
                          ),
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
        final currentElements = currentPatientData.collision;
        final traumaDataProvider = _getCurrentProvider(context);
        traumaDataProvider.updatePatientData(
            currentPatientData.copyWith(
              collision: [
                if (currentElements != null) ...currentElements,
                Collision(),
              ],
            ),
            true);
      },
    );
  }

  List<Widget> collisionContent({
    required BuildContext context,
    required int index,
    required Collision collision,
    required CustomSize customSize,
    required bool isCreating,
    required bool freeSize,
  }) {
    final traumaDataProvider = _getCurrentProvider(context);
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !isCreating,
        title: "Tipo de colisión",
        hintText: "No registra",
        text: collision.tipoDeColision ?? "",
        lines: 2,
        width: freeSize ? null : 460,
        onChanged: (String? value) {
          final patientData = _getCurrentPatientData(context);
          traumaDataProvider.updatePatientData(patientData.copyWith(
            collision: patientData.collision
                ?.asMap()
                .entries
                .map((e) => e.key == index
                    ? e.value.copyWith(
                        tipoDeColision:
                            TransformData.getTransformedValue<String>(value))
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
