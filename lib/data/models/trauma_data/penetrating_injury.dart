import 'package:trauma_register_frontend/data/models/shared/optional.dart';

class PenetratingInjury {
  final int? id;
  final String? tipoDeLesionPenetrante;

  PenetratingInjury({
    this.id,
    this.tipoDeLesionPenetrante,
  });

  PenetratingInjury copyWith({
    int? id,
    Optional<String?>? tipoDeLesionPenetrante,
  }) =>
      PenetratingInjury(
        id: id ?? this.id,
        tipoDeLesionPenetrante: tipoDeLesionPenetrante?.isPresent == true
            ? tipoDeLesionPenetrante!.value
            : this.tipoDeLesionPenetrante,
      );

  factory PenetratingInjury.fromJson(Map<String, dynamic> json) =>
      PenetratingInjury(
        id: json["id"],
        tipoDeLesionPenetrante: json["tipo_de_lesion_penetrante"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_de_lesion_penetrante": tipoDeLesionPenetrante,
      };
}
