import 'package:trauma_register_frontend/data/models/custom/time_of_day.dart';

class HealthcareRecord {
  final int? id;
  final String? numeroDeHistoriaClinica;
  final String? hospital;
  final DateTime? fechaYHoraDeLlegadaDelPaciente;
  final bool? referido;
  final bool? policiaNotificada;
  final DateTime? fechaYHoraDeLlegadaDelMedico;
  final DateTime? fechaYHoraDeNotificacionAlMedico;
  final bool? alertaEquipoDeTrauma;
  final String? nivelDeAlerta;
  final bool? pacienteAsegurado;
  final String? tipoDeSeguro;
  final String? motivoDeConsulta;
  final String? inmunizacionContraElTetanos;
  final String? descripcionDelExamenFisico;
  final String? mecanismoPrimario;
  final String? numeroDeLesionesSerias;
  final String? descripcionDelDiagnostico;
  final String? disposicionODestinoDelPaciente;
  final String? donacionDeOrganos;
  final String? autopsia;
  final String? muertePrevenible;
  final String? tipoDeAdmision;
  final DateTime? fechaYHoraDeLaDisposicion;
  final int? tiempoEnSalaDeEmergenciasHoras;
  final int? tiempoEnSalaDeEmergenciasMinutos;
  final String? numeroDeReferenciaDelEd;
  final DateTime? fechaDeAdmision;
  final DateTime? fechaYHoraDeAlta;
  final double? diasDeHospitalizacion;
  final int? uciDias;
  final String? detallesDeHospitalizacion;
  final String? disposicionODestinoDelPacienteDelHospitalizacion;
  final String? donacionDeOrganosDelHospitalizacion;
  final String? autopsiaDelHospitalizacion;
  final String? muertePrevenibleDelHospitalizacion;
  final String? numeroDeReferenciaDelHospitalizacion;
  final String? agenciaDeTransporte;
  final String? origenDelTransporte;
  final String? numeroDeRegistroDelTransporte;
  final DateTime? fechaYHoraDeNotificacionPreHospitalaria;
  final DateTime? fechaYHoraDeLlegadaALaEscena;
  final DateTime? fechaYHoraDeSalidaDeLaEscena;
  final String? razonDeLaDemora;
  final bool? reporteOFormularioPreHospitalarioEntregado;
  final String? ciudadHospitalMasCercanoAlSitioDelIncidente;
  final int? tiempoDeExtricacionHoras;
  final int? tiempoDeExtricacionMinutos;
  final int? duracionDelTransporteHoras;
  final int? duracionDelTransporteMinutos;
  final String? procedimientoRealizado;
  final int? frecuenciaCardiacaEnLaEscena;
  final int? presionArterialSistolicaEnLaEscena;
  final int? presionArterialDiastolicaEnLaEscena;
  final int? frecuenciaRespiratoriaEnLaEscena;
  final String? calificadorDeFrecuenciaRespiratoriaEnLaEscena;
  final double? temperaturaEnLaEscenaCelsius;
  final int? saturacionDeO2EnLaEscena;
  final int? frecuenciaCardiacaDuranteElTransporte;
  final int? presionArterialSistolicaDeTransporte;
  final int? presionDiastolicaDuranteElTransporte;
  final int? frecuenciaRespiratoriaDuranteElTransporte;
  final String? calificadorDeFrecuenciaRespiratoriaDuranteElTransporte;
  final double? temperaturaDuranteElTransporteCelsius;
  final int? saturacionDeO2DuranteElTransporte;
  final int? perdidaDeConciencia;
  final TimeOfDay? duracionDePerdidaDeConciencia;
  final int? gcsOcular;
  final int? gcsVerbal;
  final int? gcsMotora;
  final int? gcsTotal;
  final double? sangreL;
  final double? coloidesL;
  final double? cristaloidesL;
  final String? hallazgosClinicosTexto;
  final DateTime? fechaYHoraDeEnvioDeContraReferencia;
  final DateTime? fechaDeAltaDeContrarReferencia;
  final bool? hallazgosClinicosExistencia;
  final String? servicioQueAtendio;
  final bool? pacienteAdmitido;
  final String? hospitalQueRecibe;
  final String? otroServicio;
  final String? servicioQueRecibe;
  final String? recomendaciones;
  final String? numeroDeReferenciaDeReferenciasSalientes;
  final DateTime? fechaDeEnvioDeReferencia;
  final DateTime? fechaDeReferencia;
  final String? razonDeLaReferencia;
  final String? medicoQueRefiere;
  final String? estadoDeReferencia;
  final DateTime? fechaDeAceptacionDeReferencia;
  final int? iss;
  final int? kts;
  final double? rts;
  final int? abdomen;
  final int? torax;
  final int? externo;
  final int? extremidades;
  final int? cara;
  final int? cabeza;
  final double? trissContuso;
  final double? trissPenetrante;

