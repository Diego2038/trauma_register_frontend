import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:trauma_register_frontend/core/helpers/print_error.dart';

void main() {
  group('PrintError.makePrint', () {
    test('imprime error sin stacktrace', () {
      final logs = <String>[];

      // Capturar prints dentro de esta zona
      runZoned(() {
        PrintError.makePrint(
          e: Exception("Algo salió mal"),
          ubication: "TestCase1",
        );
      }, zoneSpecification: ZoneSpecification(
        print: (self, parent, zone, line) {
          logs.add(line);
        },
      ));

      // Validar que algo se imprimió
      expect(logs.isNotEmpty, true);
      expect(logs.first, contains("ERROR:"));
      expect(logs.first, contains("Ubication: TestCase1"));
      expect(logs.first, contains("Exception"));
    });

    test('imprime error con stacktrace', () {
      final logs = <String>[];

      runZoned(() {
        PrintError.makePrint(
          e: "Error de prueba",
          stack: StackTrace.current,
          ubication: "TestCase2",
        );
      }, zoneSpecification: ZoneSpecification(
        print: (self, parent, zone, line) {
          logs.add(line);
        },
      ));

      expect(logs.length, greaterThan(1));
      expect(logs.first, contains("Ubication: TestCase2"));
      expect(logs.last, contains("ERROR STACK:"));
    });
  });
}
