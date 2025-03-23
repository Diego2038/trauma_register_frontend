
import 'dart:convert';

import 'package:trauma_register_frontend/core/helpers/endpoint_helper.dart';
import 'package:trauma_register_frontend/core/helpers/local_storage.dart';
import 'package:trauma_register_frontend/data/models/user/user_model.dart';

class AuthService {
  static Future<UserModel?> login({
    required String username,
    required String password,
  }) async {
    final response = await EndpointHelper.postRequest(
      path: "/user/login/",
      data: {
        "username": username,
        "password": password,
      },
      token: null, // No se necesita token para iniciar sesión
    );

    if ( response.statusCode == 200 ) {
      final responseJson = response.data as Map<String,dynamic>;
      final token = responseJson["token"] as String;
      final tokenRefresh = responseJson["token_refresh"] as String;
      final userJson = responseJson["user"] as Map<String,dynamic>;
      final user = UserModel.fromJson(userJson);

      await LocalStorage.prefs.setString('token', token);
      await LocalStorage.prefs.setString('token_refresh', tokenRefresh);
      await LocalStorage.prefs.setString('user', jsonEncode(user.toJson()));
      return user;
    }

    return null;
  }

  static Future<void> logOut() async {
    LocalStorage.prefs.clear();
  }
}
