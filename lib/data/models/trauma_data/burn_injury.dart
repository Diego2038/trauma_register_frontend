class BurnInjury {
  final int? id;
  final String? tipoDeQuemadura;
  final String? gradoDeQuemadura;
  final int? traumaRegisterRecordId;

  BurnInjury({
    this.id,
    this.tipoDeQuemadura,
    this.gradoDeQuemadura,
    this.traumaRegisterRecordId,
  });

  BurnInjury copyWith({
    int? id,
    String? tipoDeQuemadura,
    String? gradoDeQuemadura,
    int? traumaRegisterRecordId,
  }) =>
      BurnInjury(
        id: id ?? this.id,
        tipoDeQuemadura: tipoDeQuemadura ?? this.tipoDeQuemadura,
        gradoDeQuemadura: gradoDeQuemadura ?? this.gradoDeQuemadura,
        traumaRegisterRecordId:
            traumaRegisterRecordId ?? this.traumaRegisterRecordId,
      );

  factory BurnInjury.fromJson(Map<String, dynamic> json) => BurnInjury(
        id: json["id"],
        tipoDeQuemadura: json["tipo_de_quemadura"],
        gradoDeQuemadura: json["grado_de_quemadura"],
        traumaRegisterRecordId: json["trauma_register_record_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_de_quemadura": tipoDeQuemadura,
        "grado_de_quemadura": gradoDeQuemadura,
        "trauma_register_record_id": traumaRegisterRecordId,
      };
}
