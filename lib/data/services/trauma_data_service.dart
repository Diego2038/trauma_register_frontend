import 'package:trauma_register_frontend/core/helpers/endpoint_helper.dart';
import 'package:trauma_register_frontend/core/helpers/local_storage.dart';
import 'package:trauma_register_frontend/core/helpers/print_error.dart';
import 'package:trauma_register_frontend/data/models/http_response/custom_http_status_response.dart';
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

  Future<CustomHttpStatusResponse> createPatientData(
      PatientData patientData) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final data = patientData.toJson();
      final response = await EndpointHelper.postRequest(
        path: "/medical_records/patient-data/",
        token: token,
        data: data,
      );
      final message = _convertMessage(_getFirstString(response.data));
      if ((response.statusCode ?? 400) >= 400) {
        return CustomHttpStatusResponse(
          code: response.statusCode,
          result: false,
          message: message,
        );
      }
      return CustomHttpStatusResponse(
        code: response.statusCode,
        result: true,
        message: message,
      );
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_service.dart', stack: s);
      return CustomHttpStatusResponse(result: false, message: e.toString());
    }
  }

  Future<CustomHttpStatusResponse> deleteInjuryRecordById(String id) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.deleteRequest(
        path: "/medical_records/injury-record/$id/",
        token: token,
      );
      if ((response.statusCode ?? 400) >= 400) {
        return CustomHttpStatusResponse(
          code: response.statusCode,
          result: false,
          message: _convertMessage(_getFirstString(response.data)),
        );
      }
      return CustomHttpStatusResponse(
        code: response.statusCode,
        result: true,
        message: "Elemento eliminado con éxito",
      );
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_service.dart', stack: s);
      return CustomHttpStatusResponse(
        result: false,
        message: e.toString(),
      );
    }
  }

  Future<CustomHttpStatusResponse> deleteCollisionById(String id) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.deleteRequest(
        path: "/medical_records/collision/$id/",
        token: token,
      );
      if ((response.statusCode ?? 400) >= 400) {
        return CustomHttpStatusResponse(
          code: response.statusCode,
          result: false,
          message: _convertMessage(_getFirstString(response.data)),
        );
      }
      return CustomHttpStatusResponse(
        code: response.statusCode,
        result: true,
        message: "Elemento eliminado con éxito",
      );
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_service.dart', stack: s);
      return CustomHttpStatusResponse(
        result: false,
        message: e.toString(),
      );
    }
  }

  String? _convertMessage(String? value) {
    switch (value) {
      case "patient data with this trauma register record id already exists.":
        return "ID registro de trauma utilizado en Datos generales ya existe, por favor utilice otro.";
      case "vital sign with this record id already exists.":
        return "ID del registro utilizado en Signos vitales ya existe, por favor utilice otro.";
      default:
        return value;
    }
  }

  String? _getFirstString(dynamic value) {
    if (value is String) {
      return value;
    } else if (value is List) {
      for (var item in value) {
        final result = _getFirstString(item);
        if (result != null) return result;
      }
    } else if (value is Map) {
      for (var item in value.values) {
        final result = _getFirstString(item);
        if (result != null) return result;
      }
    }
    return null;
  }
}
