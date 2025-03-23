import 'package:dio/dio.dart';
import 'package:trauma_register_frontend/core/constants/api.dart';
import 'package:trauma_register_frontend/data/models/http_response/custom_http_response.dart';

class EndpointHelper {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: API,
      contentType: 'application/json',
      validateStatus: (int? status) => status != null && status < 500,
    ),
  );

  static Future<CustomHttpResponse> postRequest({
    required String path, 
    required Map<String, dynamic> data,
    required String? token
  }) async {
    try {
      final response = await _dio.post(
        path, 
        data: data,
        options: token == null
          ? null
          : Options(headers: {'Authorization': 'Bearer $token'})
      );
      return _convert(response);
    } catch (e) {
      rethrow; // Manejo de errores opcional
    }
  }

  static Future<CustomHttpResponse> getRequest({
    required String path, 
    Map<String, dynamic>? queryParams,
    required String? token
  }) async {
    try {
      final response = await _dio.get(
        path, 
        queryParameters: queryParams,
        options: token == null
          ? null
          : Options(headers: {'Authorization': 'Bearer $token'})
        );
      return _convert(response);
    } catch (e) {
      rethrow;
    }
  }

  static Future<CustomHttpResponse> putRequest({
    required String path, 
    required Map<String, dynamic> data,
    required String? token
  }) async {
    try {
      final response = await _dio.put(
        path, 
        data: data,
        options: token == null
          ? null
          : Options(headers: {'Authorization': 'Bearer $token'})
        );
      return _convert(response);
    } catch (e) {
      rethrow;
    }
  }

  static Future<CustomHttpResponse> deleteRequest({
    required String path,
    required String? token
  }) async {
    try {
      final response = await _dio.delete(
        path,
        options: token == null
          ? null
          : Options(headers: {'Authorization': 'Bearer $token'})
      );
      return _convert(response);
    } catch (e) {
      rethrow;
    }
  }

  static CustomHttpResponse _convert(Response response) => CustomHttpResponse(
    data: response.data,
    statusCode: response.statusCode,
    statusMessage: response.statusMessage,
  );
}
