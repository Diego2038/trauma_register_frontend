import 'package:flutter/foundation.dart';
import 'package:trauma_register_frontend/data/models/upload_file/upload_request.dart';
import 'package:trauma_register_frontend/data/models/upload_file/upload_response.dart';
import 'package:trauma_register_frontend/data/services/bulk_upload_service.dart';

class BulkUploadProvider extends ChangeNotifier {
  bool isLoadedSuccesful = false;

  void updateIsLoaded(bool isLoadedSuccesful) {
    this.isLoadedSuccesful = isLoadedSuccesful;
    notifyListeners();
  }

  Future<UploadResponse?> uploadExcelFile(UploadRequest uploadRequest) async {
    final bulkUploadService = BulkUploadService();
    final response = await bulkUploadService.uploadExcelFile(uploadRequest);
    updateIsLoaded(response != null &&
        response.detail == null &&
        response.specificError == null &&
        response.error == null);
    return response;
  }
}
