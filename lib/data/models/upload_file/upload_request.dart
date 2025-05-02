import 'dart:typed_data';

class UploadRequest {
    final Uint8List file;
    final String user;
    final bool updateData;
    final bool onlyUpdate;

    UploadRequest({
        required this.file,
        required this.user,
        required this.updateData,
        required this.onlyUpdate,
    });

    UploadRequest copyWith({
        Uint8List? file,
        String? user,
        bool? updateData,
        bool? onlyUpdate,
    }) => 
        UploadRequest(
            file: file ?? this.file,
            user: user ?? this.user,
            updateData: updateData ?? this.updateData,
            onlyUpdate: onlyUpdate ?? this.onlyUpdate,
        );

    factory UploadRequest.fromJson(Map<String, dynamic> json) => UploadRequest(
        file: json["file"],
        user: json["user"],
        updateData: json["update_data"],
        onlyUpdate: json["only_update"],
    );

    Map<String, dynamic> toJson() => {
        "file": file,
        "user": user,
        "update_data": updateData,
        "only_update": onlyUpdate,
    };
}