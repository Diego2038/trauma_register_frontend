import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/helpers/print_error.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/trauma_data.dart';
import 'package:trauma_register_frontend/data/services/trauma_data_service.dart';

class TraumaDataProvider extends ChangeNotifier {

  // Patient trauma data
  PatientData? patientData;

  // Method to update the patientData
  void updatePatientData(PatientData? patientData, [bool allowNotifyListener = false]) {
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
      final bool result = await traumaDataService.deletePatientDataById(traumaRegisterRecordId);
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
      final bool result = await traumaDataService.createPatientData(patientData);
      return result;                    
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      return false;
    }
  }
}
