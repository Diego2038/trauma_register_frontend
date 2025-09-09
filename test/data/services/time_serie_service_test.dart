import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trauma_register_frontend/core/helpers/local_storage.dart';
import 'package:trauma_register_frontend/data/models/http_response/custom_http_response.dart';
import 'package:trauma_register_frontend/data/models/stats/time_serie.dart';
import 'package:trauma_register_frontend/data/services/time_serie_service.dart';


void main() {
  late TimeSeriesService service;

  setUp(() async {
    service = TimeSeriesService();
    // Simula SharedPreferences para que LocalStorage funcione
    SharedPreferences.setMockInitialValues({'token': 'fake_token'});
    await LocalStorage.configurePrefs();
  });

  group('TimeSeriesService - getTraumaCountByDate', () {
    test('should return TimeSeries on successful request with start and end dates', () async {
      // 1. Datos de prueba
      final successfulResponse = CustomHttpResponse(
        statusCode: 200,
        statusMessage: "OK",
        data: {
          "data": [
            {"date": "2023-01-01", "count": 10},
            {"date": "2023-01-02", "count": 15},
          ]
        },
      );
      
      final startDate = DateTime(2023, 1, 1);
      final endDate = DateTime(2023, 1, 2);

      // 2. Llama al método del servicio con la respuesta simulada
      final TimeSeries? result = await service.getTraumaCountByDate(
        startDate: startDate,
        endDate: endDate,
        r: successfulResponse,
      );

      // 3. Verificaciones
      expect(result, isNotNull);
      expect(result, isA<TimeSeries>());
      expect(result?.data.length, 2);
      expect(result?.data.first.date, '2023-01-01');
      expect(result?.data.last.count, 15);
    });

    test('should return TimeSeries on successful request with only startDate', () async {
      final successfulResponse = CustomHttpResponse(
        statusCode: 200,
        statusMessage: "OK",
        data: {
          "data": [
            {"date": "2023-01-01", "count": 10}
          ]
        },
      );
      
      final startDate = DateTime(2023, 1, 1);

      final TimeSeries? result = await service.getTraumaCountByDate(
        startDate: startDate,
        endDate: null,
        r: successfulResponse,
      );

      expect(result, isNotNull);
      expect(result?.data.length, 1);
      expect(result?.data.first.date, '2023-01-01');
    });

    test('should return TimeSeries on successful request with only endDate', () async {
      final successfulResponse = CustomHttpResponse(
        statusCode: 200,
        statusMessage: "OK",
        data: {
          "data": [
            {"date": "2023-01-02", "count": 15}
          ]
        },
      );
      
      final endDate = DateTime(2023, 1, 2);

      final TimeSeries? result = await service.getTraumaCountByDate(
        startDate: null,
        endDate: endDate,
        r: successfulResponse,
      );

      expect(result, isNotNull);
      expect(result?.data.length, 1);
      expect(result?.data.first.date, '2023-01-02');
    });

    test('should return null on a 404 status code', () async {
      final notFoundResponse = CustomHttpResponse(
        statusCode: 404,
        statusMessage: "Not Found",
        data: null,
      );

      final TimeSeries? result = await service.getTraumaCountByDate(
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        r: notFoundResponse,
      );

      expect(result, isNull);
    });

    test('should return null on an exception (e.g., malformed data)', () async {
      final malformedResponse = CustomHttpResponse(
        statusCode: 200,
        statusMessage: "OK",
        data: "This is not a Map", // Forzamos un error en `response.data as Map<String, dynamic>`
      );

      final TimeSeries? result = await service.getTraumaCountByDate(
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        r: malformedResponse,
      );

      expect(result, isNull);
    });
  });
}