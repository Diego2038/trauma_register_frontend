import 'package:trauma_register_frontend/data/models/shared/optional.dart';

class HospitalizationVariable {
  final int? id;
  final String? tipoDeVariable;
  final String? valorDeLaVariable;
  final DateTime? fechaYHoraDeLaVariable;
  final String? localizacionDeVariable;

  HospitalizationVariable({
    this.id,
    this.tipoDeVariable,
    this.valorDeLaVariable,
    this.fechaYHoraDeLaVariable,
    this.localizacionDeVariable,
  });

  HospitalizationVariable copyWith({
    int? id,
    Optional<String?>? tipoDeVariable,
    Optional<String?>? valorDeLaVariable,
    Optional<DateTime?>? fechaYHoraDeLaVariable,
    Optional<String?>? localizacionDeVariable,
  }) =>
      HospitalizationVariable(
        id: id ?? this.id,
        tipoDeVariable: tipoDeVariable?.isPresent == true
            ? tipoDeVariable!.value
            : this.tipoDeVariable,
        valorDeLaVariable: valorDeLaVariable?.isPresent == true
            ? valorDeLaVariable!.value
            : this.valorDeLaVariable,
        fechaYHoraDeLaVariable: fechaYHoraDeLaVariable?.isPresent == true
            ? fechaYHoraDeLaVariable!.value
            : this.fechaYHoraDeLaVariable,
        localizacionDeVariable: localizacionDeVariable?.isPresent == true
            ? localizacionDeVariable!.value
            : this.localizacionDeVariable,
      );

  factory HospitalizationVariable.fromJson(Map<String, dynamic> json) =>
      HospitalizationVariable(
        id: json["id"],
        tipoDeVariable: json["tipo_de_variable"],
        valorDeLaVariable: json["valor_de_la_variable"],
        fechaYHoraDeLaVariable: json["fecha_y_hora_de_la_variable"] == null
            ? null
            : DateTime.parse(json["fecha_y_hora_de_la_variable"]),
        localizacionDeVariable: json["localizacion_de_variable"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_de_variable": tipoDeVariable,
        "valor_de_la_variable": valorDeLaVariable,
        "fecha_y_hora_de_la_variable":
            fechaYHoraDeLaVariable?.toIso8601String(),
        "localizacion_de_variable": localizacionDeVariable,
      };
}
