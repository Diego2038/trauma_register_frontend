class UploadResponse {
  final int? file;
  final String? user;
  final bool? allowUpdateData;
  final bool? onlyUpdate;
  final List<String>? updatedPatients;
  final List<String>? problems;
  final String? detail;
  final String? error;
  final String? specificError;

  UploadResponse({
    this.file,
    this.user,
    this.allowUpdateData,
    this.onlyUpdate,
    this.updatedPatients,
    this.problems,
    this.detail,
    this.error,
    this.specificError,
  });

  UploadResponse copyWith({
    int? file,
    String? user,
    bool? allowUpdateData,
    bool? onlyUpdate,
    List<String>? updatedPatients,
    List<String>? problems,
    String? detail,
    String? error,
    String? specificError,
  }) =>
      UploadResponse(
        file: file ?? this.file,
        user: user ?? this.user,
        allowUpdateData: allowUpdateData ?? this.allowUpdateData,
        onlyUpdate: onlyUpdate ?? this.onlyUpdate,
        updatedPatients: updatedPatients ?? this.updatedPatients,
        problems: problems ?? this.problems,
        detail: detail ?? this.detail,
        error: error ?? this.error,
        specificError: specificError ?? this.specificError,
      );

  factory UploadResponse.fromJson(Map<String, dynamic> json) => UploadResponse(
        file: json["file"],
        user: json["user"],
        allowUpdateData: json["allow_update_data"],
        onlyUpdate: json["only_update"],
        updatedPatients: json["updated_patients"] == null
            ? []
            : List<String>.from(json["updated_patients"]!.map((x) => x)),
        problems: json["problems"] == null
            ? []
            : List<String>.from(json["problems"]!.map((x) => x)),
        detail: json["detail"],
        error: json["error"],
        specificError: json["specific_error"],
      );

  Map<String, dynamic> toJson() => {
        "file": file,
        "user": user,
        "update_data": allowUpdateData,
        "only_update": onlyUpdate,
        "updated_patients": updatedPatients == null
            ? []
            : List<dynamic>.from(updatedPatients!.map((x) => x)),
        "problems":
            problems == null ? [] : List<dynamic>.from(problems!.map((x) => x)),
        "detail": detail,
        "error": error,
        "specific_error": specificError,
      };
}
