import 'package:trauma_register_frontend/data/models/shared/optional.dart';

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
    Optional<String?>? tipoDeImagen,
    Optional<String?>? parteDelCuerpo,
    Optional<bool?>? opcion,
    Optional<String?>? descripcion,
  }) =>
      Imaging(
        id: id ?? this.id,
        tipoDeImagen: tipoDeImagen?.isPresent == true
            ? tipoDeImagen!.value
            : this.tipoDeImagen,
        parteDelCuerpo: parteDelCuerpo?.isPresent == true
            ? parteDelCuerpo!.value
            : this.parteDelCuerpo,
        opcion: opcion?.isPresent == true ? opcion!.value : this.opcion,
        descripcion: descripcion?.isPresent == true
            ? descripcion!.value
            : this.descripcion,
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
