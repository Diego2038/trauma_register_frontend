class Device {
    final int? id;
    final String? tipoDeDispositivo;
    final int? traumaRegisterRecordId;

    Device({
        this.id,
        this.tipoDeDispositivo,
        this.traumaRegisterRecordId,
    });

    Device copyWith({
        int? id,
        String? tipoDeDispositivo,
        int? traumaRegisterRecordId,
    }) => 
        Device(
            id: id ?? this.id,
            tipoDeDispositivo: tipoDeDispositivo ?? this.tipoDeDispositivo,
            traumaRegisterRecordId: traumaRegisterRecordId ?? this.traumaRegisterRecordId,
        );

    factory Device.fromJson(Map<String, dynamic> json) => Device(
        id: json["id"],
        tipoDeDispositivo: json["tipo_de_dispositivo"],
        traumaRegisterRecordId: json["trauma_register_record_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_de_dispositivo": tipoDeDispositivo,
        "trauma_register_record_id": traumaRegisterRecordId,
    };
}