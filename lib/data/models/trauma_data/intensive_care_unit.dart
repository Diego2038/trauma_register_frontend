import 'package:trauma_register_frontend/data/models/shared/optional.dart';

class IntensiveCareUnit {
  final int? id;
  final String? tipo;
  final DateTime? fechaYHoraDeInicio;
  final DateTime? fechaYHoraDeTermino;
  final String? lugar;
  final double? icuDays;

  IntensiveCareUnit({
    this.id,
    this.tipo,
    this.fechaYHoraDeInicio,
    this.fechaYHoraDeTermino,
    this.lugar,
    this.icuDays,
  });

  IntensiveCareUnit copyWith({
    int? id,
    Optional<String?>? tipo,
    Optional<DateTime?>? fechaYHoraDeInicio,
    Optional<DateTime?>? fechaYHoraDeTermino,
    Optional<String?>? lugar,
    Optional<double?>? icuDays,
  }) =>
      IntensiveCareUnit(
        id: id ?? this.id,
        tipo: tipo?.isPresent == true ? tipo!.value : this.tipo,
        fechaYHoraDeInicio: fechaYHoraDeInicio?.isPresent == true
            ? fechaYHoraDeInicio!.value
            : this.fechaYHoraDeInicio,
        fechaYHoraDeTermino: fechaYHoraDeTermino?.isPresent == true
            ? fechaYHoraDeTermino!.value
            : this.fechaYHoraDeTermino,
        lugar: lugar?.isPresent == true ? lugar!.value : this.lugar,
        icuDays: icuDays?.isPresent == true ? icuDays!.value : this.icuDays,
      );

  factory IntensiveCareUnit.fromJson(Map<String, dynamic> json) =>
      IntensiveCareUnit(
        id: json["id"],
        tipo: json["tipo"],
        fechaYHoraDeInicio: json["fecha_y_hora_de_inicio"] == null
            ? null
            : DateTime.parse(json["fecha_y_hora_de_inicio"]),
        fechaYHoraDeTermino: json["fecha_y_hora_de_termino"] == null
            ? null
            : DateTime.parse(json["fecha_y_hora_de_termino"]),
        lugar: json["lugar"],
        icuDays: double.tryParse(json["icu_days"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "fecha_y_hora_de_inicio": fechaYHoraDeInicio?.toIso8601String(),
        "fecha_y_hora_de_termino": fechaYHoraDeTermino?.toIso8601String(),
        "lugar": lugar,
        "icu_days": icuDays,
      };
}
