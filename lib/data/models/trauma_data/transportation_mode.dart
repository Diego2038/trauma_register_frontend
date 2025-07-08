import 'package:trauma_register_frontend/data/models/shared/optional.dart';

class TransportationMode {
  final int? id;
  final String? modoDeTransporte;

  TransportationMode({
    this.id,
    this.modoDeTransporte,
  });

  TransportationMode copyWith({
    int? id,
    Optional<String?>? modoDeTransporte,
  }) =>
      TransportationMode(
        id: id ?? this.id,
        modoDeTransporte: modoDeTransporte?.isPresent == true
            ? modoDeTransporte!.value
            : this.modoDeTransporte,
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
