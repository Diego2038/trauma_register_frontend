class PrehospitalProcedure {
  final int? id;
  final String? procedimientoRealizado;

  PrehospitalProcedure({
    this.id,
    this.procedimientoRealizado,
  });

  PrehospitalProcedure copyWith({
    int? id,
    String? procedimientoRealizado,
  }) =>
      PrehospitalProcedure(
        id: id ?? this.id,
        procedimientoRealizado:
            procedimientoRealizado ?? this.procedimientoRealizado,
      );

  factory PrehospitalProcedure.fromJson(Map<String, dynamic> json) =>
      PrehospitalProcedure(
        id: json["id"],
        procedimientoRealizado: json["procedimiento_realizado"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "procedimiento_realizado": procedimientoRealizado,
      };
}
