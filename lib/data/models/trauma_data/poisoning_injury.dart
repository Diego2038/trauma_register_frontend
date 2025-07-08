import 'package:trauma_register_frontend/data/models/shared/optional.dart';

class PoisoningInjury {
  final int? id;
  final String? tipoDeEnvenenamiento;

  PoisoningInjury({
    this.id,
    this.tipoDeEnvenenamiento,
  });

  PoisoningInjury copyWith({
    int? id,
    Optional<String?>? tipoDeEnvenenamiento,
  }) =>
      PoisoningInjury(
        id: id ?? this.id,
        tipoDeEnvenenamiento: tipoDeEnvenenamiento?.isPresent == true
            ? tipoDeEnvenenamiento!.value
            : this.tipoDeEnvenenamiento,
      );

  factory PoisoningInjury.fromJson(Map<String, dynamic> json) =>
      PoisoningInjury(
        id: json["id"],
        tipoDeEnvenenamiento: json["tipo_de_envenenamiento"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_de_envenenamiento": tipoDeEnvenenamiento,
      };
}
