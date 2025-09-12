import 'package:flutter_test/flutter_test.dart';
import 'package:trauma_register_frontend/core/helpers/interpolate.dart';

void main() {
  group('Interpolate', () {
    // Prueba básica de interpolación lineal
    test('should correctly interpolate a value within the range', () {
      final result = Interpolate.interpolate(
        xMin: 0.0,
        xMax: 10.0,
        yMin: 0.0,
        yMax: 100.0,
        x: 5.0,
      );
      expect(result, 50.0);
    });

    // Prueba para el punto mínimo (x <= xMin)
    test('should return yMin when x is less than or equal to xMin', () {
      final result1 = Interpolate.interpolate(
        xMin: 10.0,
        xMax: 20.0,
        yMin: 50.0,
        yMax: 100.0,
        x: 5.0, // x es menor que xMin
      );
      expect(result1, 50.0);

      final result2 = Interpolate.interpolate(
        xMin: 10.0,
        xMax: 20.0,
        yMin: 50.0,
        yMax: 100.0,
        x: 10.0, // x es igual a xMin
      );
      expect(result2, 50.0);
    });

    // Prueba para el punto máximo (x >= xMax)
    test('should return yMax when x is greater than or equal to xMax', () {
      final result1 = Interpolate.interpolate(
        xMin: 10.0,
        xMax: 20.0,
        yMin: 50.0,
        yMax: 100.0,
        x: 25.0, // x es mayor que xMax
      );
      expect(result1, 100.0);

      final result2 = Interpolate.interpolate(
        xMin: 10.0,
        xMax: 20.0,
        yMin: 50.0,
        yMax: 100.0,
        x: 20.0, // x es igual a xMax
      );
      expect(result2, 100.0);
    });

    // Prueba con valores negativos
    test('should work correctly with negative values', () {
      final result = Interpolate.interpolate(
        xMin: -10.0,
        xMax: 10.0,
        yMin: -100.0,
        yMax: 100.0,
        x: 0.0,
      );
      expect(result, 0.0);
    });

    // Prueba con un rango de y invertido (yMax < yMin)
    test('should work correctly with inverted y range', () {
      final result = Interpolate.interpolate(
        xMin: 0.0,
        xMax: 10.0,
        yMin: 100.0,
        yMax: 0.0,
        x: 5.0,
      );
      expect(result, 50.0);
    });

    // Prueba con una interpolación más compleja
    test('should correctly handle a non-zero start point', () {
      final result = Interpolate.interpolate(
        xMin: 10.0,
        xMax: 30.0,
        yMin: 20.0,
        yMax: 60.0,
        x: 20.0,
      );
      expect(result, 40.0);
    });

    // Prueba de valores flotantes con mayor precisión
    test('should handle floating point values with precision', () {
      final result = Interpolate.interpolate(
        xMin: 0.0,
        xMax: 1.0,
        yMin: 0.0,
        yMax: 100.0,
        x: 0.25,
      );
      expect(result, 25.0);
    });
  });
}
