class PhysicalExamBodyPartInjury {
  final int? id;
  final String? parteDelCuerpo;
  final String? tipoDeLesion;

  PhysicalExamBodyPartInjury({
    this.id,
    this.parteDelCuerpo,
    this.tipoDeLesion,
  });

  PhysicalExamBodyPartInjury copyWith({
    int? id,
    String? parteDelCuerpo,
    String? tipoDeLesion,
  }) =>
      PhysicalExamBodyPartInjury(
        id: id ?? this.id,
        parteDelCuerpo: parteDelCuerpo ?? this.parteDelCuerpo,
        tipoDeLesion: tipoDeLesion ?? this.tipoDeLesion,
      );

  factory PhysicalExamBodyPartInjury.fromJson(Map<String, dynamic> json) =>
      PhysicalExamBodyPartInjury(
        id: json["id"],
        parteDelCuerpo: json["parte_del_cuerpo"],
        tipoDeLesion: json["tipo_de_lesion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parte_del_cuerpo": parteDelCuerpo,
        "tipo_de_lesion": tipoDeLesion,
      };
}