  HealthcareRecord({
    this.id,
    this.numeroDeHistoriaClinica,
    this.hospital,
    this.fechaYHoraDeLlegadaDelPaciente,
    this.referido,
    this.policiaNotificada,
    this.fechaYHoraDeLlegadaDelMedico,
    this.fechaYHoraDeNotificacionAlMedico,
    this.alertaEquipoDeTrauma,
    this.nivelDeAlerta,
    this.pacienteAsegurado,
    this.tipoDeSeguro,
    this.motivoDeConsulta,
    this.inmunizacionContraElTetanos,
    this.descripcionDelExamenFisico,
    this.mecanismoPrimario,
    this.numeroDeLesionesSerias,
    this.descripcionDelDiagnostico,
    this.disposicionODestinoDelPaciente,
    this.donacionDeOrganos,
    this.autopsia,
    this.muertePrevenible,
    this.tipoDeAdmision,
    this.fechaYHoraDeLaDisposicion,
    this.tiempoEnSalaDeEmergenciasHoras,
    this.tiempoEnSalaDeEmergenciasMinutos,
    this.numeroDeReferenciaDelEd,
    this.fechaDeAdmision,
    this.fechaYHoraDeAlta,
    this.diasDeHospitalizacion,
    this.uciDias,
    this.detallesDeHospitalizacion,
    this.disposicionODestinoDelPacienteDelHospitalizacion,
    this.donacionDeOrganosDelHospitalizacion,
    this.autopsiaDelHospitalizacion,
    this.muertePrevenibleDelHospitalizacion,
    this.numeroDeReferenciaDelHospitalizacion,
    this.agenciaDeTransporte,
    this.origenDelTransporte,
    this.numeroDeRegistroDelTransporte,
    this.fechaYHoraDeNotificacionPreHospitalaria,
    this.fechaYHoraDeLlegadaALaEscena,
    this.fechaYHoraDeSalidaDeLaEscena,
    this.razonDeLaDemora,
    this.reporteOFormularioPreHospitalarioEntregado,
    this.ciudadHospitalMasCercanoAlSitioDelIncidente,
    this.tiempoDeExtricacionHoras,
    this.tiempoDeExtricacionMinutos,
    this.duracionDelTransporteHoras,
    this.duracionDelTransporteMinutos,
    this.procedimientoRealizado,
    this.frecuenciaCardiacaEnLaEscena,
    this.presionArterialSistolicaEnLaEscena,
    this.presionArterialDiastolicaEnLaEscena,
    this.frecuenciaRespiratoriaEnLaEscena,
    this.calificadorDeFrecuenciaRespiratoriaEnLaEscena,
    this.temperaturaEnLaEscenaCelsius,
    this.saturacionDeO2EnLaEscena,
    this.frecuenciaCardiacaDuranteElTransporte,
    this.presionArterialSistolicaDeTransporte,
    this.presionDiastolicaDuranteElTransporte,
    this.frecuenciaRespiratoriaDuranteElTransporte,
    this.calificadorDeFrecuenciaRespiratoriaDuranteElTransporte,
    this.temperaturaDuranteElTransporteCelsius,
    this.saturacionDeO2DuranteElTransporte,
    this.perdidaDeConciencia,
    this.duracionDePerdidaDeConciencia,
    this.gcsOcular,
    this.gcsVerbal,
    this.gcsMotora,
    this.gcsTotal,
    this.sangreL,
    this.coloidesL,
    this.cristaloidesL,
    this.hallazgosClinicosTexto,
    this.fechaYHoraDeEnvioDeContraReferencia,
    this.fechaDeAltaDeContrarReferencia,
    this.hallazgosClinicosExistencia,
    this.servicioQueAtendio,
    this.pacienteAdmitido,
    this.hospitalQueRecibe,
    this.otroServicio,
    this.servicioQueRecibe,
    this.recomendaciones,
    this.numeroDeReferenciaDeReferenciasSalientes,
    this.fechaDeEnvioDeReferencia,
    this.fechaDeReferencia,
    this.razonDeLaReferencia,
    this.medicoQueRefiere,
    this.estadoDeReferencia,
    this.fechaDeAceptacionDeReferencia,
    this.iss,
    this.kts,
    this.rts,
    this.abdomen,
    this.torax,
    this.externo,
    this.extremidades,
    this.cara,
    this.cabeza,
    this.trissContuso,
    this.trissPenetrante,
  });

