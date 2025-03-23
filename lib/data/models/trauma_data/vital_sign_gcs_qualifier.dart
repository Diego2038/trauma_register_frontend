class VitalSignGcsQualifier {
    final int? id;
    final String? calificadorGcs;
    final int? traumaRegisterRecordId;

    VitalSignGcsQualifier({
        this.id,
        this.calificadorGcs,
        this.traumaRegisterRecordId,
    });

    VitalSignGcsQualifier copyWith({
        int? id,
        String? calificadorGcs,
        int? traumaRegisterRecordId,
    }) => 
        VitalSignGcsQualifier(
            id: id ?? this.id,
            calificadorGcs: calificadorGcs ?? this.calificadorGcs,
            traumaRegisterRecordId: traumaRegisterRecordId ?? this.traumaRegisterRecordId,
        );

    factory VitalSignGcsQualifier.fromJson(Map<String, dynamic> json) => VitalSignGcsQualifier(
        id: json["id"],
        calificadorGcs: json["calificador_gcs"],
        traumaRegisterRecordId: json["trauma_register_record_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "calificador_gcs": calificadorGcs,
        "trauma_register_record_id": traumaRegisterRecordId,
    };
}