class FirearmInjury {
  final int? id;
  final String? tipoDeArmaDeFuego;

  FirearmInjury({
    this.id,
    this.tipoDeArmaDeFuego,
  });

  FirearmInjury copyWith({
    int? id,
    String? tipoDeArmaDeFuego,
  }) =>
      FirearmInjury(
        id: id ?? this.id,
        tipoDeArmaDeFuego: tipoDeArmaDeFuego ?? this.tipoDeArmaDeFuego,
      );

  factory FirearmInjury.fromJson(Map<String, dynamic> json) => FirearmInjury(
        id: json["id"],
        tipoDeArmaDeFuego: json["tipo_de_arma_de_fuego"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_de_arma_de_fuego": tipoDeArmaDeFuego,
      };
}
