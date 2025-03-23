class TraumaRegisterIcd10 {
    final int? id;
    final String? descripcion;
    final String? mecanismoIcd;
    final int? traumaRegisterRecordId;

    TraumaRegisterIcd10({
        this.id,
        this.descripcion,
        this.mecanismoIcd,
        this.traumaRegisterRecordId,
    });

    TraumaRegisterIcd10 copyWith({
        int? id,
        String? descripcion,
        String? mecanismoIcd,
        int? traumaRegisterRecordId,
    }) => 
        TraumaRegisterIcd10(
            id: id ?? this.id,
            descripcion: descripcion ?? this.descripcion,
            mecanismoIcd: mecanismoIcd ?? this.mecanismoIcd,
            traumaRegisterRecordId: traumaRegisterRecordId ?? this.traumaRegisterRecordId,
        );

    factory TraumaRegisterIcd10.fromJson(Map<String, dynamic> json) => TraumaRegisterIcd10(
        id: json["id"],
        descripcion: json["descripcion"],
        mecanismoIcd: json["mecanismo_icd"],
        traumaRegisterRecordId: json["trauma_register_record_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
        "mecanismo_icd": mecanismoIcd,
        "trauma_register_record_id": traumaRegisterRecordId,
    };
}