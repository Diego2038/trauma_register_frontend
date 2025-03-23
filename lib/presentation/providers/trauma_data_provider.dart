import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/helpers/print_error.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/trauma_data.dart';
import 'package:trauma_register_frontend/data/services/trauma_data_service.dart';



class TraumaDataProvider extends ChangeNotifier {
  
  Future<PatientData?> getPatientDataById(String traumaRegisterRecordId) async {

    try {
      final traumaDataService = TraumaDataService();
      return traumaDataService.getPatientDataById(traumaRegisterRecordId);
    } catch(e, s) {
      PrintError.makePrint(e: e, ubication: 'trauma_data_provider.dart', stack: s);
      return null;
    }
  }

}
