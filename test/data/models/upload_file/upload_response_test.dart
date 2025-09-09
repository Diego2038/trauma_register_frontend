import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:trauma_register_frontend/data/models/upload_file/upload_request.dart';
import 'package:trauma_register_frontend/data/models/upload_file/upload_response.dart';

void main() {
  group('UploadResponse', () {
    // Caso de prueba 1: Respuesta de éxito con todos los campos
    test('fromJson should parse all fields correctly on a successful response',
        () {
      final Map<String, dynamic> jsonMap = {
        "file": Uint8List.fromList([1, 2, 3]),
        "user": "test_user",
        "update_data": true,
        "only_update": false,
      };

      final response = UploadRequest.fromJson(jsonMap);

      expect(response.file, [1, 2, 3]);
      expect(response.user, "test_user");
      expect(response.updateData, true);
      expect(response.onlyUpdate, false);
    });

    // Caso de prueba 2: Respuesta con error y campos nulos
    test('fromJson should handle null and error fields correctly on a failed response',
        () {
      final Map<String, dynamic> jsonMap = {
        "file": null,
        "user": null,
        "allow_update_data": null,
        "only_update": null,
        "updated_patients": null,
        "problems": null,
        "detail": "Error en la carga",
        "error": "BAD_REQUEST",
        "specific_error": "Archivo no válido",
      };

      final response = UploadResponse.fromJson(jsonMap);

      expect(response.file, isNull);
      expect(response.user, isNull);
      expect(response.allowUpdateData, isNull);
      expect(response.onlyUpdate, isNull);
      expect(response.updatedPatients, isEmpty); // La lógica de fromJson lo convierte a []
      expect(response.problems, isEmpty); // La lógica de fromJson lo convierte a []
      expect(response.detail, "Error en la carga");
      expect(response.error, "BAD_REQUEST");
      expect(response.specificError, "Archivo no válido");
    });
    
    // Caso de prueba 3: toJson debería serializar todos los campos correctamente
    test('toJson should serialize all fields correctly', () {
      final response = UploadResponse(
        file: 456,
        user: "another_user",
        allowUpdateData: false,
        onlyUpdate: true,
        updatedPatients: ["patient3"],
        problems: ["problema1", "problema2"],
        detail: "Procesado",
      );

      final jsonMap = response.toJson();

      expect(jsonMap['file'], 456);
      expect(jsonMap['user'], 'another_user');
      expect(jsonMap['update_data'], false);
      expect(jsonMap['only_update'], true);
      expect(jsonMap['updated_patients'], ["patient3"]);
      expect(jsonMap['problems'], ["problema1", "problema2"]);
      expect(jsonMap['detail'], "Procesado");
      expect(jsonMap['error'], isNull);
      expect(jsonMap['specific_error'], isNull);
    });
    
    // Caso de prueba 4: toJson debería manejar listas nulas correctamente
    test('toJson should serialize null lists to empty lists', () {
      final response = UploadResponse(
        updatedPatients: null,
        problems: null,
      );

      final jsonMap = response.toJson();

      expect(jsonMap['updated_patients'], isEmpty);
      expect(jsonMap['problems'], isEmpty);
    });
    
    // Caso de prueba 5: copyWith debería actualizar los valores
    test('copyWith should create a new instance with updated values', () {
      final original = UploadResponse(
        file: 1,
        user: "user1",
        updatedPatients: ["p1"],
      );

      final updated = original.copyWith(
        file: 2,
        user: "user2",
        updatedPatients: ["p2", "p3"],
        problems: ["prob1"],
      );
      
      expect(updated.file, 2);
      expect(updated.user, "user2");
      expect(updated.updatedPatients, ["p2", "p3"]);
      expect(updated.problems, ["prob1"]);
      expect(updated.detail, isNull);
      
      expect(original, isNot(equals(updated)));
    });
  });
}