import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/enums/action_type.dart';
import 'package:trauma_register_frontend/core/helpers/print_error.dart';
import 'package:trauma_register_frontend/data/models/http_response/custom_http_status_response.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/trauma_data.dart';
import 'package:trauma_register_frontend/data/services/trauma_data_service.dart';

class TraumaDataProvider extends ChangeNotifier {
  // Patient trauma data
  PatientData? patientData;
  CustomHttpStatusResponse response = CustomHttpStatusResponse();
  ActionType action = ActionType.buscar;

  // Method to update the patientData
  void updatePatientData(PatientData? patientData,
      [bool allowNotifyListener = false]) {
    this.patientData = patientData;
    if (allowNotifyListener) notifyListeners();
  }

  Future<PatientData?> getPatientDataById(String traumaRegisterRecordId) async {
    try {
      final traumaDataService = TraumaDataService();
      final result =
          await traumaDataService.getPatientDataById(traumaRegisterRecordId);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      return null;
    }
  }

  Future<bool> deletePatientDataById(String traumaRegisterRecordId) async {
    try {
      final traumaDataService = TraumaDataService();
      final bool result =
          await traumaDataService.deletePatientDataById(traumaRegisterRecordId);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      return false;
    }
  }

  Future<bool> createPatientData(PatientData patientData) async {
    try {
      final traumaDataService = TraumaDataService();
      response = await traumaDataService.createPatientData(patientData);
      notifyListeners();
      final bool result = response.result ?? false;
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      return false;
    }
  }

  Future<CustomHttpStatusResponse> createHealthcareRecord(
      HealthcareRecord element, int patientDataId) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.createHealthcareRecord(element, patientDataId);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> updateHealthcareRecord(
      HealthcareRecord element, int patientDataId) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.updateHealthcareRecord(element, patientDataId);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> deleteHealthcareRecordById(String id) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.deleteHealthcareRecordById(id);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> createInjuryRecord(
      InjuryRecord element, int patientDataId) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.createInjuryRecord(element, patientDataId);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> updateInjuryRecord(
      InjuryRecord element, int patientDataId) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.updateInjuryRecord(element, patientDataId);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> deleteInjuryRecordById(String id) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.deleteInjuryRecordById(id);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> createCollision(
      Collision element, int patientDataId) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.createCollision(element, patientDataId);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> updateCollision(Collision element) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.updateCollision(element);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> deleteCollisionById(String id) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.deleteCollisionById(id);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  void updateAction(ActionType action) {
    this.action = action;
    notifyListeners();
  }
}
