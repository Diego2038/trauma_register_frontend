import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:trauma_register_frontend/core/helpers/endpoint_helper.dart';
import 'package:trauma_register_frontend/data/models/http_response/custom_http_response.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;

  setUp(() {
    // 1. Creamos una instancia de Dio y su adaptador de mock
    dio = Dio(BaseOptions(baseUrl: 'http://your-api-url.com'));
    dioAdapter = DioAdapter(dio: dio);

    // 2. Inyectamos la instancia de Dio en tu clase estática
    EndpointHelper.dio = dio;
  });

  group('EndpointHelper Tests', () {
    // --- postRequest Tests ---
    test('postRequest should return CustomHttpResponse on success with token',
        () async {
      // Configuramos el mock para la respuesta del POST
      dioAdapter.onPost(
        '/test',
        (server) => server.reply(200, {'message': 'Success'}),
        data: {
          'key': 'value'
        }, // Opcional, para verificar que los datos coincidan
        headers: {
          'Authorization': 'Bearer test_token',
        },
      );

      final result = await EndpointHelper.postRequest(
        path: '/test',
        data: {'key': 'value'},
        token: 'test_token',
      );

      expect(result, isA<CustomHttpResponse>());
      expect(result.statusCode, 200);
      expect(result.data, {'message': 'Success'});
    });

    test('postRequest should handle success without token', () async {
      dioAdapter.onPost(
        '/test',
        (server) => server.reply(200, {'message': 'Success'}),
        data: {'key': 'value'},
      );

      final result = await EndpointHelper.postRequest(
        path: '/test',
        data: {'key': 'value'},
        token: null,
      );

      expect(result.statusCode, 200);
    });

    // --- postRequestFileFormat Tests ---
    test('postRequestFileFormat should send data as FormData with file',
        () async {
      final fileBytes = Uint8List.fromList([1, 2, 3, 4]);
      final data = {'name': 'file_upload', 'file': fileBytes};

      dioAdapter.onPost(
        '/upload',
        (server) => server.reply(200, {'message': 'File uploaded'}),
        data: (data) => data
            is FormData, // Usamos un validador de tipo para confirmar el formato
      );

      final result = await EndpointHelper.postRequestFileFormat(
        path: '/upload',
        data: data,
        token: 'file_token',
      );

      expect(result.statusCode, 200);
      expect(result.data, {'message': 'File uploaded'});
    });

    // --- getRequest Tests ---
    test('getRequest should handle success with query params and token',
        () async {
      dioAdapter.onGet(
        '/data',
        (server) => server.reply(200, {'data': 'list'}),
        queryParameters: {'filter': 'true'},
        headers: {
          'Authorization': 'Bearer get_token',
        },
      );

      final result = await EndpointHelper.getRequest(
        path: '/data',
        queryParams: {'filter': 'true'},
        token: 'get_token',
      );

      expect(result.statusCode, 200);
      expect(result.data, {'data': 'list'});
    });

    test('getRequest should handle success without token or params', () async {
      dioAdapter.onGet(
        '/data',
        (server) => server.reply(200, {'data': 'all'}),
      );

      final result = await EndpointHelper.getRequest(
        path: '/data',
        token: null,
      );

      expect(result.statusCode, 200);
      expect(result.data, {'data': 'all'});
    });

    // --- putRequest Tests ---
    test('putRequest should return CustomHttpResponse on success with token',
        () async {
      dioAdapter.onPut(
        '/update/1',
        (server) => server.reply(200, {'message': 'Updated'}),
        data: {'key': 'new_value'},
        headers: {
          'Authorization': 'Bearer put_token',
        },
      );

      final result = await EndpointHelper.putRequest(
        path: '/update/1',
        data: {'key': 'new_value'},
        token: 'put_token',
      );

      expect(result.statusCode, 200);
      expect(result.data, {'message': 'Updated'});
    });

    // --- deleteRequest Tests ---
    test('deleteRequest should return CustomHttpResponse on success with token',
        () async {
      dioAdapter.onDelete(
        '/delete/1',
        (server) => server.reply(204, null),
        headers: {
          'Authorization': 'Bearer delete_token',
        },
      );

      final result = await EndpointHelper.deleteRequest(
        path: '/delete/1',
        token: 'delete_token',
      );

      expect(result.statusCode, 204);
      expect(result.data, null);
    });

    // --- Error Handling Tests ---
    test('postRequest should rethrow DioException on network error', () {
      dioAdapter.onPost(
        '/test',
        (server) => server.reply(500, {'error': 'Internal Server Error'}),
      );

      expect(
          () =>
              EndpointHelper.postRequest(path: '/test', data: {}, token: null),
          throwsA(isA<DioException>()));
    });

    test('postRequest should rethrow DioException for 400 Bad Request', () {
      final requestData = {'email': 'test@example.com', 'password': 'wrong_password'};
      
      dioAdapter.onPost(
        '/login', 
        (server) => server.reply(400, {'error': 'Invalid credentials'}),
        data: requestData,
        headers: {
          'Content-Type': 'application/json'
        },
      );

      expect(() => EndpointHelper.postRequest(
        path: '/login', 
        data: requestData, 
        token: null), 
      throwsA(isA<DioException>().having((e) => e.response!.statusCode, 'statusCode', equals(400))));
    });

    test('getRequest should rethrow DioException for 404 Not Found', () {
      dioAdapter.onGet(
        '/nonexistent-path',
        (server) => server.reply(404, {'error': 'Not Found'}),
      );

      expect(
          () => EndpointHelper.getRequest(
              path: '/nonexistent-path',
              queryParams: null,
              token: 'some_token'),
          throwsA(isA<DioException>().having(
              (e) => e.response!.statusCode, 'statusCode', equals(404))));
    });
  });
}
