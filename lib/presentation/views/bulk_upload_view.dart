import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_checkbox.dart';

class BulkUploadView extends StatefulWidget {
  const BulkUploadView({super.key});

  @override
  State<BulkUploadView> createState() => _BulkUploadViewState();
}

class _BulkUploadViewState extends State<BulkUploadView> {
  FilePickerResult? filePickerResult;
  Uint8List? excelFileBytes;
  bool allowUpdateElements = false;
  bool allowOnlyUpdate = false;
  bool isLoadedSuccesful = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _customLoadSection(),
          _customViewResponse(),
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
                    onChanged: (value) {
                      allowUpdateElements = value;
                    },
                    minWidthToCollapse: 400,
                  ),
                  CustomCheckbox(
                    size: CustomSize.h5,
                    centerCheckBox: true,
                    text: 'Permitir únicamente actualización',
                    onChanged: (value) {
                      allowOnlyUpdate = value;
                    },
                    minWidthToCollapse: 400,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 15),
          CustomButton(
            size: CustomSize.h2,
            onPressed: uploadExcelFile,
            isAvailable: excelFileBytes != null,
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
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['xlsx'],
          );
          if (result != null) {
            final PlatformFile file = result.files.first;
            setState(() => excelFileBytes = file.bytes);
          }
        },
        child: DottedBorder(
          dashPattern: const [10, 5],
          color: AppColors.base,
          borderType: BorderType.RRect,
          strokeWidth: 2,
          radius: const Radius.circular(20),
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 175,
              maxWidth: 500,
            ),
            child: SizedBox(
              // height: 200,
              width: 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    excelFileBytes == null ? Icons.upload_file_outlined : Icons.check_circle,
                    color: AppColors.base,
                    size: 100,
                  ),
                  const SizedBox(height: 10),
                  H5(
                    text: excelFileBytes == null ? "Haga clic para seleccionar un archivo" : isLoadedSuccesful ? "El archivo Excel se ha cargado y guardado con éxito.\nHaz clic aquí si desea subir otro archivo." : "Archivo excel cargado",
                    color: AppColors.base300,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _customViewResponse() {
    return const Padding(
      padding: EdgeInsets.only(
        left: 40,
        top: 15,
        right: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          H1(
            text: "Estado de la carga de datos del archivo Excel",
            color: AppColors.base,
          ),
        ],
      ),
    );
  }

  Future<void> uploadExcelFile() async {
    print("subir");
  }
}
