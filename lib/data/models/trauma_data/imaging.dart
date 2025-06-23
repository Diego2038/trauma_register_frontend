class Imaging {
  final int? id;
  final String? tipoDeImagen;
  final String? parteDelCuerpo;
  final bool? opcion;
  final String? descripcion;

  Imaging({
    this.id,
    this.tipoDeImagen,
    this.parteDelCuerpo,
    this.opcion,
    this.descripcion,
  });

  Imaging copyWith({
    int? id,
    String? tipoDeImagen,
    String? parteDelCuerpo,
    bool? opcion,
    String? descripcion,
  }) =>
      Imaging(
        id: id ?? this.id,
        tipoDeImagen: tipoDeImagen ?? this.tipoDeImagen,
        parteDelCuerpo: parteDelCuerpo ?? this.parteDelCuerpo,
        opcion: opcion ?? this.opcion,
        descripcion: descripcion ?? this.descripcion,
      );

  factory Imaging.fromJson(Map<String, dynamic> json) => Imaging(
        id: json["id"],
        tipoDeImagen: json["tipo_de_imagen"],
        parteDelCuerpo: json["parte_del_cuerpo"],
        opcion: json["opcion"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_de_imagen": tipoDeImagen,
        "parte_del_cuerpo": parteDelCuerpo,
        "opcion": opcion,
        "descripcion": descripcion,
      };
}
