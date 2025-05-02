import 'package:trauma_register_frontend/core/helpers/endpoint_helper.dart';
import 'package:trauma_register_frontend/core/helpers/local_storage.dart';
import 'package:trauma_register_frontend/core/helpers/print_error.dart';
import 'package:trauma_register_frontend/data/models/upload_file/upload_request.dart';
import 'package:trauma_register_frontend/data/models/upload_file/upload_response.dart';

class BulkUploadService {
  Future<UploadResponse?> uploadExcelFile(UploadRequest uploadRequest) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.postRequestFileFormat(
        path: "/upload_manager/upload/",
        token: token,
        data: uploadRequest.toJson(),
      );
      if (response.statusCode == 404) return null;
      final data = response.data as Map<String, dynamic>;
      return UploadResponse.fromJson(data);
    } catch (e, s) {
      PrintError.makePrint(
        e: e,
        ubication: 'bulk_upload_service.dart',
        stack: s,
      );
      return null;
    }
  }
}