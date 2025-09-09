import 'package:flutter_test/flutter_test.dart';
import 'package:trauma_register_frontend/data/models/http_response/custom_http_status_response.dart';

void main() {
  group('CustomHttpStatusResponse', () {
    // 1. Caso de prueba para una respuesta exitosa y completa
    test('fromJson should correctly parse all fields', () {
      final Map<String, dynamic> jsonMap = {
        "code": 200,
        "result": true,
        "message": "Operación exitosa",
        "idElement": 123,
      };

      final CustomHttpStatusResponse response = CustomHttpStatusResponse.fromJson(jsonMap);

      expect(response.code, 200);
      expect(response.result, true);
      expect(response.message, "Operación exitosa");
      expect(response.idElement, 123);
    });

    // 2. Caso de prueba para campos nulos
    test('fromJson should handle null fields gracefully', () {
      final Map<String, dynamic> jsonMap = {
        "code": 404,
        "result": false,
        "message": "Elemento no encontrado",
        "idElement": null,
      };

      final CustomHttpStatusResponse response = CustomHttpStatusResponse.fromJson(jsonMap);

      expect(response.code, 404);
      expect(response.result, false);
      expect(response.message, "Elemento no encontrado");
      expect(response.idElement, isNull);
    });

    // 3. Caso de prueba para el método toJson
    test('toJson should correctly serialize the object', () {
      final CustomHttpStatusResponse response = CustomHttpStatusResponse(
        code: 201,
        result: true,
        message: "Creado",
        idElement: 456,
      );

      final Map<String, dynamic> jsonMap = response.toJson();

      expect(jsonMap["code"], 201);
      expect(jsonMap["result"], true);
      expect(jsonMap["message"], "Creado");
      expect(jsonMap["idElement"], 456);
    });

    // 4. Caso de prueba para la función auxiliar customHttpStatusResponseFromJson
    test('customHttpStatusResponseFromJson should parse JSON string', () {
      const jsonString = '{"code": 200, "result": true, "message": "Datos obtenidos", "idElement": 789}';

      final response = customHttpStatusResponseFromJson(jsonString);

      expect(response.code, 200);
      expect(response.result, true);
      expect(response.message, "Datos obtenidos");
      expect(response.idElement, 789);
    });
    
    // 5. Caso de prueba para la función auxiliar customHttpStatusResponseToJson
    test('customHttpStatusResponseToJson should encode to JSON string', () {
      final response = CustomHttpStatusResponse(
        code: 200,
        result: true,
        message: "Datos obtenidos",
        idElement: 789,
      );

      final jsonString = customHttpStatusResponseToJson(response);

      const expectedString = '{"code":200,"result":true,"message":"Datos obtenidos","idElement":789}';
      expect(jsonString, expectedString);
    });

    // 6. Caso de prueba para el método copyWith
    test('copyWith should create a new instance with updated values', () {
      final originalResponse = CustomHttpStatusResponse(
        code: 200,
        result: true,
        message: "Original",
        idElement: 1,
      );

      final updatedResponse = originalResponse.copyWith(
        message: "Actualizado",
        idElement: 2,
      );

      expect(updatedResponse.code, 200); // No debería cambiar
      expect(updatedResponse.result, true); // No debería cambiar
      expect(updatedResponse.message, "Actualizado"); // Debería cambiar
      expect(updatedResponse.idElement, 2); // Debería cambiar
      
      // Aseguramos que es una nueva instancia, no la misma
      expect(originalResponse, isNot(equals(updatedResponse)));
    });
  });
}