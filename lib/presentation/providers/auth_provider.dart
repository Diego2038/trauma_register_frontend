import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/routes/app_router.dart';
import 'package:trauma_register_frontend/data/services/auth_service.dart';
import 'package:trauma_register_frontend/data/services/navigation_service.dart';

enum AuthStatus {
  authenticated,
  notAuthenticated,
  none,
}

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  AuthStatus authStatus = AuthStatus.none;

  AuthProvider() {
    _checkAuthStatus();
  }

  Future<bool> login(
      {required String username, required String password}) async {
    final response =
        await AuthService.login(username: username, password: password);

    if (response != null) {
      authStatus = AuthStatus.authenticated;
      _isAuthenticated = true;
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<void> logout() async {
    await AuthService.logOut();
    authStatus = AuthStatus.notAuthenticated;
    _isAuthenticated = false;
    notifyListeners();
    NavigationService.navigateAndRemoveUntil(AppRouter.login);
  }

  Future<bool> verifyToken() async {
    final isValid = await AuthService.verifyToken();
    if (isValid) {
      authStatus = AuthStatus.authenticated;
      _isAuthenticated = true;
    } else {
      authStatus = AuthStatus.notAuthenticated;
      _isAuthenticated = false;
    }
    return isValid;
  }

  Future<void> _checkAuthStatus() async {
    await verifyToken();
    notifyListeners();
  }
}
