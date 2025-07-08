import 'package:trauma_register_frontend/data/models/shared/optional.dart';

class HospitalizationComplication {
  final int? id;
  final String? tipoDeComplicacion;
  final DateTime? fechaYHoraDeComplicacion;
  final String? lugarDeComplicacion;

  HospitalizationComplication({
    this.id,
    this.tipoDeComplicacion,
    this.fechaYHoraDeComplicacion,
    this.lugarDeComplicacion,
  });

  HospitalizationComplication copyWith({
    int? id,
    Optional<String?>? tipoDeComplicacion,
    Optional<DateTime?>? fechaYHoraDeComplicacion,
    Optional<String?>? lugarDeComplicacion,
  }) =>
      HospitalizationComplication(
        id: id ?? this.id,
        tipoDeComplicacion: tipoDeComplicacion?.isPresent == true
            ? tipoDeComplicacion!.value
            : this.tipoDeComplicacion,
        fechaYHoraDeComplicacion: fechaYHoraDeComplicacion?.isPresent == true
            ? fechaYHoraDeComplicacion!.value
            : this.fechaYHoraDeComplicacion,
        lugarDeComplicacion: lugarDeComplicacion?.isPresent == true
            ? lugarDeComplicacion!.value
            : this.lugarDeComplicacion,
      );

  factory HospitalizationComplication.fromJson(Map<String, dynamic> json) =>
      HospitalizationComplication(
        id: json["id"],
        tipoDeComplicacion: json["tipo_de_complicacion"],
        fechaYHoraDeComplicacion: json["fecha_y_hora_de_complicacion"] == null
            ? null
            : DateTime.parse(json["fecha_y_hora_de_complicacion"]),
        lugarDeComplicacion: json["lugar_de_complicacion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_de_complicacion": tipoDeComplicacion,
        "fecha_y_hora_de_complicacion":
            fechaYHoraDeComplicacion?.toIso8601String(),
        "lugar_de_complicacion": lugarDeComplicacion,
      };
}
