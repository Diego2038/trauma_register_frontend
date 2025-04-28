class SingleValueStats {
  final double data;

  SingleValueStats({
    required this.data,
  });

  SingleValueStats copyWith({
    double? data,
  }) =>
      SingleValueStats(
        data: data ?? this.data,
      );

  factory SingleValueStats.fromJson(Map<String, dynamic> json) =>
      SingleValueStats(
        data: double.tryParse(json["data"].toString())!,
      );

  Map<String, dynamic> toJson() => {
        "data": data,
      };
}