  HealthcareRecord copyWith({
    int? id,
    String? numeroDeHistoriaClinica,
    String? hospital,
    DateTime? fechaYHoraDeLlegadaDelPaciente,
    bool? referido,
    bool? policiaNotificada,
    DateTime? fechaYHoraDeLlegadaDelMedico,
    DateTime? fechaYHoraDeNotificacionAlMedico,
    bool? alertaEquipoDeTrauma,
    String? nivelDeAlerta,
    bool? pacienteAsegurado,
    String? tipoDeSeguro,
    String? motivoDeConsulta,
    String? inmunizacionContraElTetanos,
    String? descripcionDelExamenFisico,
    String? mecanismoPrimario,
    String? numeroDeLesionesSerias,
    String? descripcionDelDiagnostico,
    String? disposicionODestinoDelPaciente,
    String? donacionDeOrganos,
    String? autopsia,
    String? muertePrevenible,
    String? tipoDeAdmision,
    DateTime? fechaYHoraDeLaDisposicion,
    int? tiempoEnSalaDeEmergenciasHoras,
    int? tiempoEnSalaDeEmergenciasMinutos,
    String? numeroDeReferenciaDelEd,
    DateTime? fechaDeAdmision,
    DateTime? fechaYHoraDeAlta,
    double? diasDeHospitalizacion,
    int? uciDias,
    String? detallesDeHospitalizacion,
    String? disposicionODestinoDelPacienteDelHospitalizacion,
    String? donacionDeOrganosDelHospitalizacion,
    String? autopsiaDelHospitalizacion,
    String? muertePrevenibleDelHospitalizacion,
    String? numeroDeReferenciaDelHospitalizacion,
    String? agenciaDeTransporte,
    String? origenDelTransporte,
    String? numeroDeRegistroDelTransporte,
    DateTime? fechaYHoraDeNotificacionPreHospitalaria,
    DateTime? fechaYHoraDeLlegadaALaEscena,
    DateTime? fechaYHoraDeSalidaDeLaEscena,
    String? razonDeLaDemora,
    bool? reporteOFormularioPreHospitalarioEntregado,
    String? ciudadHospitalMasCercanoAlSitioDelIncidente,
    int? tiempoDeExtricacionHoras,
    int? tiempoDeExtricacionMinutos,
    int? duracionDelTransporteHoras,
    int? duracionDelTransporteMinutos,
    String? procedimientoRealizado,
    int? frecuenciaCardiacaEnLaEscena,
    int? presionArterialSistolicaEnLaEscena,
    int? presionArterialDiastolicaEnLaEscena,
    int? frecuenciaRespiratoriaEnLaEscena,
    String? calificadorDeFrecuenciaRespiratoriaEnLaEscena,
    double? temperaturaEnLaEscenaCelsius,
    int? saturacionDeO2EnLaEscena,
    int? frecuenciaCardiacaDuranteElTransporte,
    int? presionArterialSistolicaDeTransporte,
    int? presionDiastolicaDuranteElTransporte,
    int? frecuenciaRespiratoriaDuranteElTransporte,
    String? calificadorDeFrecuenciaRespiratoriaDuranteElTransporte,
    double? temperaturaDuranteElTransporteCelsius,
    int? saturacionDeO2DuranteElTransporte,
    int? perdidaDeConciencia,
    TimeOfDay? duracionDePerdidaDeConciencia,
    int? gcsOcular,
    int? gcsVerbal,
    int? gcsMotora,
    int? gcsTotal,
    double? sangreL,
    double? coloidesL,
    double? cristaloidesL,
    String? hallazgosClinicosTexto,
    DateTime? fechaYHoraDeEnvioDeContraReferencia,
    DateTime? fechaDeAltaDeContrarReferencia,
    bool? hallazgosClinicosExistencia,
    String? servicioQueAtendio,
    bool? pacienteAdmitido,
    String? hospitalQueRecibe,
    String? otroServicio,
    String? servicioQueRecibe,
    String? recomendaciones,
    String? numeroDeReferenciaDeReferenciasSalientes,
    DateTime? fechaDeEnvioDeReferencia,
    DateTime? fechaDeReferencia,
    String? razonDeLaReferencia,
    String? medicoQueRefiere,
    String? estadoDeReferencia,
    DateTime? fechaDeAceptacionDeReferencia,
    int? iss,
    int? kts,
    double? rts,
    int? abdomen,
    int? torax,
    int? externo,
    int? extremidades,
    int? cara,
    int? cabeza,
    double? trissContuso,
    double? trissPenetrante,
  }) =>
      HealthcareRecord(
        id: id ?? this.id,
        numeroDeHistoriaClinica:
            numeroDeHistoriaClinica ?? this.numeroDeHistoriaClinica,
        hospital: hospital ?? this.hospital,
        fechaYHoraDeLlegadaDelPaciente: fechaYHoraDeLlegadaDelPaciente ??
            this.fechaYHoraDeLlegadaDelPaciente,
        referido: referido ?? this.referido,
        policiaNotificada: policiaNotificada ?? this.policiaNotificada,
        fechaYHoraDeLlegadaDelMedico:
            fechaYHoraDeLlegadaDelMedico ?? this.fechaYHoraDeLlegadaDelMedico,
        fechaYHoraDeNotificacionAlMedico: fechaYHoraDeNotificacionAlMedico ??
            this.fechaYHoraDeNotificacionAlMedico,
        alertaEquipoDeTrauma: alertaEquipoDeTrauma ?? this.alertaEquipoDeTrauma,
        nivelDeAlerta: nivelDeAlerta ?? this.nivelDeAlerta,
        pacienteAsegurado: pacienteAsegurado ?? this.pacienteAsegurado,
        tipoDeSeguro: tipoDeSeguro ?? this.tipoDeSeguro,
        motivoDeConsulta: motivoDeConsulta ?? this.motivoDeConsulta,
        inmunizacionContraElTetanos:
            inmunizacionContraElTetanos ?? this.inmunizacionContraElTetanos,
        descripcionDelExamenFisico:
            descripcionDelExamenFisico ?? this.descripcionDelExamenFisico,
        mecanismoPrimario: mecanismoPrimario ?? this.mecanismoPrimario,
        numeroDeLesionesSerias:
            numeroDeLesionesSerias ?? this.numeroDeLesionesSerias,
        descripcionDelDiagnostico:
            descripcionDelDiagnostico ?? this.descripcionDelDiagnostico,
        disposicionODestinoDelPaciente: disposicionODestinoDelPaciente ??
            this.disposicionODestinoDelPaciente,
        donacionDeOrganos: donacionDeOrganos ?? this.donacionDeOrganos,
        autopsia: autopsia ?? this.autopsia,
        muertePrevenible: muertePrevenible ?? this.muertePrevenible,
        tipoDeAdmision: tipoDeAdmision ?? this.tipoDeAdmision,
        fechaYHoraDeLaDisposicion:
            fechaYHoraDeLaDisposicion ?? this.fechaYHoraDeLaDisposicion,
        tiempoEnSalaDeEmergenciasHoras: tiempoEnSalaDeEmergenciasHoras ??
            this.tiempoEnSalaDeEmergenciasHoras,
        tiempoEnSalaDeEmergenciasMinutos: tiempoEnSalaDeEmergenciasMinutos ??
            this.tiempoEnSalaDeEmergenciasMinutos,
        numeroDeReferenciaDelEd:
            numeroDeReferenciaDelEd ?? this.numeroDeReferenciaDelEd,
        fechaDeAdmision: fechaDeAdmision ?? this.fechaDeAdmision,
        fechaYHoraDeAlta: fechaYHoraDeAlta ?? this.fechaYHoraDeAlta,
        diasDeHospitalizacion:
            diasDeHospitalizacion ?? this.diasDeHospitalizacion,
        uciDias: uciDias ?? this.uciDias,
        detallesDeHospitalizacion:
            detallesDeHospitalizacion ?? this.detallesDeHospitalizacion,
        disposicionODestinoDelPacienteDelHospitalizacion:
            disposicionODestinoDelPacienteDelHospitalizacion ??
                this.disposicionODestinoDelPacienteDelHospitalizacion,
        donacionDeOrganosDelHospitalizacion:
            donacionDeOrganosDelHospitalizacion ??
                this.donacionDeOrganosDelHospitalizacion,
        autopsiaDelHospitalizacion:
            autopsiaDelHospitalizacion ?? this.autopsiaDelHospitalizacion,
        muertePrevenibleDelHospitalizacion:
            muertePrevenibleDelHospitalizacion ??
                this.muertePrevenibleDelHospitalizacion,
        numeroDeReferenciaDelHospitalizacion:
            numeroDeReferenciaDelHospitalizacion ??
                this.numeroDeReferenciaDelHospitalizacion,
        agenciaDeTransporte: agenciaDeTransporte ?? this.agenciaDeTransporte,
        origenDelTransporte: origenDelTransporte ?? this.origenDelTransporte,
        numeroDeRegistroDelTransporte:
            numeroDeRegistroDelTransporte ?? this.numeroDeRegistroDelTransporte,
        fechaYHoraDeNotificacionPreHospitalaria:
            fechaYHoraDeNotificacionPreHospitalaria ??
                this.fechaYHoraDeNotificacionPreHospitalaria,
        fechaYHoraDeLlegadaALaEscena:
            fechaYHoraDeLlegadaALaEscena ?? this.fechaYHoraDeLlegadaALaEscena,
        fechaYHoraDeSalidaDeLaEscena:
            fechaYHoraDeSalidaDeLaEscena ?? this.fechaYHoraDeSalidaDeLaEscena,
        razonDeLaDemora: razonDeLaDemora ?? this.razonDeLaDemora,
        reporteOFormularioPreHospitalarioEntregado:
            reporteOFormularioPreHospitalarioEntregado ??
                this.reporteOFormularioPreHospitalarioEntregado,
        ciudadHospitalMasCercanoAlSitioDelIncidente:
            ciudadHospitalMasCercanoAlSitioDelIncidente ??
                this.ciudadHospitalMasCercanoAlSitioDelIncidente,
        tiempoDeExtricacionHoras:
            tiempoDeExtricacionHoras ?? this.tiempoDeExtricacionHoras,
        tiempoDeExtricacionMinutos:
            tiempoDeExtricacionMinutos ?? this.tiempoDeExtricacionMinutos,
        duracionDelTransporteHoras:
            duracionDelTransporteHoras ?? this.duracionDelTransporteHoras,
        duracionDelTransporteMinutos:
            duracionDelTransporteMinutos ?? this.duracionDelTransporteMinutos,
        procedimientoRealizado:
            procedimientoRealizado ?? this.procedimientoRealizado,
        frecuenciaCardiacaEnLaEscena:
            frecuenciaCardiacaEnLaEscena ?? this.frecuenciaCardiacaEnLaEscena,
        presionArterialSistolicaEnLaEscena:
            presionArterialSistolicaEnLaEscena ??
                this.presionArterialSistolicaEnLaEscena,
        presionArterialDiastolicaEnLaEscena:
            presionArterialDiastolicaEnLaEscena ??
                this.presionArterialDiastolicaEnLaEscena,
        frecuenciaRespiratoriaEnLaEscena: frecuenciaRespiratoriaEnLaEscena ??
            this.frecuenciaRespiratoriaEnLaEscena,
        calificadorDeFrecuenciaRespiratoriaEnLaEscena:
            calificadorDeFrecuenciaRespiratoriaEnLaEscena ??
                this.calificadorDeFrecuenciaRespiratoriaEnLaEscena,
        temperaturaEnLaEscenaCelsius:
            temperaturaEnLaEscenaCelsius ?? this.temperaturaEnLaEscenaCelsius,
        saturacionDeO2EnLaEscena:
            saturacionDeO2EnLaEscena ?? this.saturacionDeO2EnLaEscena,
        frecuenciaCardiacaDuranteElTransporte:
            frecuenciaCardiacaDuranteElTransporte ??
                this.frecuenciaCardiacaDuranteElTransporte,
        presionArterialSistolicaDeTransporte:
            presionArterialSistolicaDeTransporte ??
                this.presionArterialSistolicaDeTransporte,
        presionDiastolicaDuranteElTransporte:
            presionDiastolicaDuranteElTransporte ??
                this.presionDiastolicaDuranteElTransporte,
        frecuenciaRespiratoriaDuranteElTransporte:
            frecuenciaRespiratoriaDuranteElTransporte ??
                this.frecuenciaRespiratoriaDuranteElTransporte,
        calificadorDeFrecuenciaRespiratoriaDuranteElTransporte:
            calificadorDeFrecuenciaRespiratoriaDuranteElTransporte ??
                this.calificadorDeFrecuenciaRespiratoriaDuranteElTransporte,
        temperaturaDuranteElTransporteCelsius:
            temperaturaDuranteElTransporteCelsius ??
                this.temperaturaDuranteElTransporteCelsius,
        saturacionDeO2DuranteElTransporte: saturacionDeO2DuranteElTransporte ??
            this.saturacionDeO2DuranteElTransporte,
        perdidaDeConciencia: perdidaDeConciencia ?? this.perdidaDeConciencia,
        duracionDePerdidaDeConciencia:
            duracionDePerdidaDeConciencia ?? this.duracionDePerdidaDeConciencia,
        gcsOcular: gcsOcular ?? this.gcsOcular,
        gcsVerbal: gcsVerbal ?? this.gcsVerbal,
        gcsMotora: gcsMotora ?? this.gcsMotora,
        gcsTotal: gcsTotal ?? this.gcsTotal,
        sangreL: sangreL ?? this.sangreL,
        coloidesL: coloidesL ?? this.coloidesL,
        cristaloidesL: cristaloidesL ?? this.cristaloidesL,
        hallazgosClinicosTexto:
            hallazgosClinicosTexto ?? this.hallazgosClinicosTexto,
        fechaYHoraDeEnvioDeContraReferencia:
            fechaYHoraDeEnvioDeContraReferencia ??
                this.fechaYHoraDeEnvioDeContraReferencia,
        fechaDeAltaDeContrarReferencia: fechaDeAltaDeContrarReferencia ??
            this.fechaDeAltaDeContrarReferencia,
        hallazgosClinicosExistencia:
            hallazgosClinicosExistencia ?? this.hallazgosClinicosExistencia,
        servicioQueAtendio: servicioQueAtendio ?? this.servicioQueAtendio,
        pacienteAdmitido: pacienteAdmitido ?? this.pacienteAdmitido,
        hospitalQueRecibe: hospitalQueRecibe ?? this.hospitalQueRecibe,
        otroServicio: otroServicio ?? this.otroServicio,
        servicioQueRecibe: servicioQueRecibe ?? this.servicioQueRecibe,
        recomendaciones: recomendaciones ?? this.recomendaciones,
        numeroDeReferenciaDeReferenciasSalientes:
            numeroDeReferenciaDeReferenciasSalientes ??
                this.numeroDeReferenciaDeReferenciasSalientes,
        fechaDeEnvioDeReferencia:
            fechaDeEnvioDeReferencia ?? this.fechaDeEnvioDeReferencia,
        fechaDeReferencia: fechaDeReferencia ?? this.fechaDeReferencia,
        razonDeLaReferencia: razonDeLaReferencia ?? this.razonDeLaReferencia,
        medicoQueRefiere: medicoQueRefiere ?? this.medicoQueRefiere,
        estadoDeReferencia: estadoDeReferencia ?? this.estadoDeReferencia,
        fechaDeAceptacionDeReferencia:
            fechaDeAceptacionDeReferencia ?? this.fechaDeAceptacionDeReferencia,
        iss: iss ?? this.iss,
        kts: kts ?? this.kts,
        rts: rts ?? this.rts,
        abdomen: abdomen ?? this.abdomen,
        torax: torax ?? this.torax,
        externo: externo ?? this.externo,
        extremidades: extremidades ?? this.extremidades,
        cara: cara ?? this.cara,
        cabeza: cabeza ?? this.cabeza,
        trissContuso: trissContuso ?? this.trissContuso,
        trissPenetrante: trissPenetrante ?? this.trissPenetrante,
      );

