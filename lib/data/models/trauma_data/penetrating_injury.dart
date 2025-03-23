class PenetratingInjury {
    final int? id;
    final String? tipoDeLesionPenetrante;
    final int? traumaRegisterRecordId;

    PenetratingInjury({
        this.id,
        this.tipoDeLesionPenetrante,
        this.traumaRegisterRecordId,
    });

    PenetratingInjury copyWith({
        int? id,
        String? tipoDeLesionPenetrante,
        int? traumaRegisterRecordId,
    }) => 
        PenetratingInjury(
            id: id ?? this.id,
            tipoDeLesionPenetrante: tipoDeLesionPenetrante ?? this.tipoDeLesionPenetrante,
            traumaRegisterRecordId: traumaRegisterRecordId ?? this.traumaRegisterRecordId,
        );

    factory PenetratingInjury.fromJson(Map<String, dynamic> json) => PenetratingInjury(
        id: json["id"],
        tipoDeLesionPenetrante: json["tipo_de_lesion_penetrante"],
        traumaRegisterRecordId: json["trauma_register_record_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_de_lesion_penetrante": tipoDeLesionPenetrante,
        "trauma_register_record_id": traumaRegisterRecordId,
    };
}