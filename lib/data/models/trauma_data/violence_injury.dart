class ViolenceInjury {
  final int? id;
  final String? tipoDeViolencia;

  ViolenceInjury({
    this.id,
    this.tipoDeViolencia,
  });

  ViolenceInjury copyWith({
    int? id,
    String? tipoDeViolencia,
  }) =>
      ViolenceInjury(
        id: id ?? this.id,
        tipoDeViolencia: tipoDeViolencia ?? this.tipoDeViolencia,
      );

  factory ViolenceInjury.fromJson(Map<String, dynamic> json) => ViolenceInjury(
        id: json["id"],
        tipoDeViolencia: json["tipo_de_violencia"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_de_violencia": tipoDeViolencia,
      };
}
