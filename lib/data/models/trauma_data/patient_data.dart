import 'package:trauma_register_frontend/data/models/trauma_data/trauma_data.dart';


class PatientData {
    final int? traumaRegisterRecordId;
    final HealthcareRecord? healthcareRecord;
    final InjuryRecord? injuryRecord;
    final List<Collision>? collision;
    final List<DrugAbuse>? drugAbuse;
    final List<VitalSignGcsQualifier>? vitalSignGcsQualifier;
    final List<HospitalizationVariable>? hospitalizationVariable;
    final List<HospitalizationComplication>? hospitalizationComplication;
    final List<TraumaRegisterIcd10>? traumaRegisterIcd10;
    final List<IntensiveCareUnit>? intensiveCareUnit;
    final List<Imaging>? imaging;
    final List<ApparentIntentInjury>? apparentIntentInjury;
    final List<BurnInjury>? burnInjury;
    final List<FirearmInjury>? firearmInjury;
    final List<PenetratingInjury>? penetratingInjury;
    final List<PoisoningInjury>? poisoningInjury;
    final List<ViolenceInjury>? violenceInjury;
    final List<Device>? device;
    final List<Laboratory>? laboratory;
    final List<PhysicalExamBodyPartInjury>? physicalExamBodyPartInjury;
    final List<Procedure>? procedure;
    final List<PrehospitalProcedure>? prehospitalProcedure;
    final List<TransportationMode>? transportationMode;
    final List<VitalSign>? vitalSign;
    final String? direccionLinea1;
    final String? direccionLinea2;
    final String? ciudad;
    final String? cantonMunicipio;
    final String? provinciaEstado;
    final String? codigoPostal;
    final String? pais;
    final int? edad;
    final String? unidadDeEdad;
    final String? genero;
    final DateTime? fechaDeNacimiento;
    final String? ocupacion;
    final String? estadoCivil;
    final String? nacionalidad;
    final String? grupoEtnico;
    final String? otroGrupoEtnico;
    final String? numDocDeIdentificacion;

    PatientData({
        this.traumaRegisterRecordId,
        this.healthcareRecord,
        this.injuryRecord,
        this.collision,
        this.drugAbuse,
        this.vitalSignGcsQualifier,
        this.hospitalizationVariable,
        this.hospitalizationComplication,
        this.traumaRegisterIcd10,
        this.intensiveCareUnit,
        this.imaging,
        this.apparentIntentInjury,
        this.burnInjury,
        this.firearmInjury,
        this.penetratingInjury,
        this.poisoningInjury,
        this.violenceInjury,
        this.device,
        this.laboratory,
        this.physicalExamBodyPartInjury,
        this.procedure,
        this.prehospitalProcedure,
        this.transportationMode,
        this.vitalSign,
        this.direccionLinea1,
        this.direccionLinea2,
        this.ciudad,
        this.cantonMunicipio,
        this.provinciaEstado,
        this.codigoPostal,
        this.pais,
        this.edad,
        this.unidadDeEdad,
        this.genero,
        this.fechaDeNacimiento,
        this.ocupacion,
        this.estadoCivil,
        this.nacionalidad,
        this.grupoEtnico,
        this.otroGrupoEtnico,
        this.numDocDeIdentificacion,
    });

