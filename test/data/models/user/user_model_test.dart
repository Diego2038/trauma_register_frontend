import 'package:flutter_test/flutter_test.dart';
import 'package:trauma_register_frontend/data/models/user/user_model.dart';

void main() {
  group('UserModel', () {
    const String testUsername = "testuser";
    const String testEmail = "test@example.com";

    final Map<String, dynamic> jsonMap = {
      "username": testUsername,
      "email": testEmail,
    };

    // Caso de prueba para el método fromJson
    test('fromJson should parse JSON to UserModel correctly', () {
      final user = UserModel.fromJson(jsonMap);

      expect(user.username, equals(testUsername));
      expect(user.email, equals(testEmail));
    });

    // Caso de prueba para el método toJson
    test('toJson should serialize UserModel to JSON correctly', () {
      final user = UserModel(username: testUsername, email: testEmail);

      final serializedJson = user.toJson();

      expect(serializedJson, equals(jsonMap));
    });
    
    // Caso de prueba para el método copyWith
    test('copyWith should create a new instance with updated values', () {
      final originalUser = UserModel(username: "original", email: "original@test.com");
      final updatedUser = originalUser.copyWith(username: "updated");
      
      expect(updatedUser.username, "updated");
      expect(updatedUser.email, originalUser.email); // El email no debería cambiar
      
      // Verificamos que es una nueva instancia
      expect(originalUser, isNot(equals(updatedUser)));
    });
  });
}