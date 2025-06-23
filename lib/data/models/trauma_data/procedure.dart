class Procedure {
  final int? id;
  final String? procedimientoRealizado;
  final DateTime? fechaYHoraDeInicio;
  final DateTime? fechaYHoraDeTermino;
  final String? lugar;

  Procedure({
    this.id,
    this.procedimientoRealizado,
    this.fechaYHoraDeInicio,
    this.fechaYHoraDeTermino,
    this.lugar,
  });

  Procedure copyWith({
    int? id,
    String? procedimientoRealizado,
    DateTime? fechaYHoraDeInicio,
    DateTime? fechaYHoraDeTermino,
    String? lugar,
  }) =>
      Procedure(
        id: id ?? this.id,
        procedimientoRealizado:
            procedimientoRealizado ?? this.procedimientoRealizado,
        fechaYHoraDeInicio: fechaYHoraDeInicio ?? this.fechaYHoraDeInicio,
        fechaYHoraDeTermino: fechaYHoraDeTermino ?? this.fechaYHoraDeTermino,
        lugar: lugar ?? this.lugar,
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "procedimiento_realizado": procedimientoRealizado,
        "fecha_y_hora_de_inicio": fechaYHoraDeInicio?.toIso8601String(),
        "fecha_y_hora_de_termino": fechaYHoraDeTermino?.toIso8601String(),
        "lugar": lugar,
      };
}