    PatientData copyWith({
        int? traumaRegisterRecordId,
        HealthcareRecord? healthcareRecord,
        InjuryRecord? injuryRecord,
        List<Collision>? collision,
        List<DrugAbuse>? drugAbuse,
        List<VitalSignGcsQualifier>? vitalSignGcsQualifier,
        List<HospitalizationVariable>? hospitalizationVariable,
        List<HospitalizationComplication>? hospitalizationComplication,
        List<TraumaRegisterIcd10>? traumaRegisterIcd10,
        List<IntensiveCareUnit>? intensiveCareUnit,
        List<Imaging>? imaging,
        List<ApparentIntentInjury>? apparentIntentInjury,
        List<BurnInjury>? burnInjury,
        List<FirearmInjury>? firearmInjury,
        List<PenetratingInjury>? penetratingInjury,
        List<PoisoningInjury>? poisoningInjury,
        List<ViolenceInjury>? violenceInjury,
        List<Device>? device,
        List<Laboratory>? laboratory,
        List<PhysicalExamBodyPartInjury>? physicalExamBodyPartInjury,
        List<Procedure>? procedure,
        List<PrehospitalProcedure>? prehospitalProcedure,
        List<TransportationMode>? transportationMode,
        List<VitalSign>? vitalSign,
        String? direccionLinea1,
        String? direccionLinea2,
        String? ciudad,
        String? cantonMunicipio,
        String? provinciaEstado,
        String? codigoPostal,
        String? pais,
        int? edad,
        String? unidadDeEdad,
        String? genero,
        DateTime? fechaDeNacimiento,
        String? ocupacion,
        String? estadoCivil,
        String? nacionalidad,
        String? grupoEtnico,
        String? otroGrupoEtnico,
        String? numDocDeIdentificacion,
    }) => 
        PatientData(
            traumaRegisterRecordId: traumaRegisterRecordId ?? this.traumaRegisterRecordId,
            healthcareRecord: healthcareRecord ?? this.healthcareRecord,
            injuryRecord: injuryRecord ?? this.injuryRecord,
            collision: collision ?? this.collision,
            drugAbuse: drugAbuse ?? this.drugAbuse,
            vitalSignGcsQualifier: vitalSignGcsQualifier ?? this.vitalSignGcsQualifier,
            hospitalizationVariable: hospitalizationVariable ?? this.hospitalizationVariable,
            hospitalizationComplication: hospitalizationComplication ?? this.hospitalizationComplication,
            traumaRegisterIcd10: traumaRegisterIcd10 ?? this.traumaRegisterIcd10,
            intensiveCareUnit: intensiveCareUnit ?? this.intensiveCareUnit,
            imaging: imaging ?? this.imaging,
            apparentIntentInjury: apparentIntentInjury ?? this.apparentIntentInjury,
            burnInjury: burnInjury ?? this.burnInjury,
            firearmInjury: firearmInjury ?? this.firearmInjury,
            penetratingInjury: penetratingInjury ?? this.penetratingInjury,
            poisoningInjury: poisoningInjury ?? this.poisoningInjury,
            violenceInjury: violenceInjury ?? this.violenceInjury,
            device: device ?? this.device,
            laboratory: laboratory ?? this.laboratory,
            physicalExamBodyPartInjury: physicalExamBodyPartInjury ?? this.physicalExamBodyPartInjury,
            procedure: procedure ?? this.procedure,
            prehospitalProcedure: prehospitalProcedure ?? this.prehospitalProcedure,
            transportationMode: transportationMode ?? this.transportationMode,
            vitalSign: vitalSign ?? this.vitalSign,
            direccionLinea1: direccionLinea1 ?? this.direccionLinea1,
            direccionLinea2: direccionLinea2 ?? this.direccionLinea2,
            ciudad: ciudad ?? this.ciudad,
            cantonMunicipio: cantonMunicipio ?? this.cantonMunicipio,
            provinciaEstado: provinciaEstado ?? this.provinciaEstado,
            codigoPostal: codigoPostal ?? this.codigoPostal,
            pais: pais ?? this.pais,
            edad: edad ?? this.edad,
            unidadDeEdad: unidadDeEdad ?? this.unidadDeEdad,
            genero: genero ?? this.genero,
            fechaDeNacimiento: fechaDeNacimiento ?? this.fechaDeNacimiento,
            ocupacion: ocupacion ?? this.ocupacion,
            estadoCivil: estadoCivil ?? this.estadoCivil,
            nacionalidad: nacionalidad ?? this.nacionalidad,
            grupoEtnico: grupoEtnico ?? this.grupoEtnico,
            otroGrupoEtnico: otroGrupoEtnico ?? this.otroGrupoEtnico,
            numDocDeIdentificacion: numDocDeIdentificacion ?? this.numDocDeIdentificacion,
        );

