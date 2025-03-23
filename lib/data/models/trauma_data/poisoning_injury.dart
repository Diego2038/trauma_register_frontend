class PoisoningInjury {
    final int? id;
    final String? tipoDeEnvenenamiento;
    final int? traumaRegisterRecordId;

    PoisoningInjury({
        this.id,
        this.tipoDeEnvenenamiento,
        this.traumaRegisterRecordId,
    });

    PoisoningInjury copyWith({
        int? id,
        String? tipoDeEnvenenamiento,
        int? traumaRegisterRecordId,
    }) => 
        PoisoningInjury(
            id: id ?? this.id,
            tipoDeEnvenenamiento: tipoDeEnvenenamiento ?? this.tipoDeEnvenenamiento,
            traumaRegisterRecordId: traumaRegisterRecordId ?? this.traumaRegisterRecordId,
        );

    factory PoisoningInjury.fromJson(Map<String, dynamic> json) => PoisoningInjury(
        id: json["id"],
        tipoDeEnvenenamiento: json["tipo_de_envenenamiento"],
        traumaRegisterRecordId: json["trauma_register_record_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_de_envenenamiento": tipoDeEnvenenamiento,
        "trauma_register_record_id": traumaRegisterRecordId,
    };
}