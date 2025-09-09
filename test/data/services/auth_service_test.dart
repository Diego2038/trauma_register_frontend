import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trauma_register_frontend/core/helpers/local_storage.dart';
import 'package:trauma_register_frontend/data/models/http_response/custom_http_response.dart';
import 'package:trauma_register_frontend/data/models/user/user_model.dart';
import 'package:trauma_register_frontend/data/services/auth_service.dart';

void main() {
  setUp(() async {
    // Inicializa el mock de SharedPreferences antes de cada prueba
    SharedPreferences.setMockInitialValues({});
    await LocalStorage.configurePrefs();
  });

  group('AuthService - login', () {
    test('should return a UserModel and save tokens on a successful login', () async {
      final successfulResponse = CustomHttpResponse(
        statusCode: 200,
        statusMessage: "OK",
        data: {
          "token": "fake_token",
          "token_refresh": "fake_refresh_token",
          "user": {
            "username": "testuser",
            "email": "test@example.com",
          },
        },
      );

      final UserModel? user = await AuthService.login(
        username: "testuser",
        password: "password123",
        r: successfulResponse,
      );

      expect(user, isA<UserModel>());
      expect(user?.username, "testuser");
      expect(user?.email, "test@example.com");

      expect(LocalStorage.prefs.getString('token'), "fake_token");
      expect(LocalStorage.prefs.getString('token_refresh'), "fake_refresh_token");
      final storedUser = LocalStorage.prefs.getString('user');
      final decodedUser = jsonDecode(storedUser!);
      expect(decodedUser['username'], "testuser");
    });

    test('should return null and not save anything on a failed login', () async {
      final failedResponse = CustomHttpResponse(
        statusCode: 401,
        statusMessage: "Unauthorized",
        data: {"error": "Invalid credentials"},
      );

      final UserModel? user = await AuthService.login(
        username: "wronguser",
        password: "wrongpassword",
        r: failedResponse,
      );

      expect(user, isNull);
      expect(LocalStorage.prefs.getString('token'), isNull);
      expect(LocalStorage.prefs.getString('user'), isNull);
    });
  });

  group('AuthService - logOut', () {
    test('should clear all data from SharedPreferences', () async {
      await LocalStorage.prefs.setString('token', "valid_token");
      await LocalStorage.prefs.setString('user', "some_user_data");
      
      expect(LocalStorage.prefs.getString('token'), isNotNull);

      await AuthService.logOut();

      expect(LocalStorage.prefs.getString('token'), isNull);
      expect(LocalStorage.prefs.getString('user'), isNull);
    });
  });

  group('AuthService - verifyToken', () {
    test('should return true if token is valid (status code 200)', () async {
      await LocalStorage.prefs.setString('token', "valid_token");
      
      final validResponse = CustomHttpResponse(
        statusCode: 200,
        statusMessage: "OK",
        data: null,
      );

      final bool isValid = await AuthService.verifyToken(r: validResponse);

      expect(isValid, isTrue);
    });

    test('should return false if token is invalid (status code not 200)', () async {
      await LocalStorage.prefs.setString('token', "invalid_token");
      
      final invalidResponse = CustomHttpResponse(
        statusCode: 401,
        statusMessage: "Unauthorized",
        data: null,
      );

      final bool isValid = await AuthService.verifyToken(r: invalidResponse);

      expect(isValid, isFalse);
    });

    test('should return false if no token is found in LocalStorage', () async {
      final bool isValid = await AuthService.verifyToken(
        r: CustomHttpResponse(
          statusCode: 401,
          statusMessage: "Unauthorized",
          data: null,
        ),
      );

      expect(isValid, isFalse);
    });
  });
}