    factory PatientData.fromJson(Map<String, dynamic> json) => PatientData(
        traumaRegisterRecordId: json["trauma_register_record_id"],
        healthcareRecord: json["healthcare_record"] == null ? null : HealthcareRecord.fromJson(json["healthcare_record"]),
        injuryRecord: json["injury_record"] == null ? null : InjuryRecord.fromJson(json["injury_record"]),
        collision: json["collision"] == null ? [] : List<Collision>.from(json["collision"]!.map((x) => Collision.fromJson(x))),
        drugAbuse: json["drug_abuse"] == null ? [] : List<DrugAbuse>.from(json["drug_abuse"]!.map((x) => DrugAbuse.fromJson(x))),
        vitalSignGcsQualifier: json["vital_sign_gcs_qualifier"] == null ? [] : List<VitalSignGcsQualifier>.from(json["vital_sign_gcs_qualifier"]!.map((x) => VitalSignGcsQualifier.fromJson(x))),
        hospitalizationVariable: json["hospitalization_variable"] == null ? [] : List<HospitalizationVariable>.from(json["hospitalization_variable"]!.map((x) => HospitalizationVariable.fromJson(x))),
        hospitalizationComplication: json["hospitalization_complication"] == null ? [] : List<HospitalizationComplication>.from(json["hospitalization_complication"]!.map((x) => HospitalizationComplication.fromJson(x))),
        traumaRegisterIcd10: json["trauma_register_icd10"] == null ? [] : List<TraumaRegisterIcd10>.from(json["trauma_register_icd10"]!.map((x) => TraumaRegisterIcd10.fromJson(x))),
        intensiveCareUnit: json["intensive_care_unit"] == null ? [] : List<IntensiveCareUnit>.from(json["intensive_care_unit"]!.map((x) => IntensiveCareUnit.fromJson(x))),
        imaging: json["imaging"] == null ? [] : List<Imaging>.from(json["imaging"]!.map((x) => Imaging.fromJson(x))),
        apparentIntentInjury: json["apparent_intent_injury"] == null ? [] : List<ApparentIntentInjury>.from(json["apparent_intent_injury"]!.map((x) => ApparentIntentInjury.fromJson(x))),
        burnInjury: json["burn_injury"] == null ? [] : List<BurnInjury>.from(json["burn_injury"]!.map((x) => BurnInjury.fromJson(x))),
        firearmInjury: json["firearm_injury"] == null ? [] : List<FirearmInjury>.from(json["firearm_injury"]!.map((x) => FirearmInjury.fromJson(x))),
        penetratingInjury: json["penetrating_injury"] == null ? [] : List<PenetratingInjury>.from(json["penetrating_injury"]!.map((x) => PenetratingInjury.fromJson(x))),
        poisoningInjury: json["poisoning_injury"] == null ? [] : List<PoisoningInjury>.from(json["poisoning_injury"]!.map((x) => PoisoningInjury.fromJson(x))),
        violenceInjury: json["violence_injury"] == null ? [] : List<ViolenceInjury>.from(json["violence_injury"]!.map((x) => ViolenceInjury.fromJson(x))),
        device: json["device"] == null ? [] : List<Device>.from(json["device"]!.map((x) => Device.fromJson(x))),
        laboratory: json["laboratory"] == null ? [] : List<Laboratory>.from(json["laboratory"]!.map((x) => Laboratory.fromJson(x))),
        physicalExamBodyPartInjury: json["physical_exam_body_part_injury"] == null ? [] : List<PhysicalExamBodyPartInjury>.from(json["physical_exam_body_part_injury"]!.map((x) => PhysicalExamBodyPartInjury.fromJson(x))),
        procedure: json["procedure"] == null ? [] : List<Procedure>.from(json["procedure"]!.map((x) => Procedure.fromJson(x))),
        prehospitalProcedure: json["prehospital_procedure"] == null ? [] : List<PrehospitalProcedure>.from(json["prehospital_procedure"]!.map((x) => PrehospitalProcedure.fromJson(x))),
        transportationMode: json["transportation_mode"] == null ? [] : List<TransportationMode>.from(json["transportation_mode"]!.map((x) => TransportationMode.fromJson(x))),
        vitalSign: json["vital_sign"] == null ? [] : List<VitalSign>.from(json["vital_sign"]!.map((x) => VitalSign.fromJson(x))),
        direccionLinea1: json["direccion_linea_1"],
        direccionLinea2: json["direccion_linea_2"],
        ciudad: json["ciudad"],
        cantonMunicipio: json["canton_municipio"],
        provinciaEstado: json["provincia_estado"],
        codigoPostal: json["codigo_postal"],
        pais: json["pais"],
        edad: json["edad"],
        unidadDeEdad: json["unidad_de_edad"],
        genero: json["genero"],
        fechaDeNacimiento: json["fecha_de_nacimiento"] == null ? null : DateTime.parse(json["fecha_de_nacimiento"]),
        ocupacion: json["ocupacion"],
        estadoCivil: json["estado_civil"],
        nacionalidad: json["nacionalidad"],
        grupoEtnico: json["grupo_etnico"],
        otroGrupoEtnico: json["otro_grupo_etnico"],
        numDocDeIdentificacion: json["num_doc_de_identificacion"],
    );

