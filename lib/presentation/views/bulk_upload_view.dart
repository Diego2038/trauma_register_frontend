import 'dart:convert';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/helpers/local_storage.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/upload_file/upload_request.dart';
import 'package:trauma_register_frontend/data/models/upload_file/upload_response.dart';
import 'package:trauma_register_frontend/data/models/user/user_model.dart';
import 'package:trauma_register_frontend/presentation/providers/bulk_upload_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_dropdown.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_modal.dart';
import 'package:trauma_register_frontend/presentation/widgets/text_block.dart';

class BulkUploadView extends StatelessWidget {
  const BulkUploadView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BulkUploadProvider(),
      child: const BulkUploadViewContent(),
    );
  }
}

class BulkUploadViewContent extends StatefulWidget {
  const BulkUploadViewContent({super.key});

  @override
  State<BulkUploadViewContent> createState() => _BulkUploadViewContentState();
}

class _BulkUploadViewContentState extends State<BulkUploadViewContent> {
  Future<UploadResponse?>? _uploadFuture;
  Uint8List? excelFileBytes;
  bool allowUpdateElements = true;
  bool allowOnlyUpdate = false;
  bool isInitial = true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BulkUploadProvider(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _customLoadSection(),
            _customViewResponse(),
          ],
        ),
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomDropdown(
                      size: CustomSize.h5,
                      title: "Filtro de carga masiva",
                      hintText: "",
                      selectedValue: "Creación y actualización",
                      width: 275,
                      items: const [
                        "Creación y actualización",
                        "Únicamente creación",
                        "Únicamente actualización",
                      ],
                      onItemSelected: (String? value) {
                        if (value == null) return;
                        switch (value) {
                          case "Únicamente creación":
                            allowUpdateElements = false;
                            allowOnlyUpdate = false;
                            break;
                          case "Únicamente actualización":
                            allowUpdateElements = true;
                            allowOnlyUpdate = true;
                            break;
                          default:
                            allowUpdateElements = true;
                            allowOnlyUpdate = false;
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width > 450 ? null : 275,
                  padding: const EdgeInsets.only(bottom: 8),
                  child: CustomButton(
                    size: CustomSize.h2,
                    onPressed: () async => CustomModal.showModal(
                      context: context,
                      title: "Subida de archivo",
                      text:
                          "¿Está seguro que desea subir el archivo Excel? Recuerda que el tiempo de carga es proporcional a su contenido.",
                      onPressedAccept: () async => _startUpload(),
                    ),
                    isAvailable: excelFileBytes != null,
                    width: 383,
                    height: 45,
                    text: 'Subir archivo',
                    centerButtonContent: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget loadFileWidget() {
    final bulkUploadProvider =
        Provider.of<BulkUploadProvider>(context, listen: true);
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
                    excelFileBytes != null ||
                            bulkUploadProvider.isLoadedSuccesful
                        ? Icons.check_circle
                        : Icons.upload_file_outlined,
                    color: AppColors.base,
                    size: 100,
                  ),
                  const SizedBox(height: 10),
                  H5(
                    text: bulkUploadProvider.isLoadedSuccesful
                        ? "El archivo Excel se ha cargado y guardado con éxito.\nHaz clic aquí si desea subir otro archivo."
                        : excelFileBytes == null
                            ? "Haga clic para seleccionar un archivo"
                            : "Archivo excel cargado",
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
    return Padding(
      padding: const EdgeInsets.only(
        left: 40,
        top: 15,
        right: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const H1(
            text: "Estado de la carga de datos del archivo Excel",
            color: AppColors.base,
          ),
          if (isInitial)
            const H3(text: "No se ha subido ningún archivo.")
          else
            SizedBox(
              width: double.infinity,
              child: showUploadResult(),
            ),
        ],
      ),
    );
  }

  Widget showUploadResult() {
    return FutureBuilder<UploadResponse?>(
      future: _uploadFuture,
      builder: (context, snapshot) {
        if (_uploadFuture == null) return const SizedBox.shrink();
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              H3(text: "Subiendo y procesando los datos..."),
              SizedBox(
                height: 300,
                child: Center(
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: CircularProgressIndicator(
                      color: AppColors.base,
                      strokeWidth: 6,
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError || snapshot.data == null) {
          return const HeaderText(text: "Error al cargar los datos");
        }
        final response = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (response.allowUpdateData != null)
              TextBlock(
                title: "Permitir actualización de datos",
                text:
                    "${response.allowUpdateData! ? "E" : "No e"}stá permitido.",
                size: CustomSize.h3,
              ),
            if (response.onlyUpdate != null)
              TextBlock(
                title: "Permitir únicamente actualización",
                text: "${response.onlyUpdate! ? "A" : "No a"}plica.",
                size: CustomSize.h3,
              ),
            if (response.updatedPatients != null)
              TextBlock(
                title: "IDs de registros de pacientes actualizados",
                text: response.updatedPatients!.isEmpty
                    ? "No aplica."
                    : "∙ ${response.updatedPatients!.join('\n∙ ')}",
                size: CustomSize.h3,
              ),
            if (response.problems != null)
              TextBlock(
                title: "Errores ocurridos durante la carga",
                text: response.problems!.isEmpty
                    ? "No aplica."
                    : "∙ ${response.problems!.join('\n∙ ')}",
                size: CustomSize.h3,
              ),

            //! Format no valid section
            if (response.detail != null)
              TextBlock(
                title: "Error de formato",
                text:
                    response.detail!.isEmpty ? "No aplica." : response.detail!,
                size: CustomSize.h3,
              ),

            //! Update no valid
            if (response.error != null)
              TextBlock(
                title: "Error",
                text: response.error!.isEmpty ? "No aplica." : response.error!,
                size: CustomSize.h3,
              ),
            if (response.specificError != null)
              TextBlock(
                title: "Error específico",
                text: response.specificError!.isEmpty
                    ? "No aplica."
                    : response.specificError!,
                size: CustomSize.h3,
              ),
          ],
        );
      },
    );
  }

  void _startUpload() {
    final bulkUploadProvider = Provider.of<BulkUploadProvider>(
      context,
      listen: false,
    );
    final userJson = LocalStorage.prefs.getString('user') ??
        '{"username":"No name","email":""}';
    final UserModel user = UserModel.fromJson(json.decode(userJson));
    final uploadRequest = UploadRequest(
      file: excelFileBytes!,
      user: user.username,
      updateData: allowUpdateElements,
      onlyUpdate: allowOnlyUpdate,
    );
    setState(() {
      excelFileBytes = null;
      _uploadFuture = bulkUploadProvider.uploadExcelFile(uploadRequest);
      isInitial = false;
    });
  }
}
