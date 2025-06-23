class TraumaRegisterIcd10 {
  final int? id;
  final String? descripcion;
  final String? mecanismoIcd;

  TraumaRegisterIcd10({
    this.id,
    this.descripcion,
    this.mecanismoIcd,
  });

  TraumaRegisterIcd10 copyWith({
    int? id,
    String? descripcion,
    String? mecanismoIcd,
  }) =>
      TraumaRegisterIcd10(
        id: id ?? this.id,
        descripcion: descripcion ?? this.descripcion,
        mecanismoIcd: mecanismoIcd ?? this.mecanismoIcd,
      );

  factory TraumaRegisterIcd10.fromJson(Map<String, dynamic> json) =>
      TraumaRegisterIcd10(
        id: json["id"],
        descripcion: json["descripcion"],
        mecanismoIcd: json["mecanismo_icd"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
        "mecanismo_icd": mecanismoIcd,
      };
}
