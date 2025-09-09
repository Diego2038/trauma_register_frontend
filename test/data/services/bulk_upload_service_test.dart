import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trauma_register_frontend/core/helpers/local_storage.dart';
import 'package:trauma_register_frontend/data/models/http_response/custom_http_response.dart';
import 'package:trauma_register_frontend/data/models/upload_file/upload_request.dart';
import 'package:trauma_register_frontend/data/models/upload_file/upload_response.dart';
import 'package:trauma_register_frontend/data/services/bulk_upload_service.dart';


void main() {
  late BulkUploadService service;

  setUp(() async {
    service = BulkUploadService();
    // Simula SharedPreferences para que LocalStorage funcione
    SharedPreferences.setMockInitialValues({'token': 'fake_token'});
    await LocalStorage.configurePrefs();
  });

  group('BulkUploadService - uploadExcelFile', () {
    test('should return an UploadResponse on a successful 200 status code', () async {
      // 1. Datos de prueba
      final uploadRequest = UploadRequest(
        file: Uint8List.fromList([1, 2, 3]),
        user: "testuser",
        updateData: true,
        onlyUpdate: false,
      );
      
      final successfulResponseData = {
        "file": 1,
        "user": "testuser",
        "allow_update_data": true,
        "only_update": false,
        "updated_patients": ["patient1", "patient2"],
        "problems": [],
        "detail": "Success",
        "error": null,
        "specific_error": null,
      };

      // 2. Simula una respuesta exitosa
      final successfulResponse = CustomHttpResponse(
        statusCode: 200,
        statusMessage: "OK",
        data: successfulResponseData,
      );

      // 3. Llama al método del servicio con la respuesta simulada
      final UploadResponse? response = await service.uploadExcelFile(
        uploadRequest,
        successfulResponse,
      );

      // 4. Verificaciones
      expect(response, isNotNull);
      expect(response, isA<UploadResponse>());
      expect(response?.file, 1);
      expect(response?.updatedPatients, ["patient1", "patient2"]);
    });

    test('should return an UploadResponse with error details on a non-200, non-404 status code', () async {
      // 1. Datos de prueba
      final uploadRequest = UploadRequest(
        file: Uint8List.fromList([]),
        user: "testuser",
        updateData: false,
        onlyUpdate: false,
      );
      
      final errorResponseData = {
        "detail": "Invalid file format",
        "error": "BAD_REQUEST",
        "specific_error": "The file provided is not a valid Excel file.",
      };

      // 2. Simula una respuesta de error 400
      final errorResponse = CustomHttpResponse(
        statusCode: 400,
        statusMessage: "Bad Request",
        data: errorResponseData,
      );

      // 3. Llama al método del servicio
      final UploadResponse? response = await service.uploadExcelFile(
        uploadRequest,
        errorResponse,
      );

      // 4. Verificaciones
      expect(response, isNotNull);
      expect(response, isA<UploadResponse>());
      expect(response?.detail, "Invalid file format");
      expect(response?.error, "BAD_REQUEST");
    });
    
    test('should return null on a 404 status code', () async {
      // 1. Datos de prueba
      final uploadRequest = UploadRequest(
        file: Uint8List.fromList([]),
        user: "testuser",
        updateData: false,
        onlyUpdate: false,
      );
      
      // 2. Simula una respuesta 404 (Not Found)
      final notFoundResponse = CustomHttpResponse(
        statusCode: 404,
        statusMessage: "Not Found",
        data: null,
      );

      // 3. Llama al método del servicio
      final UploadResponse? response = await service.uploadExcelFile(
        uploadRequest,
        notFoundResponse,
      );

      // 4. Verificaciones
      expect(response, isNull);
    });

    test('should return null on an exception (e.g., malformed data)', () async {
      // 1. Datos de prueba
      final uploadRequest = UploadRequest(
        file: Uint8List.fromList([]),
        user: "testuser",
        updateData: false,
        onlyUpdate: false,
      );
      
      // 2. Simula una respuesta con un tipo de dato incorrecto (esto forzará una excepción)
      final malformedResponse = CustomHttpResponse(
        statusCode: 200,
        statusMessage: "OK",
        data: "This is not a Map", // Forzamos un error en la línea `response.data as Map<String, dynamic>`
      );

      // 3. Llama al método del servicio
      final UploadResponse? response = await service.uploadExcelFile(
        uploadRequest,
        malformedResponse,
      );
      
      // 4. Verificaciones
      expect(response, isNull);
    });
  });
}