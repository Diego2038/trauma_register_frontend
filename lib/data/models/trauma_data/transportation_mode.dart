class TransportationMode {
  final int? id;
  final String? modoDeTransporte;

  TransportationMode({
    this.id,
    this.modoDeTransporte,
  });

  TransportationMode copyWith({
    int? id,
    String? modoDeTransporte,
  }) =>
      TransportationMode(
        id: id ?? this.id,
        modoDeTransporte: modoDeTransporte ?? this.modoDeTransporte,
      );

  factory TransportationMode.fromJson(Map<String, dynamic> json) =>
      TransportationMode(
        id: json["id"],
        modoDeTransporte: json["modo_de_transporte"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "modo_de_transporte": modoDeTransporte,
      };
}
