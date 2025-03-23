class CustomHttpResponse {
    final dynamic data;
    final int? statusCode;
    final String? statusMessage;

    CustomHttpResponse({
        required this.data,
        required this.statusCode,
        required this.statusMessage,
    });

    CustomHttpResponse copyWith({
        dynamic data,
        int? statusCode,
        String? statusMessage,
    }) => 
        CustomHttpResponse(
            data: data ?? this.data,
            statusCode: statusCode ?? this.statusCode,
            statusMessage: statusMessage ?? this.statusMessage,
        );

    factory CustomHttpResponse.fromJson(Map<String, dynamic> json) => CustomHttpResponse(
        data: json["data"],
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "statusCode": statusCode,
        "statusMessage": statusMessage,
    };
}