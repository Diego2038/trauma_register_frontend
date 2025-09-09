import 'package:flutter_test/flutter_test.dart';
import 'package:trauma_register_frontend/data/models/stats/categorical_stats.dart';

void main() {
  group('Datum', () {
    test('fromJson should parse Datum correctly', () {
      final Map<String, dynamic> jsonMap = {
        "tag": "male",
        "total": 50,
      };

      final datum = Datum.fromJson(jsonMap);

      expect(datum.tag, 'male');
      expect(datum.total, 50.0);
    });

    test('toJson should serialize Datum correctly', () {
      final datum = Datum(tag: 'female', total: 75.5);
      final jsonMap = datum.toJson();

      expect(jsonMap['tag'], 'female');
      expect(jsonMap['total'], 75.5);
    });

    test('copyWith should create a new Datum instance with updated values', () {
      final originalDatum = Datum(tag: 'original', total: 10.0);
      final updatedDatum = originalDatum.copyWith(tag: 'updated');

      expect(updatedDatum.tag, 'updated');
      expect(updatedDatum.total, 10.0);
      expect(originalDatum, isNot(equals(updatedDatum)));
    });
  });

  group('CategoricalStats', () {
    final List<Map<String, dynamic>> jsonData = [
      {"tag": "male", "total": 50},
      {"tag": "female", "total": 75.5},
    ];

    test('fromJson should parse CategoricalStats with list of Datum correctly', () {
      final Map<String, dynamic> jsonMap = {
        "data": jsonData,
      };

      final stats = CategoricalStats.fromJson(jsonMap);

      expect(stats.data.length, 2);
      expect(stats.data.first.tag, 'male');
      expect(stats.data.first.total, 50.0);
      expect(stats.data.last.tag, 'female');
      expect(stats.data.last.total, 75.5);
    });

    test('toJson should serialize CategoricalStats with list of Datum correctly', () {
      final stats = CategoricalStats(
        data: [
          Datum(tag: 'male', total: 50.0),
          Datum(tag: 'female', total: 75.5),
        ],
      );

      final jsonMap = stats.toJson();

      expect(jsonMap['data'], isA<List>());
      final serializedList = jsonMap['data'] as List;
      expect(serializedList.length, 2);
      expect(serializedList[0]['tag'], 'male');
      expect(serializedList[0]['total'], 50.0);
      expect(serializedList[1]['tag'], 'female');
      expect(serializedList[1]['total'], 75.5);
    });
    
    test('copyWith should create a new CategoricalStats instance with updated data', () {
      final originalStats = CategoricalStats(data: [Datum(tag: 'old', total: 1.0)]);
      final newDatum = Datum(tag: 'new', total: 2.0);
      final updatedStats = originalStats.copyWith(data: [newDatum]);

      expect(updatedStats.data.length, 1);
      expect(updatedStats.data.first.tag, 'new');
      expect(updatedStats.data.first.total, 2.0);
      
      // Verificamos que no sean la misma instancia
      expect(originalStats, isNot(equals(updatedStats)));
    });
  });
}