import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:trauma_register_frontend/core/helpers/transform_data.dart';
import 'package:trauma_register_frontend/data/models/custom/time_of_day.dart';

void main() {
  group('TransformData.getTransformedValue', () {
    test('devuelve String válido', () {
      final result = TransformData.getTransformedValue<String>("Hola");
      expect(result, "Hola");
    });

    test('devuelve null si String vacío o null', () {
      expect(TransformData.getTransformedValue<String>(""), isNull);
      expect(TransformData.getTransformedValue<String>(null), isNull);
    });

    test('devuelve int válido', () {
      final result = TransformData.getTransformedValue<int>("123");
      expect(result, 123);
    });

    test('devuelve null si int inválido o vacío', () {
      expect(TransformData.getTransformedValue<int>("abc"), isNull);
      expect(TransformData.getTransformedValue<int>(""), isNull);
      expect(TransformData.getTransformedValue<int>(null), isNull);
    });

    test('devuelve double válido', () {
      final result = TransformData.getTransformedValue<double>("3.14");
      expect(result, 3.14);
    });

    test('devuelve null si double inválido o vacío', () {
      expect(TransformData.getTransformedValue<double>("abc"), isNull);
      expect(TransformData.getTransformedValue<double>(""), isNull);
      expect(TransformData.getTransformedValue<double>(null), isNull);
    });

    test('devuelve bool válido con "sí" o "si"', () {
      expect(TransformData.getTransformedValue<bool>("sí"), isTrue);
      expect(TransformData.getTransformedValue<bool>("si"), isTrue);
      expect(TransformData.getTransformedValue<bool>("SI"), isTrue);
    });

    test('devuelve bool válido con "no"', () {
      expect(TransformData.getTransformedValue<bool>("no"), isFalse);
      expect(TransformData.getTransformedValue<bool>("NO"), isFalse);
    });

    test('devuelve null si bool inválido o vacío', () {
      expect(TransformData.getTransformedValue<bool>("maybe"), isNull);
      expect(TransformData.getTransformedValue<bool>(""), isNull);
      expect(TransformData.getTransformedValue<bool>(null), isNull);
    });

    test('devuelve DateTime válido (solo fecha)', () {
      final result = TransformData.getTransformedValue<DateTime>("01/01/2023");
      expect(result, DateFormat("dd/MM/yyyy").parse("01/01/2023"));
    });

    test('devuelve DateTime válido (fecha y hora)', () {
      final result = TransformData.getTransformedValue<DateTime>("01/01/2023 12:30:45");
      expect(result, DateFormat("dd/MM/yyyy HH:mm:ss").parse("01/01/2023 12:30:45"));
    });

    test('devuelve null si DateTime inválido o vacío', () {
      expect(TransformData.getTransformedValue<DateTime>(""), isNull);
      expect(TransformData.getTransformedValue<DateTime>(null), isNull);
    });

    test('devuelve TimeOfDay válido', () {
      final result = TransformData.getTransformedValue<TimeOfDay>("12:30");
      expect(result, isA<TimeOfDay>());
      expect(result!.hour, 12);
      expect(result.minute, 30);
    });

    test('devuelve null si TimeOfDay inválido o vacío', () {
      expect(TransformData.getTransformedValue<TimeOfDay>("25:00"), isNull);
      expect(TransformData.getTransformedValue<TimeOfDay>(""), isNull);
      expect(TransformData.getTransformedValue<TimeOfDay>(null), isNull);
    });

    test('devuelve null si tipo no soportado', () {
      final result = TransformData.getTransformedValue<List>("algo");
      expect(result, isNull);
    });
  });
}
