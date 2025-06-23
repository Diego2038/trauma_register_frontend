class Collision {
  final int? id;
  final String? tipoDeColision;
  final int? traumaRegisterRecordId;

  Collision({
    this.id,
    this.tipoDeColision,
    this.traumaRegisterRecordId,
  });

  Collision copyWith({
    int? id,
    String? tipoDeColision,
    int? traumaRegisterRecordId,
  }) =>
      Collision(
        id: id ?? this.id,
        tipoDeColision: tipoDeColision ?? this.tipoDeColision,
        traumaRegisterRecordId:
            traumaRegisterRecordId ?? this.traumaRegisterRecordId,
      );

  factory Collision.fromJson(Map<String, dynamic> json) => Collision(
        id: json["id"],
        tipoDeColision: json["tipo_de_colision"],
        traumaRegisterRecordId: json["trauma_register_record_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_de_colision": tipoDeColision,
        "trauma_register_record_id": traumaRegisterRecordId,
      };
}
