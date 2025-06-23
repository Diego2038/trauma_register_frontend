class Collision {
  final int? id;
  final String? tipoDeColision;

  Collision({
    this.id,
    this.tipoDeColision,
  });

  Collision copyWith({
    int? id,
    String? tipoDeColision,
  }) =>
      Collision(
        id: id ?? this.id,
        tipoDeColision: tipoDeColision ?? this.tipoDeColision,
      );

  factory Collision.fromJson(Map<String, dynamic> json) => Collision(
        id: json["id"],
        tipoDeColision: json["tipo_de_colision"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_de_colision": tipoDeColision,
      };
}
