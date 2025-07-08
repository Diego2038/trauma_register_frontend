import 'package:trauma_register_frontend/data/models/shared/optional.dart';

class VitalSignGcsQualifier {
  final int? id;
  final String? calificadorGcs;

  VitalSignGcsQualifier({
    this.id,
    this.calificadorGcs,
  });

  VitalSignGcsQualifier copyWith({
    int? id,
    Optional<String?>? calificadorGcs,
  }) =>
      VitalSignGcsQualifier(
        id: id ?? this.id,
        calificadorGcs: calificadorGcs?.isPresent == true
            ? calificadorGcs!.value
            : this.calificadorGcs,
      );

  factory VitalSignGcsQualifier.fromJson(Map<String, dynamic> json) =>
      VitalSignGcsQualifier(
        id: json["id"],
        calificadorGcs: json["calificador_gcs"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "calificador_gcs": calificadorGcs,
      };
}
