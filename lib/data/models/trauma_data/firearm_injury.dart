class FirearmInjury {
  final int? id;
  final String? tipoDeArmaDeFuego;
  final int? traumaRegisterRecordId;

  FirearmInjury({
    this.id,
    this.tipoDeArmaDeFuego,
    this.traumaRegisterRecordId,
  });

  FirearmInjury copyWith({
    int? id,
    String? tipoDeArmaDeFuego,
    int? traumaRegisterRecordId,
  }) =>
      FirearmInjury(
        id: id ?? this.id,
        tipoDeArmaDeFuego: tipoDeArmaDeFuego ?? this.tipoDeArmaDeFuego,
        traumaRegisterRecordId:
            traumaRegisterRecordId ?? this.traumaRegisterRecordId,
      );

  factory FirearmInjury.fromJson(Map<String, dynamic> json) => FirearmInjury(
        id: json["id"],
        tipoDeArmaDeFuego: json["tipo_de_arma_de_fuego"],
        traumaRegisterRecordId: json["trauma_register_record_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_de_arma_de_fuego": tipoDeArmaDeFuego,
        "trauma_register_record_id": traumaRegisterRecordId,
      };
}
