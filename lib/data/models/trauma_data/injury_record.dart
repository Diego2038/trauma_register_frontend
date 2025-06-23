class InjuryRecord {
  final int? id;
  final String? consumoDeAlcohol;
  final double? valorDeAlcoholemia;
  final String? unidadDeAlcohol;
  final String? otraSustanciaDeAbuso;
  final String? direccionNombreDelLugar;
  final String? ciudadDeEventoDeLaLesion;
  final String? condadoDeLesiones;
  final String? estadoProvinciaDeLesiones;
  final String? paisDeLesiones;
  final String? codigoPostalDeLesiones;
  final DateTime? fechaYHoraDelEvento;
  final bool? accidenteDeTrafico;
  final String? tipoDeVehiculo;
  final String? ocupante;
  final String? velocidadDeColision;
  final int? scq;
  final bool? caida;
  final double? alturaMetros;
  final String? tipoDeSuperficie;

  InjuryRecord({
    this.id,
    this.consumoDeAlcohol,
    this.valorDeAlcoholemia,
    this.unidadDeAlcohol,
    this.otraSustanciaDeAbuso,
    this.direccionNombreDelLugar,
    this.ciudadDeEventoDeLaLesion,
    this.condadoDeLesiones,
    this.estadoProvinciaDeLesiones,
    this.paisDeLesiones,
    this.codigoPostalDeLesiones,
    this.fechaYHoraDelEvento,
    this.accidenteDeTrafico,
    this.tipoDeVehiculo,
    this.ocupante,
    this.velocidadDeColision,
    this.scq,
    this.caida,
    this.alturaMetros,
    this.tipoDeSuperficie,
  });

  InjuryRecord copyWith({
    int? id,
    String? consumoDeAlcohol,
    double? valorDeAlcoholemia,
    String? unidadDeAlcohol,
    String? otraSustanciaDeAbuso,
    String? direccionNombreDelLugar,
    String? ciudadDeEventoDeLaLesion,
    String? condadoDeLesiones,
    String? estadoProvinciaDeLesiones,
    String? paisDeLesiones,
    String? codigoPostalDeLesiones,
    DateTime? fechaYHoraDelEvento,
    bool? accidenteDeTrafico,
    String? tipoDeVehiculo,
    String? ocupante,
    String? velocidadDeColision,
    int? scq,
    bool? caida,
    double? alturaMetros,
    String? tipoDeSuperficie,
  }) =>
      InjuryRecord(
        id: id ?? this.id,
        consumoDeAlcohol: consumoDeAlcohol ?? this.consumoDeAlcohol,
        valorDeAlcoholemia: valorDeAlcoholemia ?? this.valorDeAlcoholemia,
        unidadDeAlcohol: unidadDeAlcohol ?? this.unidadDeAlcohol,
        otraSustanciaDeAbuso: otraSustanciaDeAbuso ?? this.otraSustanciaDeAbuso,
        direccionNombreDelLugar:
            direccionNombreDelLugar ?? this.direccionNombreDelLugar,
        ciudadDeEventoDeLaLesion:
            ciudadDeEventoDeLaLesion ?? this.ciudadDeEventoDeLaLesion,
        condadoDeLesiones: condadoDeLesiones ?? this.condadoDeLesiones,
        estadoProvinciaDeLesiones:
            estadoProvinciaDeLesiones ?? this.estadoProvinciaDeLesiones,
        paisDeLesiones: paisDeLesiones ?? this.paisDeLesiones,
        codigoPostalDeLesiones:
            codigoPostalDeLesiones ?? this.codigoPostalDeLesiones,
        fechaYHoraDelEvento: fechaYHoraDelEvento ?? this.fechaYHoraDelEvento,
        accidenteDeTrafico: accidenteDeTrafico ?? this.accidenteDeTrafico,
        tipoDeVehiculo: tipoDeVehiculo ?? this.tipoDeVehiculo,
        ocupante: ocupante ?? this.ocupante,
        velocidadDeColision: velocidadDeColision ?? this.velocidadDeColision,
        scq: scq ?? this.scq,
        caida: caida ?? this.caida,
        alturaMetros: alturaMetros ?? this.alturaMetros,
        tipoDeSuperficie: tipoDeSuperficie ?? this.tipoDeSuperficie,
      );

  factory InjuryRecord.fromJson(Map<String, dynamic> json) => InjuryRecord(
        id: json["id"],
        consumoDeAlcohol: json["consumo_de_alcohol"],
        valorDeAlcoholemia:
            double.tryParse(json["valor_de_alcoholemia"].toString()),
        unidadDeAlcohol: json["unidad_de_alcohol"],
        otraSustanciaDeAbuso: json["otra_sustancia_de_abuso"],
        direccionNombreDelLugar: json["direccion_nombre_del_lugar"],
        ciudadDeEventoDeLaLesion: json["ciudad_de_evento_de_la_lesion"],
        condadoDeLesiones: json["condado_de_lesiones"],
        estadoProvinciaDeLesiones: json["estado_provincia_de_lesiones"],
        paisDeLesiones: json["pais_de_lesiones"],
        codigoPostalDeLesiones: json["codigo_postal_de_lesiones"],
        fechaYHoraDelEvento: json["fecha_y_hora_del_evento"] == null
            ? null
            : DateTime.parse(json["fecha_y_hora_del_evento"]),
        accidenteDeTrafico: json["accidente_de_trafico"],
        tipoDeVehiculo: json["tipo_de_vehiculo"],
        ocupante: json["ocupante"],
        velocidadDeColision: json["velocidad_de_colision"],
        scq: json["scq"],
        caida: json["caida"],
        alturaMetros: double.tryParse(json["altura_metros"].toString()),
        tipoDeSuperficie: json["tipo_de_superficie"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "consumo_de_alcohol": consumoDeAlcohol,
        "valor_de_alcoholemia": valorDeAlcoholemia,
        "unidad_de_alcohol": unidadDeAlcohol,
        "otra_sustancia_de_abuso": otraSustanciaDeAbuso,
        "direccion_nombre_del_lugar": direccionNombreDelLugar,
        "ciudad_de_evento_de_la_lesion": ciudadDeEventoDeLaLesion,
        "condado_de_lesiones": condadoDeLesiones,
        "estado_provincia_de_lesiones": estadoProvinciaDeLesiones,
        "pais_de_lesiones": paisDeLesiones,
        "codigo_postal_de_lesiones": codigoPostalDeLesiones,
        "fecha_y_hora_del_evento": fechaYHoraDelEvento?.toIso8601String(),
        "accidente_de_trafico": accidenteDeTrafico,
        "tipo_de_vehiculo": tipoDeVehiculo,
        "ocupante": ocupante,
        "velocidad_de_colision": velocidadDeColision,
        "scq": scq,
        "caida": caida,
        "altura_metros": alturaMetros,
        "tipo_de_superficie": tipoDeSuperficie,
      };
}
