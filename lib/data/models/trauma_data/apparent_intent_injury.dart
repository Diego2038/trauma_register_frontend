import 'package:trauma_register_frontend/data/models/shared/optional.dart';

class ApparentIntentInjury {
  final int? id;
  final String? intencionAparente;

  ApparentIntentInjury({
    this.id,
    this.intencionAparente,
  });

  ApparentIntentInjury copyWith({
    int? id,
    Optional<String?>? intencionAparente,
  }) =>
      ApparentIntentInjury(
        id: id ?? this.id,
        intencionAparente: intencionAparente?.isPresent == true
            ? intencionAparente!.value
            : this.intencionAparente,
      );

  factory ApparentIntentInjury.fromJson(Map<String, dynamic> json) =>
      ApparentIntentInjury(
        id: json["id"],
        intencionAparente: json["intencion_aparente"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "intencion_aparente": intencionAparente,
      };
}
