import 'package:flutter_test/flutter_test.dart';
import 'package:trauma_register_frontend/data/models/stats/single_value_stats.dart';

void main() {
  group('SingleValueStats', () {
    // Caso de prueba para el método fromJson
    test('fromJson should parse JSON to SingleValueStats correctly', () {
      final Map<String, dynamic> jsonMap = {'data': 123.45};
      
      final stats = SingleValueStats.fromJson(jsonMap);

      expect(stats.data, 123.45);
    });

    // Caso de prueba para el método toJson
    test('toJson should serialize SingleValueStats to JSON correctly', () {
      final stats = SingleValueStats(data: 67.89);

      final jsonMap = stats.toJson();

      expect(jsonMap['data'], 67.89);
    });
    
    // Caso de prueba para el método copyWith
    test('copyWith should create a new instance with updated value', () {
      final originalStats = SingleValueStats(data: 100.0);
      final updatedStats = originalStats.copyWith(data: 200.0);
      
      expect(updatedStats.data, 200.0);
      expect(originalStats, isNot(equals(updatedStats)));
    });

    // Caso de prueba para campos nulos o inesperados
    test('fromJson should throw an exception for null or invalid data', () {
      final Map<String, dynamic> jsonMap = {'data': null};

      // Se espera que el constructor de fábrica lance una excepción
      // debido al operador '!' en `double.tryParse(...)!`
      expect(() => SingleValueStats.fromJson(jsonMap), throwsA(isA<TypeError>()));
    });
  });
}