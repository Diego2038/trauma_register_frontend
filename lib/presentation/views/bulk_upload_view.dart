import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_checkbox.dart';

class BulkUploadView extends StatelessWidget {
  const BulkUploadView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _customLoadSection(),
          const Text("Bulk upload view"),
        ],
      ),
    );
  }

  Container _customLoadSection() {
    return Container(
      constraints: const BoxConstraints(),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: AppColors.base50,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(width: double.infinity),
          Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 10,
            spacing: 20,
            children: [
              loadFileWidget(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomCheckbox(
                    size: CustomSize.h5,
                    centerCheckBox: true,
                    text: 'Permitir actualización de datos',
                    onChanged: (value) {},
                    minWidthToCollapse: 400,
                  ),
                  CustomCheckbox(
                    size: CustomSize.h5,
                    centerCheckBox: true,
                    text: 'Permitir únicamente actualización',
                    onChanged: (value) {},
                    minWidthToCollapse: 400,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 15),
          const CustomButton(
            size: CustomSize.h2,
            onPressed: null,
            width: 383,
            height: 45,
            text: 'Subir archivo',
            centerButtonContent: true,
          ),
        ],
      ),
    );
  }

  Widget loadFileWidget() {
    return DottedBorder(
      dashPattern: const [10, 5],
      color: AppColors.base,
      borderType: BorderType.RRect,
      strokeWidth: 2,
      radius: const Radius.circular(20),
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 200,
          maxWidth: 500,
        ),
        child: const SizedBox(
          height: 250,
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.upload_file_outlined,
                color: AppColors.base,
                size: 100,
              ),
              SizedBox(height: 10),
              H4(
                text: "Haga clic para seleccionar un archivo",
                color: AppColors.base300,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
