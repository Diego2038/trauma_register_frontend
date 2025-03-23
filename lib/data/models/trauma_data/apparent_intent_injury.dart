class ApparentIntentInjury {
    final int? id;
    final String? intencionAparente;
    final int? traumaRegisterRecordId;

    ApparentIntentInjury({
        this.id,
        this.intencionAparente,
        this.traumaRegisterRecordId,
    });

    ApparentIntentInjury copyWith({
        int? id,
        String? intencionAparente,
        int? traumaRegisterRecordId,
    }) => 
        ApparentIntentInjury(
            id: id ?? this.id,
            intencionAparente: intencionAparente ?? this.intencionAparente,
            traumaRegisterRecordId: traumaRegisterRecordId ?? this.traumaRegisterRecordId,
        );

    factory ApparentIntentInjury.fromJson(Map<String, dynamic> json) => ApparentIntentInjury(
        id: json["id"],
        intencionAparente: json["intencion_aparente"],
        traumaRegisterRecordId: json["trauma_register_record_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "intencion_aparente": intencionAparente,
        "trauma_register_record_id": traumaRegisterRecordId,
    };
}
