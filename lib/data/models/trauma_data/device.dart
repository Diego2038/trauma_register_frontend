import 'package:trauma_register_frontend/data/models/shared/optional.dart';

class Device {
  final int? id;
  final String? tipoDeDispositivo;

  Device({
    this.id,
    this.tipoDeDispositivo,
  });

  Device copyWith({
    int? id,
    Optional<String?>? tipoDeDispositivo,
  }) =>
      Device(
        id: id ?? this.id,
        tipoDeDispositivo: tipoDeDispositivo?.isPresent == true
            ? tipoDeDispositivo!.value
            : this.tipoDeDispositivo,
      );

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        id: json["id"],
        tipoDeDispositivo: json["tipo_de_dispositivo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_de_dispositivo": tipoDeDispositivo,
      };
}
