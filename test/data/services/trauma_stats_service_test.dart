import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trauma_register_frontend/core/helpers/local_storage.dart';
import 'package:trauma_register_frontend/data/models/http_response/custom_http_response.dart';
import 'package:trauma_register_frontend/data/models/stats/categorical_stats.dart';
import 'package:trauma_register_frontend/data/models/stats/single_value_stats.dart';
import 'package:trauma_register_frontend/data/services/trauma_stats_service.dart';

void main() {
  late TraumaStatsService service;

  setUp(() async {
    service = TraumaStatsService();
    // Simula SharedPreferences
    SharedPreferences.setMockInitialValues({'token': 'fake_token'});
    await LocalStorage.configurePrefs();
  });
  
  // Datos de prueba comunes
  final startDate = DateTime(2023, 1, 1);
  final endDate = DateTime(2023, 1, 31);
  final expectedCategoricalResponse = {
    "data": [
      {"tag": "Tag1", "total": 10.0},
      {"tag": "Tag2", "total": 20.0},
    ]
  };

  group('TraumaStatsService - getAmountOfPatients', () {
    test('should return SingleValueStats on successful request', () async {
      final response = CustomHttpResponse(
        statusCode: 200,
        statusMessage: "OK",
        data: {"data": 123.0},
      );
      final result = await service.getAmountOfPatients(startDate: startDate, endDate: endDate, r: response);
      expect(result, isA<SingleValueStats>());
      expect(result?.data, 123.0);
    });

    test('should return null on 404 status code', () async {
      final response = CustomHttpResponse(statusCode: 404, statusMessage: "Not Found", data: null);
      final result = await service.getAmountOfPatients(startDate: startDate, endDate: endDate, r: response);
      expect(result, isNull);
    });

    test('should return null on malformed data', () async {
      final response = CustomHttpResponse(statusCode: 200, statusMessage: "OK", data: "malformed_data");
      final result = await service.getAmountOfPatients(startDate: startDate, endDate: endDate, r: response);
      expect(result, isNull);
    });
  });

  group('TraumaStatsService - getGenders', () {
    test('should return CategoricalStats on successful request', () async {
      final response = CustomHttpResponse(statusCode: 200, statusMessage: "OK", data: expectedCategoricalResponse);
      final result = await service.getGenders(startDate: startDate, endDate: endDate, r: response);
      expect(result, isA<CategoricalStats>());
      expect(result?.data.length, 2);
      expect(result?.data.first.tag, 'Tag1');
    });

    test('should return null on 404 status code', () async {
      final response = CustomHttpResponse(statusCode: 404, statusMessage: "Not Found", data: null);
      final result = await service.getGenders(startDate: startDate, endDate: endDate, r: response);
      expect(result, isNull);
    });

    test('should return null on malformed data', () async {
      final response = CustomHttpResponse(statusCode: 200, statusMessage: "OK", data: "malformed_data");
      final result = await service.getGenders(startDate: startDate, endDate: endDate, r: response);
      expect(result, isNull);
    });
  });

  group('TraumaStatsService - getPatientsAges', () {
    test('should return CategoricalStats on successful request', () async {
      final response = CustomHttpResponse(statusCode: 200, statusMessage: "OK", data: expectedCategoricalResponse);
      final result = await service.getPatientsAges(startDate: startDate, endDate: endDate, r: response);
      expect(result, isA<CategoricalStats>());
      expect(result?.data.length, 2);
      expect(result?.data.first.total, 10.0);
    });

    test('should return null on 404 status code', () async {
      final response = CustomHttpResponse(statusCode: 404, statusMessage: "Not Found", data: null);
      final result = await service.getPatientsAges(startDate: startDate, endDate: endDate, r: response);
      expect(result, isNull);
    });
    
    test('should return null on malformed data', () async {
      final response = CustomHttpResponse(statusCode: 200, statusMessage: "OK", data: "malformed_data");
      final result = await service.getPatientsAges(startDate: startDate, endDate: endDate, r: response);
      expect(result, isNull);
    });
  });

  group('TraumaStatsService - getPatientsWithRelations', () {
    test('should return CategoricalStats on successful request', () async {
      final response = CustomHttpResponse(statusCode: 200, statusMessage: "OK", data: expectedCategoricalResponse);
      final result = await service.getPatientsWithRelations(startDate: startDate, endDate: endDate, r: response);
      expect(result, isA<CategoricalStats>());
      expect(result?.data.length, 2);
    });

    test('should return null on 404 status code', () async {
      final response = CustomHttpResponse(statusCode: 404, statusMessage: "Not Found", data: null);
      final result = await service.getPatientsWithRelations(startDate: startDate, endDate: endDate, r: response);
      expect(result, isNull);
    });

    test('should return null on malformed data', () async {
      final response = CustomHttpResponse(statusCode: 200, statusMessage: "OK", data: "malformed_data");
      final result = await service.getPatientsWithRelations(startDate: startDate, endDate: endDate, r: response);
      expect(result, isNull);
    });
  });

  group('TraumaStatsService - getInsuredPatients', () {
    test('should return CategoricalStats on successful request', () async {
      final response = CustomHttpResponse(statusCode: 200, statusMessage: "OK", data: expectedCategoricalResponse);
      final result = await service.getInsuredPatients(startDate: startDate, endDate: endDate, r: response);
      expect(result, isA<CategoricalStats>());
      expect(result?.data.length, 2);
    });

    test('should return null on 404 status code', () async {
      final response = CustomHttpResponse(statusCode: 404, statusMessage: "Not Found", data: null);
      final result = await service.getInsuredPatients(startDate: startDate, endDate: endDate, r: response);
      expect(result, isNull);
    });

    test('should return null on malformed data', () async {
      final response = CustomHttpResponse(statusCode: 200, statusMessage: "OK", data: "malformed_data");
      final result = await service.getInsuredPatients(startDate: startDate, endDate: endDate, r: response);
      expect(result, isNull);
    });
  });

  group('TraumaStatsService - getTypeOfPatientsAdmission', () {
    test('should return CategoricalStats on successful request', () async {
      final response = CustomHttpResponse(statusCode: 200, statusMessage: "OK", data: expectedCategoricalResponse);
      final result = await service.getTypeOfPatientsAdmission(startDate: startDate, endDate: endDate, r: response);
      expect(result, isA<CategoricalStats>());
      expect(result?.data.length, 2);
    });

    test('should return null on 404 status code', () async {
      final response = CustomHttpResponse(statusCode: 404, statusMessage: "Not Found", data: null);
      final result = await service.getTypeOfPatientsAdmission(startDate: startDate, endDate: endDate, r: response);
      expect(result, isNull);
    });

    test('should return null on malformed data', () async {
      final response = CustomHttpResponse(statusCode: 200, statusMessage: "OK", data: "malformed_data");
      final result = await service.getTypeOfPatientsAdmission(startDate: startDate, endDate: endDate, r: response);
      expect(result, isNull);
    });
  });
}