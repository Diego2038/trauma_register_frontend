import 'package:trauma_register_frontend/data/models/shared/optional.dart';

class DrugAbuse {
  final int? id;
  final String? tipoDeDroga;

  DrugAbuse({
    this.id,
    this.tipoDeDroga,
  });

  DrugAbuse copyWith({
    int? id,
    Optional<String?>? tipoDeDroga,
  }) =>
      DrugAbuse(
        id: id ?? this.id,
        tipoDeDroga: tipoDeDroga?.isPresent == true
            ? tipoDeDroga!.value
            : this.tipoDeDroga,
      );

  factory DrugAbuse.fromJson(Map<String, dynamic> json) => DrugAbuse(
        id: json["id"],
        tipoDeDroga: json["tipo_de_droga"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_de_droga": tipoDeDroga,
      };
}