    Map<String, dynamic> toJson() => {
        "trauma_register_record_id": traumaRegisterRecordId,
        "healthcare_record": healthcareRecord?.toJson(),
        "injury_record": injuryRecord?.toJson(),
        "collision": collision == null ? [] : List<dynamic>.from(collision!.map((x) => x.toJson())),
        "drug_abuse": drugAbuse == null ? [] : List<dynamic>.from(drugAbuse!.map((x) => x.toJson())),
        "vital_sign_gcs_qualifier": vitalSignGcsQualifier == null ? [] : List<dynamic>.from(vitalSignGcsQualifier!.map((x) => x.toJson())),
        "hospitalization_variable": hospitalizationVariable == null ? [] : List<dynamic>.from(hospitalizationVariable!.map((x) => x.toJson())),
        "hospitalization_complication": hospitalizationComplication == null ? [] : List<dynamic>.from(hospitalizationComplication!.map((x) => x.toJson())),
        "trauma_register_icd10": traumaRegisterIcd10 == null ? [] : List<dynamic>.from(traumaRegisterIcd10!.map((x) => x.toJson())),
        "intensive_care_unit": intensiveCareUnit == null ? [] : List<dynamic>.from(intensiveCareUnit!.map((x) => x.toJson())),
        "imaging": imaging == null ? [] : List<dynamic>.from(imaging!.map((x) => x.toJson())),
        "apparent_intent_injury": apparentIntentInjury == null ? [] : List<dynamic>.from(apparentIntentInjury!.map((x) => x.toJson())),
        "burn_injury": burnInjury == null ? [] : List<dynamic>.from(burnInjury!.map((x) => x.toJson())),
        "firearm_injury": firearmInjury == null ? [] : List<dynamic>.from(firearmInjury!.map((x) => x.toJson())),
        "penetrating_injury": penetratingInjury == null ? [] : List<dynamic>.from(penetratingInjury!.map((x) => x.toJson())),
        "poisoning_injury": poisoningInjury == null ? [] : List<dynamic>.from(poisoningInjury!.map((x) => x.toJson())),
        "violence_injury": violenceInjury == null ? [] : List<dynamic>.from(violenceInjury!.map((x) => x.toJson())),
        "device": device == null ? [] : List<dynamic>.from(device!.map((x) => x.toJson())),
        "laboratory": laboratory == null ? [] : List<dynamic>.from(laboratory!.map((x) => x.toJson())),
        "physical_exam_body_part_injury": physicalExamBodyPartInjury == null ? [] : List<dynamic>.from(physicalExamBodyPartInjury!.map((x) => x.toJson())),
        "procedure": procedure == null ? [] : List<dynamic>.from(procedure!.map((x) => x.toJson())),
        "prehospital_procedure": prehospitalProcedure == null ? [] : List<dynamic>.from(prehospitalProcedure!.map((x) => x.toJson())),
        "transportation_mode": transportationMode == null ? [] : List<dynamic>.from(transportationMode!.map((x) => x.toJson())),
        "vital_sign": vitalSign == null ? [] : List<dynamic>.from(vitalSign!.map((x) => x.toJson())),
        "direccion_linea_1": direccionLinea1,
        "direccion_linea_2": direccionLinea2,
        "ciudad": ciudad,
        "canton_municipio": cantonMunicipio,
        "provincia_estado": provinciaEstado,
        "codigo_postal": codigoPostal,
        "pais": pais,
        "edad": edad,
        "unidad_de_edad": unidadDeEdad,
        "genero": genero,
        "fecha_de_nacimiento": "${fechaDeNacimiento!.year.toString().padLeft(4, '0')}-${fechaDeNacimiento!.month.toString().padLeft(2, '0')}-${fechaDeNacimiento!.day.toString().padLeft(2, '0')}",
        "ocupacion": ocupacion,
        "estado_civil": estadoCivil,
        "nacionalidad": nacionalidad,
        "grupo_etnico": grupoEtnico,
        "otro_grupo_etnico": otroGrupoEtnico,
        "num_doc_de_identificacion": numDocDeIdentificacion,
    };

    @override
  String toString() {
    return "$traumaRegisterIcd10 - $direccionLinea1 - $direccionLinea2";
  }
}