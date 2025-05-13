class TimeSeries {
  final List<DateDatum> data;

  TimeSeries({
    required this.data,
  });

  TimeSeries copyWith({
    List<DateDatum>? data,
  }) =>
      TimeSeries(
        data: data ?? this.data,
      );

  factory TimeSeries.fromJson(Map<String, dynamic> json) => TimeSeries(
        data: List<DateDatum>.from(
            json["data"].map((x) => DateDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DateDatum {
  final String date;
  final int count;

  DateDatum({
    required this.date,
    required this.count,
  });

  DateDatum copyWith({
    String? date,
    int? count,
  }) =>
      DateDatum(
        date: date ?? this.date,
        count: count ?? this.count,
      );

  factory DateDatum.fromJson(Map<String, dynamic> json) => DateDatum(
        date: json["date"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "count": count,
      };
}
