class TransportationMode {
    final int? id;
    final String? modoDeTransporte;
    final int? traumaRegisterRecordId;

    TransportationMode({
        this.id,
        this.modoDeTransporte,
        this.traumaRegisterRecordId,
    });

    TransportationMode copyWith({
        int? id,
        String? modoDeTransporte,
        int? traumaRegisterRecordId,
    }) => 
        TransportationMode(
            id: id ?? this.id,
            modoDeTransporte: modoDeTransporte ?? this.modoDeTransporte,
            traumaRegisterRecordId: traumaRegisterRecordId ?? this.traumaRegisterRecordId,
        );

    factory TransportationMode.fromJson(Map<String, dynamic> json) => TransportationMode(
        id: json["id"],
        modoDeTransporte: json["modo_de_transporte"],
        traumaRegisterRecordId: json["trauma_register_record_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "modo_de_transporte": modoDeTransporte,
        "trauma_register_record_id": traumaRegisterRecordId,
    };
}