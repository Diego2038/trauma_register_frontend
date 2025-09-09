import 'package:flutter_test/flutter_test.dart';
import 'package:trauma_register_frontend/data/models/shared/optional.dart';

void main() {
  group('Optional', () {
    // Caso de prueba para un valor presente
    test('of constructor should create an Optional with a present value', () {
      const String testValue = 'hello';
      const Optional<String> optional = Optional.of(testValue);

      expect(optional.isPresent, isTrue);
      expect(optional.value, equals(testValue));
      expect(optional.value, isNotNull);
    });

    // Caso de prueba para un valor ausente
    test('absent constructor should create an Optional with an absent value', () {
      const Optional<String> optional = Optional.absent();

      expect(optional.isPresent, isFalse);
      expect(optional.value, isNull);
    });

    // Caso de prueba adicional: null en 'of'
    test('of constructor should handle null value correctly', () {
      const Optional<String?> optional = Optional.of(null);
      
      // A pesar de que el valor es null, Optional.of indica que el valor "está presente"
      // Es una característica de esta implementación.
      expect(optional.isPresent, isTrue); 
      expect(optional.value, isNull);
    });
  });
}