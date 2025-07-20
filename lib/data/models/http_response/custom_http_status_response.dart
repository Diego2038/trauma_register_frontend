import 'dart:convert';

CustomHttpStatusResponse customHttpStatusResponseFromJson(String str) =>
    CustomHttpStatusResponse.fromJson(json.decode(str));

String customHttpStatusResponseToJson(CustomHttpStatusResponse data) =>
    json.encode(data.toJson());

class CustomHttpStatusResponse {
  final int? code;
  final bool? result;
  final String? message;
  final int? idElement;

  CustomHttpStatusResponse({
    this.code,
    this.result,
    this.message,
    this.idElement,
  });

  CustomHttpStatusResponse copyWith({
    int? code,
    bool? result,
    String? message,
    int? idElement,
  }) =>
      CustomHttpStatusResponse(
        code: code ?? this.code,
        result: result ?? this.result,
        message: message ?? this.message,
        idElement: idElement ?? this.idElement,
      );

  factory CustomHttpStatusResponse.fromJson(Map<String, dynamic> json) =>
      CustomHttpStatusResponse(
        code: json["code"],
        result: json["result"],
        message: json["message"],
        idElement: json["idElement"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "result": result,
        "message": message,
        "idElement": idElement,
      };
}
