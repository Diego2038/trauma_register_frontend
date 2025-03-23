class HospitalizationComplication {
    final int? id;
    final String? tipoDeComplicacion;
    final DateTime? fechaYHoraDeComplicacion;
    final String? lugarDeComplicacion;
    final int? traumaRegisterRecordId;

    HospitalizationComplication({
        this.id,
        this.tipoDeComplicacion,
        this.fechaYHoraDeComplicacion,
        this.lugarDeComplicacion,
        this.traumaRegisterRecordId,
    });

    HospitalizationComplication copyWith({
        int? id,
        String? tipoDeComplicacion,
        DateTime? fechaYHoraDeComplicacion,
        String? lugarDeComplicacion,
        int? traumaRegisterRecordId,
    }) => 
        HospitalizationComplication(
            id: id ?? this.id,
            tipoDeComplicacion: tipoDeComplicacion ?? this.tipoDeComplicacion,
            fechaYHoraDeComplicacion: fechaYHoraDeComplicacion ?? this.fechaYHoraDeComplicacion,
            lugarDeComplicacion: lugarDeComplicacion ?? this.lugarDeComplicacion,
            traumaRegisterRecordId: traumaRegisterRecordId ?? this.traumaRegisterRecordId,
        );

    factory HospitalizationComplication.fromJson(Map<String, dynamic> json) => HospitalizationComplication(
        id: json["id"],
        tipoDeComplicacion: json["tipo_de_complicacion"],
        fechaYHoraDeComplicacion: json["fecha_y_hora_de_complicacion"] == null ? null : DateTime.parse(json["fecha_y_hora_de_complicacion"]),
        lugarDeComplicacion: json["lugar_de_complicacion"],
        traumaRegisterRecordId: json["trauma_register_record_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_de_complicacion": tipoDeComplicacion,
        "fecha_y_hora_de_complicacion": fechaYHoraDeComplicacion?.toIso8601String(),
        "lugar_de_complicacion": lugarDeComplicacion,
        "trauma_register_record_id": traumaRegisterRecordId,
    };
}