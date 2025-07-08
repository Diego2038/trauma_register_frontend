import 'package:trauma_register_frontend/data/models/shared/optional.dart';

class BurnInjury {
  final int? id;
  final String? tipoDeQuemadura;
  final String? gradoDeQuemadura;

  BurnInjury({
    this.id,
    this.tipoDeQuemadura,
    this.gradoDeQuemadura,
  });

  BurnInjury copyWith({
    int? id,
    Optional<String?>? tipoDeQuemadura,
    Optional<String?>? gradoDeQuemadura,
  }) =>
      BurnInjury(
        id: id ?? this.id,
        tipoDeQuemadura: tipoDeQuemadura?.isPresent == true
            ? tipoDeQuemadura!.value
            : this.tipoDeQuemadura,
        gradoDeQuemadura: gradoDeQuemadura?.isPresent == true
            ? gradoDeQuemadura!.value
            : this.gradoDeQuemadura,
      );

  factory BurnInjury.fromJson(Map<String, dynamic> json) => BurnInjury(
        id: json["id"],
        tipoDeQuemadura: json["tipo_de_quemadura"],
        gradoDeQuemadura: json["grado_de_quemadura"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_de_quemadura": tipoDeQuemadura,
        "grado_de_quemadura": gradoDeQuemadura,
      };
}
