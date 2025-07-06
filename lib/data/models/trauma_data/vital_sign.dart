import 'package:trauma_register_frontend/data/models/custom/time_of_day.dart';
import 'package:trauma_register_frontend/data/models/shared/optional.dart';

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
  final TimeOfDay? duracionDePerdidaDeConciencia;
  final int? gcsMotora;
  final int? gcsOcular;
  final int? gcsVerbal;
  final int? gcsTotal;
  final String? avup;

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
  });

  VitalSign copyWith({
    Optional<int?>? recordId,
    Optional<DateTime?>? fechaYHoraDeSignosVitales,
    Optional<bool?>? signosDeVida,
    Optional<int?>? frecuenciaCardiaca,
    Optional<int?>? presionArterialSistolica,
    Optional<int?>? presionArterialDiastolica,
    Optional<int?>? frecuenciaRespiratoria,
    Optional<String?>? calificadorDeFrecuenciaRespiratoria,
    Optional<double?>? temperaturaCelsius,
    Optional<double?>? pesoKg,
    Optional<double?>? alturaMetros,
    Optional<double?>? saturacionDeOxigeno,
    Optional<String?>? perdidaDeConciencia,
    Optional<TimeOfDay?>? duracionDePerdidaDeConciencia,
    Optional<int?>? gcsMotora,
    Optional<int?>? gcsOcular,
    Optional<int?>? gcsVerbal,
    Optional<int?>? gcsTotal,
    Optional<String?>? avup,
  }) =>
      VitalSign(
        recordId: recordId?.isPresent == true ? recordId!.value : this.recordId,
        fechaYHoraDeSignosVitales: fechaYHoraDeSignosVitales?.isPresent == true
            ? fechaYHoraDeSignosVitales!.value
            : this.fechaYHoraDeSignosVitales,
        signosDeVida: signosDeVida?.isPresent == true
            ? signosDeVida!.value
            : this.signosDeVida,
        frecuenciaCardiaca: frecuenciaCardiaca?.isPresent == true
            ? frecuenciaCardiaca!.value
            : this.frecuenciaCardiaca,
        presionArterialSistolica: presionArterialSistolica?.isPresent == true
            ? presionArterialSistolica!.value
            : this.presionArterialSistolica,
        presionArterialDiastolica: presionArterialDiastolica?.isPresent == true
            ? presionArterialDiastolica!.value
            : this.presionArterialDiastolica,
        frecuenciaRespiratoria: frecuenciaRespiratoria?.isPresent == true
            ? frecuenciaRespiratoria!.value
            : this.frecuenciaRespiratoria,
        calificadorDeFrecuenciaRespiratoria:
            calificadorDeFrecuenciaRespiratoria?.isPresent == true
                ? calificadorDeFrecuenciaRespiratoria!.value
                : this.calificadorDeFrecuenciaRespiratoria,
        temperaturaCelsius: temperaturaCelsius?.isPresent == true
            ? temperaturaCelsius!.value
            : this.temperaturaCelsius,
        pesoKg: pesoKg?.isPresent == true ? pesoKg!.value : this.pesoKg,
        alturaMetros: alturaMetros?.isPresent == true
            ? alturaMetros!.value
            : this.alturaMetros,
        saturacionDeOxigeno: saturacionDeOxigeno?.isPresent == true
            ? saturacionDeOxigeno!.value
            : this.saturacionDeOxigeno,
        perdidaDeConciencia: perdidaDeConciencia?.isPresent == true
            ? perdidaDeConciencia!.value
            : this.perdidaDeConciencia,
        duracionDePerdidaDeConciencia:
            duracionDePerdidaDeConciencia?.isPresent == true
                ? duracionDePerdidaDeConciencia!.value
                : this.duracionDePerdidaDeConciencia,
        gcsMotora:
            gcsMotora?.isPresent == true ? gcsMotora!.value : this.gcsMotora,
        gcsOcular:
            gcsOcular?.isPresent == true ? gcsOcular!.value : this.gcsOcular,
        gcsVerbal:
            gcsVerbal?.isPresent == true ? gcsVerbal!.value : this.gcsVerbal,
        gcsTotal: gcsTotal?.isPresent == true ? gcsTotal!.value : this.gcsTotal,
        avup: avup?.isPresent == true ? avup!.value : this.avup,
      );

  factory VitalSign.fromJson(Map<String, dynamic> json) => VitalSign(
        recordId: json["record_id"],
        fechaYHoraDeSignosVitales:
            json["fecha_y_hora_de_signos_vitales"] == null
                ? null
                : DateTime.parse(json["fecha_y_hora_de_signos_vitales"]),
        signosDeVida: json["signos_de_vida"],
        frecuenciaCardiaca: json["frecuencia_cardiaca"],
        presionArterialSistolica: json["presion_arterial_sistolica"],
        presionArterialDiastolica: json["presion_arterial_diastolica"],
        frecuenciaRespiratoria: json["frecuencia_respiratoria"],
        calificadorDeFrecuenciaRespiratoria:
            json["calificador_de_frecuencia_respiratoria"],
        temperaturaCelsius:
            double.tryParse(json["temperatura_celsius"].toString()),
        pesoKg: double.tryParse(json["peso_kg"].toString()),
        alturaMetros: double.tryParse(json["altura_metros"].toString()),
        saturacionDeOxigeno:
            double.tryParse(json["saturacion_de_oxigeno"].toString()),
        perdidaDeConciencia: json["perdida_de_conciencia"],
        duracionDePerdidaDeConciencia:
            json["duracion_de_perdida_de_conciencia"] == null
                ? null
                : TimeOfDay.fromString(
                    json["duracion_de_perdida_de_conciencia"]),
        gcsMotora: json["gcs_motora"],
        gcsOcular: json["gcs_ocular"],
        gcsVerbal: json["gcs_verbal"],
        gcsTotal: json["gcs_total"],
        avup: json["avup"],
      );

  Map<String, dynamic> toJson() => {
        "record_id": recordId,
        "fecha_y_hora_de_signos_vitales":
            fechaYHoraDeSignosVitales?.toIso8601String(),
        "signos_de_vida": signosDeVida,
        "frecuencia_cardiaca": frecuenciaCardiaca,
        "presion_arterial_sistolica": presionArterialSistolica,
        "presion_arterial_diastolica": presionArterialDiastolica,
        "frecuencia_respiratoria": frecuenciaRespiratoria,
        "calificador_de_frecuencia_respiratoria":
            calificadorDeFrecuenciaRespiratoria,
        "temperatura_celsius": temperaturaCelsius,
        "peso_kg": pesoKg,
        "altura_metros": alturaMetros,
        "saturacion_de_oxigeno": saturacionDeOxigeno,
        "perdida_de_conciencia": perdidaDeConciencia,
        "duracion_de_perdida_de_conciencia":
            duracionDePerdidaDeConciencia?.toString(),
        "gcs_motora": gcsMotora,
        "gcs_ocular": gcsOcular,
        "gcs_verbal": gcsVerbal,
        "gcs_total": gcsTotal,
        "avup": avup,
      };
}
