import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:trauma_register_frontend/data/models/upload_file/upload_request.dart';

void main() {
  group('UploadRequest', () {
    final Uint8List testFile = Uint8List.fromList([1, 2, 3, 4, 5]);
    const String testUser = "test_user";
    const bool testUpdateData = true;
    const bool testOnlyUpdate = false;

    final Map<String, dynamic> jsonMap = {
      "file": testFile,
      "user": testUser,
      "update_data": testUpdateData,
      "only_update": testOnlyUpdate,
    };

    test('fromJson should parse JSON correctly', () {
      final request = UploadRequest.fromJson(jsonMap);

      expect(request.file, equals(testFile));
      expect(request.user, equals(testUser));
      expect(request.updateData, equals(testUpdateData));
      expect(request.onlyUpdate, equals(testOnlyUpdate));
    });

    test('toJson should serialize to JSON correctly', () {
      final request = UploadRequest(
        file: testFile,
        user: testUser,
        updateData: testUpdateData,
        onlyUpdate: testOnlyUpdate,
      );
      final serializedJson = request.toJson();

      expect(serializedJson, equals(jsonMap));
    });
    
    test('copyWith should create a new instance with updated values', () {
      final originalRequest = UploadRequest(
        file: testFile,
        user: "original_user",
        updateData: false,
        onlyUpdate: true,
      );

      final updatedRequest = originalRequest.copyWith(
        user: testUser,
        updateData: true,
      );

      expect(updatedRequest.file, equals(originalRequest.file));
      expect(updatedRequest.user, equals(testUser));
      expect(updatedRequest.updateData, equals(true));
      expect(updatedRequest.onlyUpdate, equals(originalRequest.onlyUpdate));
      
      // Verificamos que es una nueva instancia
      expect(originalRequest, isNot(equals(updatedRequest)));
    });

  });
}