import 'package:trauma_register_frontend/core/helpers/endpoint_helper.dart';
import 'package:trauma_register_frontend/core/helpers/local_storage.dart';
import 'package:trauma_register_frontend/core/helpers/print_error.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/trauma_data.dart';

class TraumaDataService {
  Future<PatientData?> getPatientDataById(String traumaRegisterRecordId) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.getRequest(
        path: "/medical_records/patient-data/$traumaRegisterRecordId/",
        token: token,
      );
      if (response.statusCode == 404) return null;
      final data = response.data as Map<String, dynamic>;
      return PatientData.fromJson(data);
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_service.dart', stack: s);
      return null;
    }
  }

  Future<bool> deletePatientDataById(String traumaRegisterRecordId) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.deleteRequest(
        path: "/medical_records/patient-data/$traumaRegisterRecordId/",
        token: token,
      );
      if (response.statusCode == 404) return false;
      return true;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_service.dart', stack: s);
      return false;
    }
  }

  Future<bool> createPatientData(PatientData patientData) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final data = patientData.toJson();
      final response = await EndpointHelper.postRequest(
        path:
            "/medical_records/patient-data/",
        token: token,
        data: data,
      );
      if (response.statusCode == 404) return false;
      return true;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_service.dart', stack: s);
      return false;
    }
  }
}
