import 'dart:convert';

CustomHttpStatusResponse customHttpStatusResponseFromJson(String str) =>
    CustomHttpStatusResponse.fromJson(json.decode(str));

String customHttpStatusResponseToJson(CustomHttpStatusResponse data) =>
    json.encode(data.toJson());

class CustomHttpStatusResponse {
  final int? code;
  final bool? result;
  final String? message;

  CustomHttpStatusResponse({
    this.code,
    this.result,
    this.message,
  });

  CustomHttpStatusResponse copyWith({
    int? code,
    bool? result,
    String? message,
  }) =>
      CustomHttpStatusResponse(
        code: code ?? this.code,
        result: result ?? this.result,
        message: message ?? this.message,
      );

  factory CustomHttpStatusResponse.fromJson(Map<String, dynamic> json) =>
      CustomHttpStatusResponse(
        code: json["code"],
        result: json["result"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "result": result,
        "message": message,
      };
}
