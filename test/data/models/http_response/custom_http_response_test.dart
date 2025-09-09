import 'package:flutter_test/flutter_test.dart';
import 'package:trauma_register_frontend/data/models/http_response/custom_http_response.dart'; // Ajusta la ruta según tu proyecto

class DummyData {
  final String value;
  DummyData(this.value);

  Map<String, dynamic> toJson() => {'value': value};
}

void main() {
  group('CustomHttpResponse', () {
    test('crea instancia correctamente', () {
      final response = CustomHttpResponse(
        data: "ok",
        statusCode: 200,
        statusMessage: "success",
      );

      expect(response.data, "ok");
      expect(response.statusCode, 200);
      expect(response.statusMessage, "success");
    });

    group('copyWith', () {
      final response = CustomHttpResponse(
        data: "data",
        statusCode: 400,
        statusMessage: "error",
      );

      test('sobrescribe data', () {
        final copy = response.copyWith(data: "newData");

        expect(copy.data, "newData");
        expect(copy.statusCode, 400);
        expect(copy.statusMessage, "error");
      });

      test('sobrescribe statusCode', () {
        final copy = response.copyWith(statusCode: 500);

        expect(copy.data, "data");
        expect(copy.statusCode, 500);
        expect(copy.statusMessage, "error");
      });

      test('sobrescribe statusMessage', () {
        final copy = response.copyWith(statusMessage: "fatal");

        expect(copy.data, "data");
        expect(copy.statusCode, 400);
        expect(copy.statusMessage, "fatal");
      });

      test('mantiene valores si no se sobrescriben', () {
        final copy = response.copyWith();

        expect(copy.data, "data");
        expect(copy.statusCode, 400);
        expect(copy.statusMessage, "error");
      });
    });

    group('fromJson', () {
      test('crea instancia desde json válido', () {
        final json = {
          "data": "payload",
          "statusCode": 201,
          "statusMessage": "created",
        };

        final response = CustomHttpResponse.fromJson(json);

        expect(response.data, "payload");
        expect(response.statusCode, 201);
        expect(response.statusMessage, "created");
      });

      test('acepta data como null', () {
        final json = {
          "data": null,
          "statusCode": 204,
          "statusMessage": "no content",
        };

        final response = CustomHttpResponse.fromJson(json);

        expect(response.data, null);
        expect(response.statusCode, 204);
        expect(response.statusMessage, "no content");
      });
    });

    group('toJson', () {
      test('serializa correctamente si data tiene toJson', () {
        final response = CustomHttpResponse(
          data: DummyData("abc"),
          statusCode: 200,
          statusMessage: "ok",
        );

        final json = response.toJson();

        expect(json["data"], {"value": "abc"});
        expect(json["statusCode"], 200);
        expect(json["statusMessage"], "ok");
      });

      test('lanza error si data no tiene toJson', () {
        final response = CustomHttpResponse(
          data: "string",
          statusCode: 200,
          statusMessage: "ok",
        );

        expect(() => response.toJson(), throwsNoSuchMethodError);
      });
    });
  });
}