  factory HealthcareRecord.fromJson(Map<String, dynamic> json) =>
      HealthcareRecord(
        id: json["id"],
        numeroDeHistoriaClinica: json["numero_de_historia_clinica"],
        hospital: json["hospital"],
        fechaYHoraDeLlegadaDelPaciente:
            json["fecha_y_hora_de_llegada_del_paciente"] == null
                ? null
                : DateTime.parse(json["fecha_y_hora_de_llegada_del_paciente"]),
        referido: json["referido"],
        policiaNotificada: json["policia_notificada"],
        fechaYHoraDeLlegadaDelMedico:
            json["fecha_y_hora_de_llegada_del_medico"] == null
                ? null
                : DateTime.parse(json["fecha_y_hora_de_llegada_del_medico"]),
        fechaYHoraDeNotificacionAlMedico:
            json["fecha_y_hora_de_notificacion_al_medico"] == null
                ? null
                : DateTime.parse(
                    json["fecha_y_hora_de_notificacion_al_medico"]),
        alertaEquipoDeTrauma: json["alerta_equipo_de_trauma"],
        nivelDeAlerta: json["nivel_de_alerta"],
        pacienteAsegurado: json["paciente_asegurado"],
        tipoDeSeguro: json["tipo_de_seguro"],
        motivoDeConsulta: json["motivo_de_consulta"],
        inmunizacionContraElTetanos: json["inmunizacion_contra_el_tetanos"],
        descripcionDelExamenFisico: json["descripcion_del_examen_fisico"],
        mecanismoPrimario: json["mecanismo_primario"],
        numeroDeLesionesSerias: json["numero_de_lesiones_serias"],
        descripcionDelDiagnostico: json["descripcion_del_diagnostico"],
        disposicionODestinoDelPaciente:
            json["disposicion_o_destino_del_paciente"],
        donacionDeOrganos: json["donacion_de_organos"],
        autopsia: json["autopsia"],
        muertePrevenible: json["muerte_prevenible"],
        tipoDeAdmision: json["tipo_de_admision"],
        fechaYHoraDeLaDisposicion:
            json["fecha_y_hora_de_la_disposicion"] == null
                ? null
                : DateTime.parse(json["fecha_y_hora_de_la_disposicion"]),
        tiempoEnSalaDeEmergenciasHoras:
            json["tiempo_en_sala_de_emergencias_horas"],
        tiempoEnSalaDeEmergenciasMinutos:
            json["tiempo_en_sala_de_emergencias_minutos"],
        numeroDeReferenciaDelEd: json["numero_de_referencia_del_ed"],
        fechaDeAdmision: json["fecha_de_admision"] == null
            ? null
            : DateTime.parse(json["fecha_de_admision"]),
        fechaYHoraDeAlta: json["fecha_y_hora_de_alta"] == null
            ? null
            : DateTime.parse(json["fecha_y_hora_de_alta"]),
        diasDeHospitalizacion:
            double.tryParse(json["dias_de_hospitalizacion"].toString()),
        uciDias: json["uci_dias"],
        detallesDeHospitalizacion: json["detalles_de_hospitalizacion"],
        disposicionODestinoDelPacienteDelHospitalizacion:
            json["disposicion_o_destino_del_paciente_del_hospitalizacion"],
        donacionDeOrganosDelHospitalizacion:
            json["donacion_de_organos_del_hospitalizacion"],
        autopsiaDelHospitalizacion: json["autopsia_del_hospitalizacion"],
        muertePrevenibleDelHospitalizacion:
            json["muerte_prevenible_del_hospitalizacion"],
        numeroDeReferenciaDelHospitalizacion:
            json["numero_de_referencia_del_hospitalizacion"],
        agenciaDeTransporte: json["agencia_de_transporte"],
        origenDelTransporte: json["origen_del_transporte"],
        numeroDeRegistroDelTransporte:
            json["numero_de_registro_del_transporte"],
        fechaYHoraDeNotificacionPreHospitalaria:
            json["fecha_y_hora_de_notificacion_pre_hospitalaria"] == null
                ? null
                : DateTime.parse(
                    json["fecha_y_hora_de_notificacion_pre_hospitalaria"]),
        fechaYHoraDeLlegadaALaEscena:
            json["fecha_y_hora_de_llegada_a_la_escena"] == null
                ? null
                : DateTime.parse(json["fecha_y_hora_de_llegada_a_la_escena"]),
        fechaYHoraDeSalidaDeLaEscena:
            json["fecha_y_hora_de_salida_de_la_escena"] == null
                ? null
                : DateTime.parse(json["fecha_y_hora_de_salida_de_la_escena"]),
        razonDeLaDemora: json["razon_de_la_demora"],
        reporteOFormularioPreHospitalarioEntregado:
            json["reporte_o_formulario_pre_hospitalario_entregado"],
        ciudadHospitalMasCercanoAlSitioDelIncidente:
            json["ciudad_hospital_mas_cercano_al_sitio_del_incidente"],
        tiempoDeExtricacionHoras: json["tiempo_de_extricacion_horas"],
        tiempoDeExtricacionMinutos: json["tiempo_de_extricacion_minutos"],
        duracionDelTransporteHoras: json["duracion_del_transporte_horas"],
        duracionDelTransporteMinutos: json["duracion_del_transporte_minutos"],
        procedimientoRealizado: json["procedimiento_realizado"],
        frecuenciaCardiacaEnLaEscena: json["frecuencia_cardiaca_en_la_escena"],
        presionArterialSistolicaEnLaEscena:
            json["presion_arterial_sistolica_en_la_escena"],
        presionArterialDiastolicaEnLaEscena:
            json["presion_arterial_diastolica_en_la_escena"],
        frecuenciaRespiratoriaEnLaEscena:
            json["frecuencia_respiratoria_en_la_escena"],
        calificadorDeFrecuenciaRespiratoriaEnLaEscena:
            json["calificador_de_frecuencia_respiratoria_en_la_escena"],
        temperaturaEnLaEscenaCelsius: double.tryParse(
            json["temperatura_en_la_escena_celsius"].toString()),
        saturacionDeO2EnLaEscena: json["saturacion_de_o2_en_la_escena"],
        frecuenciaCardiacaDuranteElTransporte:
            json["frecuencia_cardiaca_durante_el_transporte"],
        presionArterialSistolicaDeTransporte:
            json["presion_arterial_sistolica_de_transporte"],
        presionDiastolicaDuranteElTransporte:
            json["presion_diastolica_durante_el_transporte"],
        frecuenciaRespiratoriaDuranteElTransporte:
            json["frecuencia_respiratoria_durante_el_transporte"],
        calificadorDeFrecuenciaRespiratoriaDuranteElTransporte: json[
            "calificador_de_frecuencia_respiratoria_durante_el_transporte"],
        temperaturaDuranteElTransporteCelsius: double.tryParse(
            json["temperatura_durante_el_transporte_celsius"].toString()),
        saturacionDeO2DuranteElTransporte:
            json["saturacion_de_o2_durante_el_transporte"],
        perdidaDeConciencia: json["perdida_de_conciencia"],
        duracionDePerdidaDeConciencia:
            json["duracion_de_perdida_de_conciencia"] == null
                ? null
                : TimeOfDay.fromString(
                    json["duracion_de_perdida_de_conciencia"]),
        gcsOcular: json["gcs_ocular"],
        gcsVerbal: json["gcs_verbal"],
        gcsMotora: json["gcs_motora"],
        gcsTotal: json["gcs_total"],
        sangreL: double.tryParse(json["sangre_l"].toString()),
        coloidesL: double.tryParse(json["coloides_l"].toString()),
        cristaloidesL: double.tryParse(json["cristaloides_l"].toString()),
        hallazgosClinicosTexto: json["hallazgos_clinicos_texto"],
        fechaYHoraDeEnvioDeContraReferencia:
            json["fecha_y_hora_de_envio_de_contra_referencia"] == null
                ? null
                : DateTime.parse(
                    json["fecha_y_hora_de_envio_de_contra_referencia"]),
        fechaDeAltaDeContrarReferencia:
            json["fecha_de_alta_de_contrar_referencia"] == null
                ? null
                : DateTime.parse(json["fecha_de_alta_de_contrar_referencia"]),
        hallazgosClinicosExistencia: json["hallazgos_clinicos_existencia"],
        servicioQueAtendio: json["servicio_que_atendio"],
        pacienteAdmitido: json["paciente_admitido"],
        hospitalQueRecibe: json["hospital_que_recibe"],
        otroServicio: json["otro_servicio"],
        servicioQueRecibe: json["servicio_que_recibe"],
        recomendaciones: json["recomendaciones"],
        numeroDeReferenciaDeReferenciasSalientes:
            json["numero_de_referencia_de_referencias_salientes"],
        fechaDeEnvioDeReferencia: json["fecha_de_envio_de_referencia"] == null
            ? null
            : DateTime.parse(json["fecha_de_envio_de_referencia"]),
        fechaDeReferencia: json["fecha_de_referencia"] == null
            ? null
            : DateTime.parse(json["fecha_de_referencia"]),
        razonDeLaReferencia: json["razon_de_la_referencia"],
        medicoQueRefiere: json["medico_que_refiere"],
        estadoDeReferencia: json["estado_de_referencia"],
        fechaDeAceptacionDeReferencia:
            json["fecha_de_aceptacion_de_referencia"] == null
                ? null
                : DateTime.parse(json["fecha_de_aceptacion_de_referencia"]),
        iss: json["iss"],
        kts: json["kts"],
        rts: double.tryParse(json["rts"].toString()),
        abdomen: json["abdomen"],
        torax: json["torax"],
        externo: json["externo"],
        extremidades: json["extremidades"],
        cara: json["cara"],
        cabeza: json["cabeza"],
        trissContuso: double.tryParse(json["triss_contuso"].toString()),
        trissPenetrante: double.tryParse(json["triss_penetrante"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "numero_de_historia_clinica": numeroDeHistoriaClinica,
        "hospital": hospital,
        "fecha_y_hora_de_llegada_del_paciente":
            fechaYHoraDeLlegadaDelPaciente?.toIso8601String(),
        "referido": referido,
        "policia_notificada": policiaNotificada,
        "fecha_y_hora_de_llegada_del_medico":
            fechaYHoraDeLlegadaDelMedico?.toIso8601String(),
        "fecha_y_hora_de_notificacion_al_medico":
            fechaYHoraDeNotificacionAlMedico?.toIso8601String(),
        "alerta_equipo_de_trauma": alertaEquipoDeTrauma,
        "nivel_de_alerta": nivelDeAlerta,
        "paciente_asegurado": pacienteAsegurado,
        "tipo_de_seguro": tipoDeSeguro,
        "motivo_de_consulta": motivoDeConsulta,
        "inmunizacion_contra_el_tetanos": inmunizacionContraElTetanos,
        "descripcion_del_examen_fisico": descripcionDelExamenFisico,
        "mecanismo_primario": mecanismoPrimario,
        "numero_de_lesiones_serias": numeroDeLesionesSerias,
        "descripcion_del_diagnostico": descripcionDelDiagnostico,
        "disposicion_o_destino_del_paciente": disposicionODestinoDelPaciente,
        "donacion_de_organos": donacionDeOrganos,
        "autopsia": autopsia,
        "muerte_prevenible": muertePrevenible,
        "tipo_de_admision": tipoDeAdmision,
        "fecha_y_hora_de_la_disposicion":
            fechaYHoraDeLaDisposicion?.toIso8601String(),
        "tiempo_en_sala_de_emergencias_horas": tiempoEnSalaDeEmergenciasHoras,
        "tiempo_en_sala_de_emergencias_minutos":
            tiempoEnSalaDeEmergenciasMinutos,
        "numero_de_referencia_del_ed": numeroDeReferenciaDelEd,
        "fecha_de_admision":
            "${fechaDeAdmision!.year.toString().padLeft(4, '0')}-${fechaDeAdmision!.month.toString().padLeft(2, '0')}-${fechaDeAdmision!.day.toString().padLeft(2, '0')}",
        "fecha_y_hora_de_alta": fechaYHoraDeAlta?.toIso8601String(),
        "dias_de_hospitalizacion": diasDeHospitalizacion,
        "uci_dias": uciDias,
        "detalles_de_hospitalizacion": detallesDeHospitalizacion,
        "disposicion_o_destino_del_paciente_del_hospitalizacion":
            disposicionODestinoDelPacienteDelHospitalizacion,
        "donacion_de_organos_del_hospitalizacion":
            donacionDeOrganosDelHospitalizacion,
        "autopsia_del_hospitalizacion": autopsiaDelHospitalizacion,
        "muerte_prevenible_del_hospitalizacion":
            muertePrevenibleDelHospitalizacion,
        "numero_de_referencia_del_hospitalizacion":
            numeroDeReferenciaDelHospitalizacion,
        "agencia_de_transporte": agenciaDeTransporte,
        "origen_del_transporte": origenDelTransporte,
        "numero_de_registro_del_transporte": numeroDeRegistroDelTransporte,
        "fecha_y_hora_de_notificacion_pre_hospitalaria":
            fechaYHoraDeNotificacionPreHospitalaria?.toIso8601String(),
        "fecha_y_hora_de_llegada_a_la_escena":
            fechaYHoraDeLlegadaALaEscena?.toIso8601String(),
        "fecha_y_hora_de_salida_de_la_escena":
            fechaYHoraDeSalidaDeLaEscena?.toIso8601String(),
        "razon_de_la_demora": razonDeLaDemora,
        "reporte_o_formulario_pre_hospitalario_entregado":
            reporteOFormularioPreHospitalarioEntregado,
        "ciudad_hospital_mas_cercano_al_sitio_del_incidente":
            ciudadHospitalMasCercanoAlSitioDelIncidente,
        "tiempo_de_extricacion_horas": tiempoDeExtricacionHoras,
        "tiempo_de_extricacion_minutos": tiempoDeExtricacionMinutos,
        "duracion_del_transporte_horas": duracionDelTransporteHoras,
        "duracion_del_transporte_minutos": duracionDelTransporteMinutos,
        "procedimiento_realizado": procedimientoRealizado,
        "frecuencia_cardiaca_en_la_escena": frecuenciaCardiacaEnLaEscena,
        "presion_arterial_sistolica_en_la_escena":
            presionArterialSistolicaEnLaEscena,
        "presion_arterial_diastolica_en_la_escena":
            presionArterialDiastolicaEnLaEscena,
        "frecuencia_respiratoria_en_la_escena":
            frecuenciaRespiratoriaEnLaEscena,
        "calificador_de_frecuencia_respiratoria_en_la_escena":
            calificadorDeFrecuenciaRespiratoriaEnLaEscena,
        "temperatura_en_la_escena_celsius": temperaturaEnLaEscenaCelsius,
        "saturacion_de_o2_en_la_escena": saturacionDeO2EnLaEscena,
        "frecuencia_cardiaca_durante_el_transporte":
            frecuenciaCardiacaDuranteElTransporte,
        "presion_arterial_sistolica_de_transporte":
            presionArterialSistolicaDeTransporte,
        "presion_diastolica_durante_el_transporte":
            presionDiastolicaDuranteElTransporte,
        "frecuencia_respiratoria_durante_el_transporte":
            frecuenciaRespiratoriaDuranteElTransporte,
        "calificador_de_frecuencia_respiratoria_durante_el_transporte":
            calificadorDeFrecuenciaRespiratoriaDuranteElTransporte,
        "temperatura_durante_el_transporte_celsius":
            temperaturaDuranteElTransporteCelsius,
        "saturacion_de_o2_durante_el_transporte":
            saturacionDeO2DuranteElTransporte,
        "perdida_de_conciencia": perdidaDeConciencia,
        "duracion_de_perdida_de_conciencia":
            duracionDePerdidaDeConciencia.toString(),
        "gcs_ocular": gcsOcular,
        "gcs_verbal": gcsVerbal,
        "gcs_motora": gcsMotora,
        "gcs_total": gcsTotal,
        "sangre_l": sangreL,
        "coloides_l": coloidesL,
        "cristaloides_l": cristaloidesL,
        "hallazgos_clinicos_texto": hallazgosClinicosTexto,
        "fecha_y_hora_de_envio_de_contra_referencia":
            fechaYHoraDeEnvioDeContraReferencia?.toIso8601String(),
        "fecha_de_alta_de_contrar_referencia":
            fechaDeAltaDeContrarReferencia?.toIso8601String(),
        "hallazgos_clinicos_existencia": hallazgosClinicosExistencia,
        "servicio_que_atendio": servicioQueAtendio,
        "paciente_admitido": pacienteAdmitido,
        "hospital_que_recibe": hospitalQueRecibe,
        "otro_servicio": otroServicio,
        "servicio_que_recibe": servicioQueRecibe,
        "recomendaciones": recomendaciones,
        "numero_de_referencia_de_referencias_salientes":
            numeroDeReferenciaDeReferenciasSalientes,
        "fecha_de_envio_de_referencia":
            fechaDeEnvioDeReferencia?.toIso8601String(),
        "fecha_de_referencia":
            "${fechaDeReferencia!.year.toString().padLeft(4, '0')}-${fechaDeReferencia!.month.toString().padLeft(2, '0')}-${fechaDeReferencia!.day.toString().padLeft(2, '0')}",
        "razon_de_la_referencia": razonDeLaReferencia,
        "medico_que_refiere": medicoQueRefiere,
        "estado_de_referencia": estadoDeReferencia,
        "fecha_de_aceptacion_de_referencia":
            "${fechaDeAceptacionDeReferencia!.year.toString().padLeft(4, '0')}-${fechaDeAceptacionDeReferencia!.month.toString().padLeft(2, '0')}-${fechaDeAceptacionDeReferencia!.day.toString().padLeft(2, '0')}",
        "iss": iss,
        "kts": kts,
        "rts": rts,
        "abdomen": abdomen,
        "torax": torax,
        "externo": externo,
        "extremidades": extremidades,
        "cara": cara,
        "cabeza": cabeza,
        "triss_contuso": trissContuso,
        "triss_penetrante": trissPenetrante,
      };
}
