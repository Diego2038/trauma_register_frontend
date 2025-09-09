import 'package:flutter_test/flutter_test.dart';
import 'package:trauma_register_frontend/data/models/stats/time_serie.dart';

void main() {
  group('DateDatum', () {
    test('fromJson should parse DateDatum correctly', () {
      final Map<String, dynamic> jsonMap = {
        "date": "2023-01-01",
        "count": 10,
      };

      final dateDatum = DateDatum.fromJson(jsonMap);

      expect(dateDatum.date, '2023-01-01');
      expect(dateDatum.count, 10);
    });

    test('toJson should serialize DateDatum correctly', () {
      final dateDatum = DateDatum(date: '2023-01-02', count: 25);
      final jsonMap = dateDatum.toJson();

      expect(jsonMap['date'], '2023-01-02');
      expect(jsonMap['count'], 25);
    });

    test('copyWith should create a new DateDatum instance with updated values', () {
      final originalDatum = DateDatum(date: '2023-01-01', count: 10);
      final updatedDatum = originalDatum.copyWith(count: 15);

      expect(updatedDatum.date, '2023-01-01');
      expect(updatedDatum.count, 15);
      expect(originalDatum, isNot(equals(updatedDatum)));
    });
  });

  group('TimeSeries', () {
    final List<Map<String, dynamic>> jsonData = [
      {"date": "2023-01-01", "count": 10},
      {"date": "2023-01-02", "count": 25},
    ];

    test('fromJson should parse TimeSeries with list of DateDatum correctly', () {
      final Map<String, dynamic> jsonMap = {
        "data": jsonData,
      };

      final timeSeries = TimeSeries.fromJson(jsonMap);

      expect(timeSeries.data.length, 2);
      expect(timeSeries.data.first.date, '2023-01-01');
      expect(timeSeries.data.first.count, 10);
      expect(timeSeries.data.last.date, '2023-01-02');
      expect(timeSeries.data.last.count, 25);
    });

    test('toJson should serialize TimeSeries with list of DateDatum correctly', () {
      final timeSeries = TimeSeries(
        data: [
          DateDatum(date: '2023-01-01', count: 10),
          DateDatum(date: '2023-01-02', count: 25),
        ],
      );

      final jsonMap = timeSeries.toJson();

      expect(jsonMap['data'], isA<List>());
      final serializedList = jsonMap['data'] as List;
      expect(serializedList.length, 2);
      expect(serializedList[0]['date'], '2023-01-01');
      expect(serializedList[0]['count'], 10);
      expect(serializedList[1]['date'], '2023-01-02');
      expect(serializedList[1]['count'], 25);
    });
    
    test('copyWith should create a new TimeSeries instance with updated data', () {
      final originalTimeSeries = TimeSeries(data: [DateDatum(date: '2023-01-01', count: 1)]);
      final newDatum = DateDatum(date: '2023-01-03', count: 2);
      final updatedTimeSeries = originalTimeSeries.copyWith(data: [newDatum]);

      expect(updatedTimeSeries.data.length, 1);
      expect(updatedTimeSeries.data.first.date, '2023-01-03');
      expect(updatedTimeSeries.data.first.count, 2);
      
      // Verificamos que no sean la misma instancia
      expect(originalTimeSeries, isNot(equals(updatedTimeSeries)));
    });
  });
}