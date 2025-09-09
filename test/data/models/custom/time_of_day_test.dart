import 'package:flutter_test/flutter_test.dart';
import 'package:trauma_register_frontend/data/models/custom/time_of_day.dart';

void main() {
  group('TimeOfDay', () {
    test('crea instancia válida con hora, minuto y segundo', () {
      final time = TimeOfDay(hour: 10, minute: 30, second: 45);

      expect(time.hour, 10);
      expect(time.minute, 30);
      expect(time.second, 45);
    });

    test('lanza AssertionError si la hora es inválida', () {
      expect(() => TimeOfDay(hour: -1, minute: 0), throwsAssertionError);
      expect(() => TimeOfDay(hour: 24, minute: 0), throwsAssertionError);
    });

    test('lanza AssertionError si el minuto es inválido', () {
      expect(() => TimeOfDay(hour: 10, minute: -1), throwsAssertionError);
      expect(() => TimeOfDay(hour: 10, minute: 60), throwsAssertionError);
    });

    test('lanza AssertionError si el segundo es inválido', () {
      expect(() => TimeOfDay(hour: 10, minute: 30, second: -1), throwsAssertionError);
      expect(() => TimeOfDay(hour: 10, minute: 30, second: 60), throwsAssertionError);
    });

    group('fromString', () {
      test('parsea correctamente HH:MM', () {
        final time = TimeOfDay.fromString("08:15");

        expect(time.hour, 8);
        expect(time.minute, 15);
        expect(time.second, 0);
      });

      test('parsea correctamente HH:MM:SS', () {
        final time = TimeOfDay.fromString("23:59:58");

        expect(time.hour, 23);
        expect(time.minute, 59);
        expect(time.second, 58);
      });

      test('lanza FormatException para formato inválido', () {
        expect(() => TimeOfDay.fromString("99:99"), throwsFormatException);
        expect(() => TimeOfDay.fromString("12:61"), throwsFormatException);
        expect(() => TimeOfDay.fromString("12:30:99"), throwsFormatException);
        expect(() => TimeOfDay.fromString("abc"), throwsFormatException);
        expect(() => TimeOfDay.fromString("12"), throwsFormatException);
        expect(() => TimeOfDay.fromString("12:30:45:00"), throwsFormatException);
      });
    });

    test('toString devuelve formato con ceros a la izquierda', () {
      final time = TimeOfDay(hour: 5, minute: 7, second: 9);

      expect(time.toString(), "05:07:09");
    });

    test('== devuelve true para instancias iguales', () {
      final t1 = TimeOfDay(hour: 12, minute: 30, second: 15);
      final t2 = TimeOfDay(hour: 12, minute: 30, second: 15);

      expect(t1, equals(t2));
      expect(t1.hashCode, equals(t2.hashCode));
    });

    test('== devuelve false para instancias diferentes', () {
      final t1 = TimeOfDay(hour: 12, minute: 30, second: 15);
      final t2 = TimeOfDay(hour: 12, minute: 31, second: 15);

      expect(t1 == t2, false);
    });

    group('compareTo', () {
      test('devuelve 0 si las horas son iguales', () {
        final t1 = TimeOfDay(hour: 8, minute: 15, second: 30);
        final t2 = TimeOfDay(hour: 8, minute: 15, second: 30);

        expect(t1.compareTo(t2), 0);
      });

      test('devuelve negativo si la hora es menor', () {
        final t1 = TimeOfDay(hour: 7, minute: 59);
        final t2 = TimeOfDay(hour: 8, minute: 0);

        expect(t1.compareTo(t2), lessThan(0));
      });

      test('devuelve positivo si la hora es mayor', () {
        final t1 = TimeOfDay(hour: 10, minute: 0);
        final t2 = TimeOfDay(hour: 9, minute: 59);

        expect(t1.compareTo(t2), greaterThan(0));
      });

      test('compara correctamente por minutos', () {
        final t1 = TimeOfDay(hour: 10, minute: 15);
        final t2 = TimeOfDay(hour: 10, minute: 20);

        expect(t1.compareTo(t2), lessThan(0));
      });

      test('compara correctamente por segundos', () {
        final t1 = TimeOfDay(hour: 10, minute: 20, second: 10);
        final t2 = TimeOfDay(hour: 10, minute: 20, second: 30);

        expect(t1.compareTo(t2), lessThan(0));
      });
    });
  });
}
