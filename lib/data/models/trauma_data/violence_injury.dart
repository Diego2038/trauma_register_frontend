class ViolenceInjury {
  final int? id;
  final String? tipoDeViolencia;
  final int? traumaRegisterRecordId;

  ViolenceInjury({
    this.id,
    this.tipoDeViolencia,
    this.traumaRegisterRecordId,
  });

  ViolenceInjury copyWith({
    int? id,
    String? tipoDeViolencia,
    int? traumaRegisterRecordId,
  }) =>
      ViolenceInjury(
        id: id ?? this.id,
        tipoDeViolencia: tipoDeViolencia ?? this.tipoDeViolencia,
        traumaRegisterRecordId:
            traumaRegisterRecordId ?? this.traumaRegisterRecordId,
      );

  factory ViolenceInjury.fromJson(Map<String, dynamic> json) => ViolenceInjury(
        id: json["id"],
        tipoDeViolencia: json["tipo_de_violencia"],
        traumaRegisterRecordId: json["trauma_register_record_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_de_violencia": tipoDeViolencia,
        "trauma_register_record_id": traumaRegisterRecordId,
      };
}
