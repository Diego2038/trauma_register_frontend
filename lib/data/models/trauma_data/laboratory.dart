class Laboratory {
  final int? id;
  final String? resultadoDeLaboratorio;
  final DateTime? fechaYHoraDeLaboratorio;
  final String? nombreDelLaboratorio;
  final String? nombreDeLaUnidadDeLaboratorio;

  Laboratory({
    this.id,
    this.resultadoDeLaboratorio,
    this.fechaYHoraDeLaboratorio,
    this.nombreDelLaboratorio,
    this.nombreDeLaUnidadDeLaboratorio,
  });

  Laboratory copyWith({
    int? id,
    String? resultadoDeLaboratorio,
    DateTime? fechaYHoraDeLaboratorio,
    String? nombreDelLaboratorio,
    String? nombreDeLaUnidadDeLaboratorio,
  }) =>
      Laboratory(
        id: id ?? this.id,
        resultadoDeLaboratorio:
            resultadoDeLaboratorio ?? this.resultadoDeLaboratorio,
        fechaYHoraDeLaboratorio:
            fechaYHoraDeLaboratorio ?? this.fechaYHoraDeLaboratorio,
        nombreDelLaboratorio: nombreDelLaboratorio ?? this.nombreDelLaboratorio,
        nombreDeLaUnidadDeLaboratorio:
            nombreDeLaUnidadDeLaboratorio ?? this.nombreDeLaUnidadDeLaboratorio,
      );

  factory Laboratory.fromJson(Map<String, dynamic> json) => Laboratory(
        id: json["id"],
        resultadoDeLaboratorio: json["resultado_de_laboratorio"],
        fechaYHoraDeLaboratorio: json["fecha_y_hora_de_laboratorio"] == null
            ? null
            : DateTime.parse(json["fecha_y_hora_de_laboratorio"]),
        nombreDelLaboratorio: json["nombre_del_laboratorio"],
        nombreDeLaUnidadDeLaboratorio:
            json["nombre_de_la_unidad_de_laboratorio"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "resultado_de_laboratorio": resultadoDeLaboratorio,
        "fecha_y_hora_de_laboratorio":
            fechaYHoraDeLaboratorio?.toIso8601String(),
        "nombre_del_laboratorio": nombreDelLaboratorio,
        "nombre_de_la_unidad_de_laboratorio": nombreDeLaUnidadDeLaboratorio,
      };
}
