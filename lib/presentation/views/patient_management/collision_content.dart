import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/collision.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_input_with_label.dart';
import 'package:trauma_register_frontend/presentation/widgets/expandable_title_widget.dart';

class CollisionContent extends StatelessWidget {
  const CollisionContent({
    super.key,
    required this.traumaDataProvider,
    required this.noDataWidget,
    required this.customSize,
    required this.allowEditFields,
    required this.freeSize,
  });

  final TraumaDataProvider traumaDataProvider;
  final NormalText noDataWidget;
  final CustomSize customSize;
  final bool allowEditFields;
  final bool freeSize;

  @override
  Widget build(BuildContext context) {
    return ExpandableTitleWidget(
      title: "Colisiones",
      index: 3,
      expandedWidget: traumaDataProvider.patientData!.collision == null ||
              traumaDataProvider.patientData!.collision!.isEmpty
          ? noDataWidget
          : SizedBox(
              width: double.infinity,
              child: Wrap(
                runSpacing: 10,
                spacing: 10,
                children: traumaDataProvider.patientData!.collision!
                    .map(
                      (collision) => CustomContainer(
                        children: collisionContent(
                          collision: collision,
                          customSize: customSize,
                          allowEditFields: allowEditFields,
                          traumaDataProvider: traumaDataProvider,
                          freeSize: freeSize,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
    );
  }

  List<Widget> collisionContent({
    required Collision collision,
    required CustomSize customSize,
    required bool allowEditFields,
    required TraumaDataProvider traumaDataProvider,
    required bool freeSize,
  }) {
    return [
      CustomInputWithLabel(
        size: customSize,
        readOnly: !allowEditFields,
        title: "Tipo de colisión",
        hintText: "No registra",
        text: collision.tipoDeColision ?? "",
        lines: 2,
        width: freeSize ? null : 460,
      ),
    ];
  }
}
