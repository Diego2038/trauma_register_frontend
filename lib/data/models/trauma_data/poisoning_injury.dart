class PoisoningInjury {
  final int? id;
  final String? tipoDeEnvenenamiento;

  PoisoningInjury({
    this.id,
    this.tipoDeEnvenenamiento,
  });

  PoisoningInjury copyWith({
    int? id,
    String? tipoDeEnvenenamiento,
  }) =>
      PoisoningInjury(
        id: id ?? this.id,
        tipoDeEnvenenamiento: tipoDeEnvenenamiento ?? this.tipoDeEnvenenamiento,
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
