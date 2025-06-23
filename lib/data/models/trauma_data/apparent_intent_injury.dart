class ApparentIntentInjury {
  final int? id;
  final String? intencionAparente;

  ApparentIntentInjury({
    this.id,
    this.intencionAparente,
  });

  ApparentIntentInjury copyWith({
    int? id,
    String? intencionAparente,
  }) =>
      ApparentIntentInjury(
        id: id ?? this.id,
        intencionAparente: intencionAparente ?? this.intencionAparente,
      );

  factory ApparentIntentInjury.fromJson(Map<String, dynamic> json) =>
      ApparentIntentInjury(
        id: json["id"],
        intencionAparente: json["intencion_aparente"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "intencion_aparente": intencionAparente,
      };
}
