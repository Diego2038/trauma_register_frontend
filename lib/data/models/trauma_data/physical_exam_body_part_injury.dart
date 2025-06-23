class PhysicalExamBodyPartInjury {
  final int? id;
  final String? parteDelCuerpo;
  final String? tipoDeLesion;
  final int? traumaRegisterRecordId;

  PhysicalExamBodyPartInjury({
    this.id,
    this.parteDelCuerpo,
    this.tipoDeLesion,
    this.traumaRegisterRecordId,
  });

  PhysicalExamBodyPartInjury copyWith({
    int? id,
    String? parteDelCuerpo,
    String? tipoDeLesion,
    int? traumaRegisterRecordId,
  }) =>
      PhysicalExamBodyPartInjury(
        id: id ?? this.id,
        parteDelCuerpo: parteDelCuerpo ?? this.parteDelCuerpo,
        tipoDeLesion: tipoDeLesion ?? this.tipoDeLesion,
        traumaRegisterRecordId:
            traumaRegisterRecordId ?? this.traumaRegisterRecordId,
      );

  factory PhysicalExamBodyPartInjury.fromJson(Map<String, dynamic> json) =>
      PhysicalExamBodyPartInjury(
        id: json["id"],
        parteDelCuerpo: json["parte_del_cuerpo"],
        tipoDeLesion: json["tipo_de_lesion"],
        traumaRegisterRecordId: json["trauma_register_record_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parte_del_cuerpo": parteDelCuerpo,
        "tipo_de_lesion": tipoDeLesion,
        "trauma_register_record_id": traumaRegisterRecordId,
      };
}
