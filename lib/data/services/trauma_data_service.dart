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

  Future<CustomHttpStatusResponse> updatePatientDataElement(
      PatientData element) async {
    try {
      final patientDataJson = element.toJson();
      patientDataJson.remove("healthcare_record");
      patientDataJson.remove("injury_record");
      patientDataJson.remove("collision");
      patientDataJson.remove("drug_abuse");
      patientDataJson.remove("vital_sign_gcs_qualifier");
      patientDataJson.remove("hospitalization_variable");
      patientDataJson.remove("hospitalization_complication");
      patientDataJson.remove("trauma_register_icd10");
      patientDataJson.remove("intensive_care_unit");
      patientDataJson.remove("imaging");
      patientDataJson.remove("apparent_intent_injury");
      patientDataJson.remove("burn_injury");
      patientDataJson.remove("firearm_injury");
      patientDataJson.remove("penetrating_injury");
      patientDataJson.remove("poisoning_injury");
      patientDataJson.remove("violence_injury");
      patientDataJson.remove("device");
      patientDataJson.remove("laboratory");
      patientDataJson.remove("physical_exam_body_part_injury");
      patientDataJson.remove("procedure");
      patientDataJson.remove("prehospital_procedure");
      patientDataJson.remove("transportation_mode");
      patientDataJson.remove("vital_sign");
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path:
            "/medical_records/patient-data/${element.traumaRegisterRecordId}/",
        token: token,
        data: element.toJson(),
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
        message: "Elemento actualizado con éxito.",
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

  Future<CustomHttpStatusResponse> createHealthcareRecord(
      HealthcareRecord element, int patientDataId) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.postRequest(
        path: "/medical_records/healthcare-record/",
        token: token,
        data: {
          "trauma_register_record_id": patientDataId,
          ...element.toJson(),
        },
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
        message: "Elemento creado con éxito.",
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

  Future<CustomHttpStatusResponse> updateHealthcareRecord(
      HealthcareRecord element, int patientDataId) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/medical_records/healthcare-record/$patientDataId/",
        token: token,
        data: element.toJson(),
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
        message: "Elemento actualizado con éxito.",
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

  Future<CustomHttpStatusResponse> deleteHealthcareRecordById(String id) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.deleteRequest(
        path: "/medical_records/healthcare-record/$id/",
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

  Future<CustomHttpStatusResponse> createInjuryRecord(
      InjuryRecord element, int patientDataId) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.postRequest(
        path: "/medical_records/injury-record/",
        token: token,
        data: {
          "trauma_register_record_id": patientDataId,
          ...element.toJson(),
        },
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
        message: "Elemento creado con éxito.",
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

  Future<CustomHttpStatusResponse> updateInjuryRecord(
      InjuryRecord element, int patientDataId) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/medical_records/injury-record/$patientDataId/",
        token: token,
        data: element.toJson(),
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
        message: "Elemento actualizado con éxito.",
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

  Future<CustomHttpStatusResponse> createCollision(
      Collision element, int patientDataId) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.postRequest(
        path: "/medical_records/collision/",
        token: token,
        data: {
          "trauma_register_record_id": patientDataId,
          ...element.toJson(),
        },
      );
      if ((response.statusCode ?? 400) >= 400) {
        return CustomHttpStatusResponse(
          code: response.statusCode,
          result: false,
          message: _convertMessage(_getFirstString(response.data)),
        );
      }
      final int? id = response.data["id"];
      return CustomHttpStatusResponse(
        code: response.statusCode,
        result: true,
        message: "Elemento creado con éxito.",
        idElement: id,
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

  Future<CustomHttpStatusResponse> updateCollision(Collision element) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/medical_records/collision/${element.id}/",
        token: token,
        data: element.toJson(),
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
        message: "Elemento actualizado con éxito.",
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

  //! DrugAbuse
  Future<CustomHttpStatusResponse> createDrugAbuse(
      DrugAbuse element, int patientDataId) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.postRequest(
        path: "/medical_records/drug-abuse/",
        token: token,
        data: {
          "trauma_register_record_id": patientDataId,
          ...element.toJson(),
        },
      );
      if ((response.statusCode ?? 400) >= 400) {
        return CustomHttpStatusResponse(
          code: response.statusCode,
          result: false,
          message: _convertMessage(_getFirstString(response.data)),
        );
      }
      final int? id = response.data["id"];
      return CustomHttpStatusResponse(
        code: response.statusCode,
        result: true,
        message: "Elemento creado con éxito.",
        idElement: id,
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

  Future<CustomHttpStatusResponse> updateDrugAbuse(DrugAbuse element) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/medical_records/drug-abuse/${element.id}/",
        token: token,
        data: element.toJson(),
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
        message: "Elemento actualizado con éxito.",
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

  Future<CustomHttpStatusResponse> deleteDrugAbuseById(String id) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.deleteRequest(
        path: "/medical_records/drug-abuse/$id/",
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

  //! VitalSignGcsQualifier
  Future<CustomHttpStatusResponse> createVitalSignGcsQualifier(
      VitalSignGcsQualifier element, int patientDataId) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.postRequest(
        path: "/medical_records/vital-sign-gcs-qualifier/",
        token: token,
        data: {
          "trauma_register_record_id": patientDataId,
          ...element.toJson(),
        },
      );
      if ((response.statusCode ?? 400) >= 400) {
        return CustomHttpStatusResponse(
          code: response.statusCode,
          result: false,
          message: _convertMessage(_getFirstString(response.data)),
        );
      }
      final int? id = response.data["id"];
      return CustomHttpStatusResponse(
        code: response.statusCode,
        result: true,
        message: "Elemento creado con éxito.",
        idElement: id,
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

  Future<CustomHttpStatusResponse> updateVitalSignGcsQualifier(
      VitalSignGcsQualifier element) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/medical_records/vital-sign-gcs-qualifier/${element.id}/",
        token: token,
        data: element.toJson(),
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
        message: "Elemento actualizado con éxito.",
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

  Future<CustomHttpStatusResponse> deleteVitalSignGcsQualifierById(
      String id) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.deleteRequest(
        path: "/medical_records/vital-sign-gcs-qualifier/$id/",
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

  //! HospitalizationVariable
  Future<CustomHttpStatusResponse> createHospitalizationVariable(
      HospitalizationVariable element, int patientDataId) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.postRequest(
        path: "/medical_records/hospitalization-variable/",
        token: token,
        data: {
          "trauma_register_record_id": patientDataId,
          ...element.toJson(),
        },
      );
      if ((response.statusCode ?? 400) >= 400) {
        return CustomHttpStatusResponse(
          code: response.statusCode,
          result: false,
          message: _convertMessage(_getFirstString(response.data)),
        );
      }
      final int? id = response.data["id"];
      return CustomHttpStatusResponse(
        code: response.statusCode,
        result: true,
        message: "Elemento creado con éxito.",
        idElement: id,
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

  Future<CustomHttpStatusResponse> updateHospitalizationVariable(
      HospitalizationVariable element) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/medical_records/hospitalization-variable/${element.id}/",
        token: token,
        data: element.toJson(),
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
        message: "Elemento actualizado con éxito.",
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

  Future<CustomHttpStatusResponse> deleteHospitalizationVariableById(
      String id) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.deleteRequest(
        path: "/medical_records/hospitalization-variable/$id/",
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

  //! HospitalizationComplication
  Future<CustomHttpStatusResponse> createHospitalizationComplication(
      HospitalizationComplication element, int patientDataId) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.postRequest(
        path: "/medical_records/hospitalization-complication/",
        token: token,
        data: {
          "trauma_register_record_id": patientDataId,
          ...element.toJson(),
        },
      );
      if ((response.statusCode ?? 400) >= 400) {
        return CustomHttpStatusResponse(
          code: response.statusCode,
          result: false,
          message: _convertMessage(_getFirstString(response.data)),
        );
      }
      final int? id = response.data["id"];
      return CustomHttpStatusResponse(
        code: response.statusCode,
        result: true,
        message: "Elemento creado con éxito.",
        idElement: id,
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

  Future<CustomHttpStatusResponse> updateHospitalizationComplication(
      HospitalizationComplication element) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/medical_records/hospitalization-complication/${element.id}/",
        token: token,
        data: element.toJson(),
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
        message: "Elemento actualizado con éxito.",
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

  Future<CustomHttpStatusResponse> deleteHospitalizationComplicationById(
      String id) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.deleteRequest(
        path: "/medical_records/hospitalization-complication/$id/",
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

  //! TraumaRegisterIcd10
  Future<CustomHttpStatusResponse> createTraumaRegisterIcd10(
      TraumaRegisterIcd10 element, int patientDataId) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.postRequest(
        path: "/medical_records/trauma-register-icd10/",
        token: token,
        data: {
          "trauma_register_record_id": patientDataId,
          ...element.toJson(),
        },
      );
      if ((response.statusCode ?? 400) >= 400) {
        return CustomHttpStatusResponse(
          code: response.statusCode,
          result: false,
          message: _convertMessage(_getFirstString(response.data)),
        );
      }
      final int? id = response.data["id"];
      return CustomHttpStatusResponse(
        code: response.statusCode,
        result: true,
        message: "Elemento creado con éxito.",
        idElement: id,
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

  Future<CustomHttpStatusResponse> updateTraumaRegisterIcd10(
      TraumaRegisterIcd10 element) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/medical_records/trauma-register-icd10/${element.id}/",
        token: token,
        data: element.toJson(),
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
        message: "Elemento actualizado con éxito.",
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

  Future<CustomHttpStatusResponse> deleteTraumaRegisterIcd10ById(
      String id) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.deleteRequest(
        path: "/medical_records/trauma-register-icd10/$id/",
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

  //! IntensiveCareUnit
  Future<CustomHttpStatusResponse> createIntensiveCareUnit(
      IntensiveCareUnit element, int patientDataId) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.postRequest(
        path: "/medical_records/intensive-care-unit/",
        token: token,
        data: {
          "trauma_register_record_id": patientDataId,
          ...element.toJson(),
        },
      );
      if ((response.statusCode ?? 400) >= 400) {
        return CustomHttpStatusResponse(
          code: response.statusCode,
          result: false,
          message: _convertMessage(_getFirstString(response.data)),
        );
      }
      final int? id = response.data["id"];
      return CustomHttpStatusResponse(
        code: response.statusCode,
        result: true,
        message: "Elemento creado con éxito.",
        idElement: id,
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

  Future<CustomHttpStatusResponse> updateIntensiveCareUnit(
      IntensiveCareUnit element) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/medical_records/intensive-care-unit/${element.id}/",
        token: token,
        data: element.toJson(),
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
        message: "Elemento actualizado con éxito.",
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

  Future<CustomHttpStatusResponse> deleteIntensiveCareUnitById(
      String id) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.deleteRequest(
        path: "/medical_records/intensive-care-unit/$id/",
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

  //! Imaging
  Future<CustomHttpStatusResponse> createImaging(
      Imaging element, int patientDataId) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.postRequest(
        path: "/medical_records/imaging/",
        token: token,
        data: {
          "trauma_register_record_id": patientDataId,
          ...element.toJson(),
        },
      );
      if ((response.statusCode ?? 400) >= 400) {
        return CustomHttpStatusResponse(
          code: response.statusCode,
          result: false,
          message: _convertMessage(_getFirstString(response.data)),
        );
      }
      final int? id = response.data["id"];
      return CustomHttpStatusResponse(
        code: response.statusCode,
        result: true,
        message: "Elemento creado con éxito.",
        idElement: id,
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

  Future<CustomHttpStatusResponse> updateImaging(Imaging element) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/medical_records/imaging/${element.id}/",
        token: token,
        data: element.toJson(),
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
        message: "Elemento actualizado con éxito.",
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

  Future<CustomHttpStatusResponse> deleteImagingById(String id) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.deleteRequest(
        path: "/medical_records/imaging/$id/",
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

  //! ApparentIntentInjury
  Future<CustomHttpStatusResponse> createApparentIntentInjury(
      ApparentIntentInjury element, int patientDataId) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.postRequest(
        path: "/medical_records/apparent-intent-injury/",
        token: token,
        data: {
          "trauma_register_record_id": patientDataId,
          ...element.toJson(),
        },
      );
      if ((response.statusCode ?? 400) >= 400) {
        return CustomHttpStatusResponse(
          code: response.statusCode,
          result: false,
          message: _convertMessage(_getFirstString(response.data)),
        );
      }
      final int? id = response.data["id"];
      return CustomHttpStatusResponse(
        code: response.statusCode,
        result: true,
        message: "Elemento creado con éxito.",
        idElement: id,
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

  Future<CustomHttpStatusResponse> updateApparentIntentInjury(
      ApparentIntentInjury element) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/medical_records/apparent-intent-injury/${element.id}/",
        token: token,
        data: element.toJson(),
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
        message: "Elemento actualizado con éxito.",
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

  Future<CustomHttpStatusResponse> deleteApparentIntentInjuryById(
      String id) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.deleteRequest(
        path: "/medical_records/apparent-intent-injury/$id/",
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

  //! BurnInjury
  Future<CustomHttpStatusResponse> createBurnInjury(
      BurnInjury element, int patientDataId) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.postRequest(
        path: "/medical_records/burn-injury/",
        token: token,
        data: {
          "trauma_register_record_id": patientDataId,
          ...element.toJson(),
        },
      );
      if ((response.statusCode ?? 400) >= 400) {
        return CustomHttpStatusResponse(
          code: response.statusCode,
          result: false,
          message: _convertMessage(_getFirstString(response.data)),
        );
      }
      final int? id = response.data["id"];
      return CustomHttpStatusResponse(
        code: response.statusCode,
        result: true,
        message: "Elemento creado con éxito.",
        idElement: id,
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

  Future<CustomHttpStatusResponse> updateBurnInjury(BurnInjury element) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/medical_records/burn-injury/${element.id}/",
        token: token,
        data: element.toJson(),
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
        message: "Elemento actualizado con éxito.",
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

  Future<CustomHttpStatusResponse> deleteBurnInjuryById(String id) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.deleteRequest(
        path: "/medical_records/burn-injury/$id/",
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

  //! FirearmInjury
  Future<CustomHttpStatusResponse> createFirearmInjury(
      FirearmInjury element, int patientDataId) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.postRequest(
        path: "/medical_records/firearm-injury/",
        token: token,
        data: {
          "trauma_register_record_id": patientDataId,
          ...element.toJson(),
        },
      );
      if ((response.statusCode ?? 400) >= 400) {
        return CustomHttpStatusResponse(
          code: response.statusCode,
          result: false,
          message: _convertMessage(_getFirstString(response.data)),
        );
      }
      final int? id = response.data["id"];
      return CustomHttpStatusResponse(
        code: response.statusCode,
        result: true,
        message: "Elemento creado con éxito.",
        idElement: id,
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

  Future<CustomHttpStatusResponse> updateFirearmInjury(
      FirearmInjury element) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/medical_records/firearm-injury/${element.id}/",
        token: token,
        data: element.toJson(),
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
        message: "Elemento actualizado con éxito.",
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

  Future<CustomHttpStatusResponse> deleteFirearmInjuryById(String id) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.deleteRequest(
        path: "/medical_records/firearm-injury/$id/",
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

  //! PenetratingInjury
  Future<CustomHttpStatusResponse> createPenetratingInjury(
      PenetratingInjury element, int patientDataId) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.postRequest(
        path: "/medical_records/penetrating-injury/",
        token: token,
        data: {
          "trauma_register_record_id": patientDataId,
          ...element.toJson(),
        },
      );
      if ((response.statusCode ?? 400) >= 400) {
        return CustomHttpStatusResponse(
          code: response.statusCode,
          result: false,
          message: _convertMessage(_getFirstString(response.data)),
        );
      }
      final int? id = response.data["id"];
      return CustomHttpStatusResponse(
        code: response.statusCode,
        result: true,
        message: "Elemento creado con éxito.",
        idElement: id,
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

  Future<CustomHttpStatusResponse> updatePenetratingInjury(
      PenetratingInjury element) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/medical_records/penetrating-injury/${element.id}/",
        token: token,
        data: element.toJson(),
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
        message: "Elemento actualizado con éxito.",
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

  Future<CustomHttpStatusResponse> deletePenetratingInjuryById(
      String id) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.deleteRequest(
        path: "/medical_records/penetrating-injury/$id/",
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

  //! PoisoningInjury
  Future<CustomHttpStatusResponse> createPoisoningInjury(
      PoisoningInjury element, int patientDataId) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.postRequest(
        path: "/medical_records/poisoning-injury/",
        token: token,
        data: {
          "trauma_register_record_id": patientDataId,
          ...element.toJson(),
        },
      );
      if ((response.statusCode ?? 400) >= 400) {
        return CustomHttpStatusResponse(
          code: response.statusCode,
          result: false,
          message: _convertMessage(_getFirstString(response.data)),
        );
      }
      final int? id = response.data["id"];
      return CustomHttpStatusResponse(
        code: response.statusCode,
        result: true,
        message: "Elemento creado con éxito.",
        idElement: id,
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

  Future<CustomHttpStatusResponse> updatePoisoningInjury(
      PoisoningInjury element) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/medical_records/poisoning-injury/${element.id}/",
        token: token,
        data: element.toJson(),
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
        message: "Elemento actualizado con éxito.",
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

  Future<CustomHttpStatusResponse> deletePoisoningInjuryById(String id) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.deleteRequest(
        path: "/medical_records/poisoning-injury/$id/",
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

  //! ViolenceInjury
  Future<CustomHttpStatusResponse> createViolenceInjury(
      ViolenceInjury element, int patientDataId) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.postRequest(
        path: "/medical_records/violence-injury/",
        token: token,
        data: {
          "trauma_register_record_id": patientDataId,
          ...element.toJson(),
        },
      );
      if ((response.statusCode ?? 400) >= 400) {
        return CustomHttpStatusResponse(
          code: response.statusCode,
          result: false,
          message: _convertMessage(_getFirstString(response.data)),
        );
      }
      final int? id = response.data["id"];
      return CustomHttpStatusResponse(
        code: response.statusCode,
        result: true,
        message: "Elemento creado con éxito.",
        idElement: id,
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

  Future<CustomHttpStatusResponse> updateViolenceInjury(
      ViolenceInjury element) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/medical_records/violence-injury/${element.id}/",
        token: token,
        data: element.toJson(),
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
        message: "Elemento actualizado con éxito.",
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

  Future<CustomHttpStatusResponse> deleteViolenceInjuryById(String id) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.deleteRequest(
        path: "/medical_records/violence-injury/$id/",
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

  //! Device
  Future<CustomHttpStatusResponse> createDevice(
      Device element, int patientDataId) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.postRequest(
        path: "/medical_records/device/",
        token: token,
        data: {
          "trauma_register_record_id": patientDataId,
          ...element.toJson(),
        },
      );
      if ((response.statusCode ?? 400) >= 400) {
        return CustomHttpStatusResponse(
          code: response.statusCode,
          result: false,
          message: _convertMessage(_getFirstString(response.data)),
        );
      }
      final int? id = response.data["id"];
      return CustomHttpStatusResponse(
        code: response.statusCode,
        result: true,
        message: "Elemento creado con éxito.",
        idElement: id,
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

  Future<CustomHttpStatusResponse> updateDevice(Device element) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/medical_records/device/${element.id}/",
        token: token,
        data: element.toJson(),
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
        message: "Elemento actualizado con éxito.",
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

  Future<CustomHttpStatusResponse> deleteDeviceById(String id) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.deleteRequest(
        path: "/medical_records/device/$id/",
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

  //! Laboratory
  Future<CustomHttpStatusResponse> createLaboratory(
      Laboratory element, int patientDataId) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.postRequest(
        path: "/medical_records/laboratory/",
        token: token,
        data: {
          "trauma_register_record_id": patientDataId,
          ...element.toJson(),
        },
      );
      if ((response.statusCode ?? 400) >= 400) {
        return CustomHttpStatusResponse(
          code: response.statusCode,
          result: false,
          message: _convertMessage(_getFirstString(response.data)),
        );
      }
      final int? id = response.data["id"];
      return CustomHttpStatusResponse(
        code: response.statusCode,
        result: true,
        message: "Elemento creado con éxito.",
        idElement: id,
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

  Future<CustomHttpStatusResponse> updateLaboratory(Laboratory element) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/medical_records/laboratory/${element.id}/",
        token: token,
        data: element.toJson(),
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
        message: "Elemento actualizado con éxito.",
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

  Future<CustomHttpStatusResponse> deleteLaboratoryById(String id) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.deleteRequest(
        path: "/medical_records/laboratory/$id/",
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

  //! PhysicalExamBodyPartInjury
  Future<CustomHttpStatusResponse> createPhysicalExamBodyPartInjury(
      PhysicalExamBodyPartInjury element, int patientDataId) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.postRequest(
        path: "/medical_records/physical-exam-body-part-injury/",
        token: token,
        data: {
          "trauma_register_record_id": patientDataId,
          ...element.toJson(),
        },
      );
      if ((response.statusCode ?? 400) >= 400) {
        return CustomHttpStatusResponse(
          code: response.statusCode,
          result: false,
          message: _convertMessage(_getFirstString(response.data)),
        );
      }
      final int? id = response.data["id"];
      return CustomHttpStatusResponse(
        code: response.statusCode,
        result: true,
        message: "Elemento creado con éxito.",
        idElement: id,
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

  Future<CustomHttpStatusResponse> updatePhysicalExamBodyPartInjury(
      PhysicalExamBodyPartInjury element) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/medical_records/physical-exam-body-part-injury/${element.id}/",
        token: token,
        data: element.toJson(),
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
        message: "Elemento actualizado con éxito.",
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

  Future<CustomHttpStatusResponse> deletePhysicalExamBodyPartInjuryById(
      String id) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.deleteRequest(
        path: "/medical_records/physical-exam-body-part-injury/$id/",
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

  //! Procedure
  Future<CustomHttpStatusResponse> createProcedure(
      Procedure element, int patientDataId) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.postRequest(
        path: "/medical_records/procedure/",
        token: token,
        data: {
          "trauma_register_record_id": patientDataId,
          ...element.toJson(),
        },
      );
      if ((response.statusCode ?? 400) >= 400) {
        return CustomHttpStatusResponse(
          code: response.statusCode,
          result: false,
          message: _convertMessage(_getFirstString(response.data)),
        );
      }
      final int? id = response.data["id"];
      return CustomHttpStatusResponse(
        code: response.statusCode,
        result: true,
        message: "Elemento creado con éxito.",
        idElement: id,
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

  Future<CustomHttpStatusResponse> updateProcedure(Procedure element) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/medical_records/procedure/${element.id}/",
        token: token,
        data: element.toJson(),
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
        message: "Elemento actualizado con éxito.",
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

  Future<CustomHttpStatusResponse> deleteProcedureById(String id) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.deleteRequest(
        path: "/medical_records/procedure/$id/",
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

  //! PrehospitalProcedure
  Future<CustomHttpStatusResponse> createPrehospitalProcedure(
      PrehospitalProcedure element, int patientDataId) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.postRequest(
        path: "/medical_records/prehospital-procedure/",
        token: token,
        data: {
          "trauma_register_record_id": patientDataId,
          ...element.toJson(),
        },
      );
      if ((response.statusCode ?? 400) >= 400) {
        return CustomHttpStatusResponse(
          code: response.statusCode,
          result: false,
          message: _convertMessage(_getFirstString(response.data)),
        );
      }
      final int? id = response.data["id"];
      return CustomHttpStatusResponse(
        code: response.statusCode,
        result: true,
        message: "Elemento creado con éxito.",
        idElement: id,
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

  Future<CustomHttpStatusResponse> updatePrehospitalProcedure(
      PrehospitalProcedure element) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/medical_records/prehospital-procedure/${element.id}/",
        token: token,
        data: element.toJson(),
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
        message: "Elemento actualizado con éxito.",
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

  Future<CustomHttpStatusResponse> deletePrehospitalProcedureById(
      String id) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.deleteRequest(
        path: "/medical_records/prehospital-procedure/$id/",
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

  //! TransportationMode
  Future<CustomHttpStatusResponse> createTransportationMode(
      TransportationMode element, int patientDataId) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.postRequest(
        path: "/medical_records/transportation-mode/",
        token: token,
        data: {
          "trauma_register_record_id": patientDataId,
          ...element.toJson(),
        },
      );
      if ((response.statusCode ?? 400) >= 400) {
        return CustomHttpStatusResponse(
          code: response.statusCode,
          result: false,
          message: _convertMessage(_getFirstString(response.data)),
        );
      }
      final int? id = response.data["id"];
      return CustomHttpStatusResponse(
        code: response.statusCode,
        result: true,
        message: "Elemento creado con éxito.",
        idElement: id,
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

  Future<CustomHttpStatusResponse> updateTransportationMode(
      TransportationMode element) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/medical_records/transportation-mode/${element.id}/",
        token: token,
        data: element.toJson(),
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
        message: "Elemento actualizado con éxito.",
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

  Future<CustomHttpStatusResponse> deleteTransportationModeById(
      String id) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.deleteRequest(
        path: "/medical_records/transportation-mode/$id/",
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

  //! VitalSign
  Future<CustomHttpStatusResponse> createVitalSign(
      VitalSign element, int patientDataId) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.postRequest(
        path: "/medical_records/vital-sign/",
        token: token,
        data: {
          "trauma_register_record_id": patientDataId,
          ...element.toJson(),
        },
      );
      final int? id = response.data["record_id"];
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
        message: "Elemento creado con éxito.",
        idElement: id,
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

  Future<CustomHttpStatusResponse> updateVitalSign(VitalSign element) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/medical_records/vital-sign/${element.recordId}/",
        token: token,
        data: element.toJson(),
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
        message: "Elemento actualizado con éxito.",
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

  Future<CustomHttpStatusResponse> deleteVitalSignById(String id) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.deleteRequest(
        path: "/medical_records/vital-sign/$id/",
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
