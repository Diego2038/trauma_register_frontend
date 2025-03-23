//TODO: Queda pendiente ver bien el tipo de dato de todos los atributos
class InjuryRecord {
    final int? id;
    final String? consumoDeAlcohol;
    final dynamic valorDeAlcoholemia;
    final String? unidadDeAlcohol;
    final String? otraSustanciaDeAbuso;
    final dynamic direccionNombreDelLugar;
    final String? ciudadDeEventoDeLaLesion;
    final dynamic condadoDeLesiones;
    final String? estadoProvinciaDeLesiones;
    final String? paisDeLesiones;
    final dynamic codigoPostalDeLesiones;
    final DateTime? fechaYHoraDelEvento;
    final bool? accidenteDeTrafico;
    final dynamic tipoDeVehiculo;
    final dynamic ocupante;
    final dynamic velocidadDeColision;
    final dynamic scq;
    final bool? caida;
    final dynamic alturaMetros;
    final dynamic tipoDeSuperficie;
    final int? traumaRegisterRecordId;

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
        this.traumaRegisterRecordId,
    });

    InjuryRecord copyWith({
        int? id,
        String? consumoDeAlcohol,
        dynamic valorDeAlcoholemia,
        String? unidadDeAlcohol,
        String? otraSustanciaDeAbuso,
        dynamic direccionNombreDelLugar,
        String? ciudadDeEventoDeLaLesion,
        dynamic condadoDeLesiones,
        String? estadoProvinciaDeLesiones,
        String? paisDeLesiones,
        dynamic codigoPostalDeLesiones,
        DateTime? fechaYHoraDelEvento,
        bool? accidenteDeTrafico,
        dynamic tipoDeVehiculo,
        dynamic ocupante,
        dynamic velocidadDeColision,
        dynamic scq,
        bool? caida,
        dynamic alturaMetros,
        dynamic tipoDeSuperficie,
        int? traumaRegisterRecordId,
    }) => 
        InjuryRecord(
            id: id ?? this.id,
            consumoDeAlcohol: consumoDeAlcohol ?? this.consumoDeAlcohol,
            valorDeAlcoholemia: valorDeAlcoholemia ?? this.valorDeAlcoholemia,
            unidadDeAlcohol: unidadDeAlcohol ?? this.unidadDeAlcohol,
            otraSustanciaDeAbuso: otraSustanciaDeAbuso ?? this.otraSustanciaDeAbuso,
            direccionNombreDelLugar: direccionNombreDelLugar ?? this.direccionNombreDelLugar,
            ciudadDeEventoDeLaLesion: ciudadDeEventoDeLaLesion ?? this.ciudadDeEventoDeLaLesion,
            condadoDeLesiones: condadoDeLesiones ?? this.condadoDeLesiones,
            estadoProvinciaDeLesiones: estadoProvinciaDeLesiones ?? this.estadoProvinciaDeLesiones,
            paisDeLesiones: paisDeLesiones ?? this.paisDeLesiones,
            codigoPostalDeLesiones: codigoPostalDeLesiones ?? this.codigoPostalDeLesiones,
            fechaYHoraDelEvento: fechaYHoraDelEvento ?? this.fechaYHoraDelEvento,
            accidenteDeTrafico: accidenteDeTrafico ?? this.accidenteDeTrafico,
            tipoDeVehiculo: tipoDeVehiculo ?? this.tipoDeVehiculo,
            ocupante: ocupante ?? this.ocupante,
            velocidadDeColision: velocidadDeColision ?? this.velocidadDeColision,
            scq: scq ?? this.scq,
            caida: caida ?? this.caida,
            alturaMetros: alturaMetros ?? this.alturaMetros,
            tipoDeSuperficie: tipoDeSuperficie ?? this.tipoDeSuperficie,
            traumaRegisterRecordId: traumaRegisterRecordId ?? this.traumaRegisterRecordId,
        );

    factory InjuryRecord.fromJson(Map<String, dynamic> json) => InjuryRecord(
        id: json["id"],
        consumoDeAlcohol: json["consumo_de_alcohol"],
        valorDeAlcoholemia: json["valor_de_alcoholemia"],
        unidadDeAlcohol: json["unidad_de_alcohol"],
        otraSustanciaDeAbuso: json["otra_sustancia_de_abuso"],
        direccionNombreDelLugar: json["direccion_nombre_del_lugar"],
        ciudadDeEventoDeLaLesion: json["ciudad_de_evento_de_la_lesion"],
        condadoDeLesiones: json["condado_de_lesiones"],
        estadoProvinciaDeLesiones: json["estado_provincia_de_lesiones"],
        paisDeLesiones: json["pais_de_lesiones"],
        codigoPostalDeLesiones: json["codigo_postal_de_lesiones"],
        fechaYHoraDelEvento: json["fecha_y_hora_del_evento"] == null ? null : DateTime.parse(json["fecha_y_hora_del_evento"]),
        accidenteDeTrafico: json["accidente_de_trafico"],
        tipoDeVehiculo: json["tipo_de_vehiculo"],
        ocupante: json["ocupante"],
        velocidadDeColision: json["velocidad_de_colision"],
        scq: json["scq"],
        caida: json["caida"],
        alturaMetros: json["altura_metros"],
        tipoDeSuperficie: json["tipo_de_superficie"],
        traumaRegisterRecordId: json["trauma_register_record_id"],
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
        "trauma_register_record_id": traumaRegisterRecordId,
    };
}