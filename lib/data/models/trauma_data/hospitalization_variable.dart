class HospitalizationVariable {
  final int? id;
  final String? tipoDeVariable;
  final String? valorDeLaVariable;
  final DateTime? fechaYHoraDeLaVariable;
  final String? localizacionDeVariable;
  final int? traumaRegisterRecordId;

  HospitalizationVariable({
    this.id,
    this.tipoDeVariable,
    this.valorDeLaVariable,
    this.fechaYHoraDeLaVariable,
    this.localizacionDeVariable,
    this.traumaRegisterRecordId,
  });

  HospitalizationVariable copyWith({
    int? id,
    String? tipoDeVariable,
    String? valorDeLaVariable,
    DateTime? fechaYHoraDeLaVariable,
    String? localizacionDeVariable,
    int? traumaRegisterRecordId,
  }) =>
      HospitalizationVariable(
        id: id ?? this.id,
        tipoDeVariable: tipoDeVariable ?? this.tipoDeVariable,
        valorDeLaVariable: valorDeLaVariable ?? this.valorDeLaVariable,
        fechaYHoraDeLaVariable:
            fechaYHoraDeLaVariable ?? this.fechaYHoraDeLaVariable,
        localizacionDeVariable:
            localizacionDeVariable ?? this.localizacionDeVariable,
        traumaRegisterRecordId:
            traumaRegisterRecordId ?? this.traumaRegisterRecordId,
      );

  factory HospitalizationVariable.fromJson(Map<String, dynamic> json) =>
      HospitalizationVariable(
        id: json["id"],
        tipoDeVariable: json["tipo_de_variable"],
        valorDeLaVariable: json["valor_de_la_variable"],
        fechaYHoraDeLaVariable: json["fecha_y_hora_de_la_variable"] == null
            ? null
            : DateTime.parse(json["fecha_y_hora_de_la_variable"]),
        localizacionDeVariable: json["localizacion_de_variable"],
        traumaRegisterRecordId: json["trauma_register_record_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_de_variable": tipoDeVariable,
        "valor_de_la_variable": valorDeLaVariable,
        "fecha_y_hora_de_la_variable":
            fechaYHoraDeLaVariable?.toIso8601String(),
        "localizacion_de_variable": localizacionDeVariable,
        "trauma_register_record_id": traumaRegisterRecordId,
      };
}
