class DrugAbuse {
    final int? id;
    final String? tipoDeDroga;
    final int? traumaRegisterRecordId;

    DrugAbuse({
        this.id,
        this.tipoDeDroga,
        this.traumaRegisterRecordId,
    });

    DrugAbuse copyWith({
        int? id,
        String? tipoDeDroga,
        int? traumaRegisterRecordId,
    }) => 
        DrugAbuse(
            id: id ?? this.id,
            tipoDeDroga: tipoDeDroga ?? this.tipoDeDroga,
            traumaRegisterRecordId: traumaRegisterRecordId ?? this.traumaRegisterRecordId,
        );

    factory DrugAbuse.fromJson(Map<String, dynamic> json) => DrugAbuse(
        id: json["id"],
        tipoDeDroga: json["tipo_de_droga"],
        traumaRegisterRecordId: json["trauma_register_record_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_de_droga": tipoDeDroga,
        "trauma_register_record_id": traumaRegisterRecordId,
    };
}