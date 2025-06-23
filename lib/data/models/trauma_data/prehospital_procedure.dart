class PrehospitalProcedure {
  final int? id;
  final String? procedimientoRealizado;
  final int? traumaRegisterRecordId;

  PrehospitalProcedure({
    this.id,
    this.procedimientoRealizado,
    this.traumaRegisterRecordId,
  });

  PrehospitalProcedure copyWith({
    int? id,
    String? procedimientoRealizado,
    int? traumaRegisterRecordId,
  }) =>
      PrehospitalProcedure(
        id: id ?? this.id,
        procedimientoRealizado:
            procedimientoRealizado ?? this.procedimientoRealizado,
        traumaRegisterRecordId:
            traumaRegisterRecordId ?? this.traumaRegisterRecordId,
      );

  factory PrehospitalProcedure.fromJson(Map<String, dynamic> json) =>
      PrehospitalProcedure(
        id: json["id"],
        procedimientoRealizado: json["procedimiento_realizado"],
        traumaRegisterRecordId: json["trauma_register_record_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "procedimiento_realizado": procedimientoRealizado,
        "trauma_register_record_id": traumaRegisterRecordId,
      };
}
