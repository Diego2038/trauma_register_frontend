import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/helpers/print_error.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/trauma_data.dart';
import 'package:trauma_register_frontend/data/services/trauma_data_service.dart';

class TraumaDataProvider extends ChangeNotifier {
  // List of expansion states for each widget (by default, all are false)
  List<bool> _expandedStates = [];

  int currentAmountExpandedStates() => _expandedStates.length;

  // This controls whether all widgets should expand or collapse.
  bool isAllExpanded = false;

  // Method to update the expansion state of a specific widget
  void toggleExpansion(int index) {
    _expandedStates[index] = !_expandedStates[index];
    notifyListeners();
  }

  // Method to expand or collapse all widgets at once
  void setAllExpanded(bool expanded) {
    isAllExpanded = expanded;
    _expandedStates = List.filled(_expandedStates.length, expanded);
    notifyListeners();
  }

  // Method to initialize the expansion state list
  void initializeExpansions(int count) {
    _expandedStates = List.filled(count, false);
    notifyListeners();
  }

  bool getExpansionState(int index) => _expandedStates[index];

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
