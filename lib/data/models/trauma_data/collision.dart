import 'package:trauma_register_frontend/data/models/shared/optional.dart';

class Collision {
  final int? id;
  final String? tipoDeColision;

  Collision({
    this.id,
    this.tipoDeColision,
  });

  Collision copyWith({
    int? id,
    Optional<String?>? tipoDeColision,
  }) =>
      Collision(
        id: id ?? this.id,
        tipoDeColision: tipoDeColision?.isPresent == true
            ? tipoDeColision!.value
            : this.tipoDeColision,
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
