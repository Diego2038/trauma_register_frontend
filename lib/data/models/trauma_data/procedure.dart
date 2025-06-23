class Procedure {
  final int? id;
  final String? procedimientoRealizado;
  final DateTime? fechaYHoraDeInicio;
  final DateTime? fechaYHoraDeTermino;
  final String? lugar;
  final int? traumaRegisterRecordId;

  Procedure({
    this.id,
    this.procedimientoRealizado,
    this.fechaYHoraDeInicio,
    this.fechaYHoraDeTermino,
    this.lugar,
    this.traumaRegisterRecordId,
  });

  Procedure copyWith({
    int? id,
    String? procedimientoRealizado,
    DateTime? fechaYHoraDeInicio,
    DateTime? fechaYHoraDeTermino,
    String? lugar,
    int? traumaRegisterRecordId,
  }) =>
      Procedure(
        id: id ?? this.id,
        procedimientoRealizado:
            procedimientoRealizado ?? this.procedimientoRealizado,
        fechaYHoraDeInicio: fechaYHoraDeInicio ?? this.fechaYHoraDeInicio,
        fechaYHoraDeTermino: fechaYHoraDeTermino ?? this.fechaYHoraDeTermino,
        lugar: lugar ?? this.lugar,
        traumaRegisterRecordId:
            traumaRegisterRecordId ?? this.traumaRegisterRecordId,
      );

  factory Procedure.fromJson(Map<String, dynamic> json) => Procedure(
        id: json["id"],
        procedimientoRealizado: json["procedimiento_realizado"],
        fechaYHoraDeInicio: json["fecha_y_hora_de_inicio"] == null
            ? null
            : DateTime.parse(json["fecha_y_hora_de_inicio"]),
        fechaYHoraDeTermino: json["fecha_y_hora_de_termino"] == null
            ? null
            : DateTime.parse(json["fecha_y_hora_de_termino"]),
        lugar: json["lugar"],
        traumaRegisterRecordId: json["trauma_register_record_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "procedimiento_realizado": procedimientoRealizado,
        "fecha_y_hora_de_inicio": fechaYHoraDeInicio?.toIso8601String(),
        "fecha_y_hora_de_termino": fechaYHoraDeTermino?.toIso8601String(),
        "lugar": lugar,
        "trauma_register_record_id": traumaRegisterRecordId,
      };
}
