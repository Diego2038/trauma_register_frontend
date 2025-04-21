class VitalSign {
    final int? recordId;
    final DateTime? fechaYHoraDeSignosVitales;
    final bool? signosDeVida;
    final int? frecuenciaCardiaca;
    final int? presionArterialSistolica;
    final int? presionArterialDiastolica;
    final int? frecuenciaRespiratoria;
    final String? calificadorDeFrecuenciaRespiratoria;
    final double? temperaturaCelsius;
    final double? pesoKg;
    final double? alturaMetros;
    final double? saturacionDeOxigeno;
    final String? perdidaDeConciencia;
    final String? duracionDePerdidaDeConciencia;
    final int? gcsMotora;
    final int? gcsOcular;
    final int? gcsVerbal;
    final int? gcsTotal;
    final String? avup;
    final int? traumaRegisterRecordId;

    VitalSign({
        this.recordId,
        this.fechaYHoraDeSignosVitales,
        this.signosDeVida,
        this.frecuenciaCardiaca,
        this.presionArterialSistolica,
        this.presionArterialDiastolica,
        this.frecuenciaRespiratoria,
        this.calificadorDeFrecuenciaRespiratoria,
        this.temperaturaCelsius,
        this.pesoKg,
        this.alturaMetros,
        this.saturacionDeOxigeno,
        this.perdidaDeConciencia,
        this.duracionDePerdidaDeConciencia,
        this.gcsMotora,
        this.gcsOcular,
        this.gcsVerbal,
        this.gcsTotal,
        this.avup,
        this.traumaRegisterRecordId,
    });

    VitalSign copyWith({
        int? recordId,
        DateTime? fechaYHoraDeSignosVitales,
        bool? signosDeVida,
        int? frecuenciaCardiaca,
        int? presionArterialSistolica,
        int? presionArterialDiastolica,
        int? frecuenciaRespiratoria,
        String? calificadorDeFrecuenciaRespiratoria,
        double? temperaturaCelsius,
        double? pesoKg,
        double? alturaMetros,
        double? saturacionDeOxigeno,
        String? perdidaDeConciencia,
        String? duracionDePerdidaDeConciencia,
        int? gcsMotora,
        int? gcsOcular,
        int? gcsVerbal,
        int? gcsTotal,
        String? avup,
        int? traumaRegisterRecordId,
    }) => 
        VitalSign(
            recordId: recordId ?? this.recordId,
            fechaYHoraDeSignosVitales: fechaYHoraDeSignosVitales ?? this.fechaYHoraDeSignosVitales,
            signosDeVida: signosDeVida ?? this.signosDeVida,
            frecuenciaCardiaca: frecuenciaCardiaca ?? this.frecuenciaCardiaca,
            presionArterialSistolica: presionArterialSistolica ?? this.presionArterialSistolica,
            presionArterialDiastolica: presionArterialDiastolica ?? this.presionArterialDiastolica,
            frecuenciaRespiratoria: frecuenciaRespiratoria ?? this.frecuenciaRespiratoria,
            calificadorDeFrecuenciaRespiratoria: calificadorDeFrecuenciaRespiratoria ?? this.calificadorDeFrecuenciaRespiratoria,
            temperaturaCelsius: temperaturaCelsius ?? this.temperaturaCelsius,
            pesoKg: pesoKg ?? this.pesoKg,
            alturaMetros: alturaMetros ?? this.alturaMetros,
            saturacionDeOxigeno: saturacionDeOxigeno ?? this.saturacionDeOxigeno,
            perdidaDeConciencia: perdidaDeConciencia ?? this.perdidaDeConciencia,
            duracionDePerdidaDeConciencia: duracionDePerdidaDeConciencia ?? this.duracionDePerdidaDeConciencia,
            gcsMotora: gcsMotora ?? this.gcsMotora,
            gcsOcular: gcsOcular ?? this.gcsOcular,
            gcsVerbal: gcsVerbal ?? this.gcsVerbal,
            gcsTotal: gcsTotal ?? this.gcsTotal,
            avup: avup ?? this.avup,
            traumaRegisterRecordId: traumaRegisterRecordId ?? this.traumaRegisterRecordId,
        );

    factory VitalSign.fromJson(Map<String, dynamic> json) => VitalSign(
        recordId: json["record_id"],
        fechaYHoraDeSignosVitales: json["fecha_y_hora_de_signos_vitales"] == null ? null : DateTime.parse(json["fecha_y_hora_de_signos_vitales"]),
        signosDeVida: json["signos_de_vida"],
        frecuenciaCardiaca: json["frecuencia_cardiaca"],
        presionArterialSistolica: json["presion_arterial_sistolica"],
        presionArterialDiastolica: json["presion_arterial_diastolica"],
        frecuenciaRespiratoria: json["frecuencia_respiratoria"],
        calificadorDeFrecuenciaRespiratoria: json["calificador_de_frecuencia_respiratoria"],
        temperaturaCelsius: double.tryParse(json["temperatura_celsius"].toString()),
        pesoKg: double.tryParse(json["peso_kg"].toString()),
        alturaMetros: double.tryParse(json["altura_metros"].toString()),
        saturacionDeOxigeno: double.tryParse(json["saturacion_de_oxigeno"].toString()),
        perdidaDeConciencia: json["perdida_de_conciencia"],
        duracionDePerdidaDeConciencia: json["duracion_de_perdida_de_conciencia"],
        gcsMotora: json["gcs_motora"],
        gcsOcular: json["gcs_ocular"],
        gcsVerbal: json["gcs_verbal"],
        gcsTotal: json["gcs_total"],
        avup: json["avup"],
        traumaRegisterRecordId: json["trauma_register_record_id"],
    );

    Map<String, dynamic> toJson() => {
        "record_id": recordId,
        "fecha_y_hora_de_signos_vitales": fechaYHoraDeSignosVitales?.toIso8601String(),
        "signos_de_vida": signosDeVida,
        "frecuencia_cardiaca": frecuenciaCardiaca,
        "presion_arterial_sistolica": presionArterialSistolica,
        "presion_arterial_diastolica": presionArterialDiastolica,
        "frecuencia_respiratoria": frecuenciaRespiratoria,
        "calificador_de_frecuencia_respiratoria": calificadorDeFrecuenciaRespiratoria,
        "temperatura_celsius": temperaturaCelsius,
        "peso_kg": pesoKg,
        "altura_metros": alturaMetros,
        "saturacion_de_oxigeno": saturacionDeOxigeno,
        "perdida_de_conciencia": perdidaDeConciencia,
        "duracion_de_perdida_de_conciencia": duracionDePerdidaDeConciencia,
        "gcs_motora": gcsMotora,
        "gcs_ocular": gcsOcular,
        "gcs_verbal": gcsVerbal,
        "gcs_total": gcsTotal,
        "avup": avup,
        "trauma_register_record_id": traumaRegisterRecordId,
    };
}