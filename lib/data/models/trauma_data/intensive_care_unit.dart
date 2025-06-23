class IntensiveCareUnit {
  final int? id;
  final String? tipo;
  final DateTime? fechaYHoraDeInicio;
  final DateTime? fechaYHoraDeTermino;
  final String? lugar;
  final double? icuDays;
  final int? traumaRegisterRecordId;

  IntensiveCareUnit({
    this.id,
    this.tipo,
    this.fechaYHoraDeInicio,
    this.fechaYHoraDeTermino,
    this.lugar,
    this.icuDays,
    this.traumaRegisterRecordId,
  });

  IntensiveCareUnit copyWith({
    int? id,
    String? tipo,
    DateTime? fechaYHoraDeInicio,
    DateTime? fechaYHoraDeTermino,
    String? lugar,
    double? icuDays,
    int? traumaRegisterRecordId,
  }) =>
      IntensiveCareUnit(
        id: id ?? this.id,
        tipo: tipo ?? this.tipo,
        fechaYHoraDeInicio: fechaYHoraDeInicio ?? this.fechaYHoraDeInicio,
        fechaYHoraDeTermino: fechaYHoraDeTermino ?? this.fechaYHoraDeTermino,
        lugar: lugar ?? this.lugar,
        icuDays: icuDays ?? this.icuDays,
        traumaRegisterRecordId:
            traumaRegisterRecordId ?? this.traumaRegisterRecordId,
      );

  factory IntensiveCareUnit.fromJson(Map<String, dynamic> json) =>
      IntensiveCareUnit(
        id: json["id"],
        tipo: json["tipo"],
        fechaYHoraDeInicio: json["fecha_y_hora_de_inicio"] == null
            ? null
            : DateTime.parse(json["fecha_y_hora_de_inicio"]),
        fechaYHoraDeTermino: json["fecha_y_hora_de_termino"] == null
            ? null
            : DateTime.parse(json["fecha_y_hora_de_termino"]),
        lugar: json["lugar"],
        icuDays: double.tryParse(json["icu_days"].toString()),
        traumaRegisterRecordId: json["trauma_register_record_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "fecha_y_hora_de_inicio": fechaYHoraDeInicio?.toIso8601String(),
        "fecha_y_hora_de_termino": fechaYHoraDeTermino?.toIso8601String(),
        "lugar": lugar,
        "icu_days": icuDays,
        "trauma_register_record_id": traumaRegisterRecordId,
      };
}
