class CategoricalStats {
  final List<Datum> data;

  CategoricalStats({
    required this.data,
  });

  CategoricalStats copyWith({
    List<Datum>? data,
  }) =>
      CategoricalStats(
        data: data ?? this.data,
      );

  factory CategoricalStats.fromJson(Map<String, dynamic> json) =>
      CategoricalStats(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final String tag;
  final double total;

  Datum({
    required this.tag,
    required this.total,
  });

  Datum copyWith({
    String? tag,
    double? total,
  }) =>
      Datum(
        tag: tag ?? this.tag,
        total: total ?? this.total,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        tag: json["tag"],
        total: double.tryParse(json["total"].toString())!,
      );

  Map<String, dynamic> toJson() => {
        "tag": tag,
        "total": total,
      };
}
