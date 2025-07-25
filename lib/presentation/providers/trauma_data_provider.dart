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

  Future<CustomHttpStatusResponse> updatePatientDataElement(
      PatientData element) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.updatePatientDataElement(element);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
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
      HealthcareRecord element) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.updateHealthcareRecord(element);
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
      InjuryRecord element) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.updateInjuryRecord(element);
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

  //! DrugAbuse
  Future<CustomHttpStatusResponse> createDrugAbuse(
      DrugAbuse element, int patientDataId) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.createDrugAbuse(element, patientDataId);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> updateDrugAbuse(DrugAbuse element) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.updateDrugAbuse(element);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> deleteDrugAbuseById(String id) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.deleteDrugAbuseById(id);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  //! VitalSignGcsQualifier
  Future<CustomHttpStatusResponse> createVitalSignGcsQualifier(
      VitalSignGcsQualifier element, int patientDataId) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.createVitalSignGcsQualifier(element, patientDataId);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> updateVitalSignGcsQualifier(VitalSignGcsQualifier element) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.updateVitalSignGcsQualifier(element);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> deleteVitalSignGcsQualifierById(String id) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.deleteVitalSignGcsQualifierById(id);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  //! HospitalizationVariable
  Future<CustomHttpStatusResponse> createHospitalizationVariable(
      HospitalizationVariable element, int patientDataId) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.createHospitalizationVariable(element, patientDataId);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> updateHospitalizationVariable(HospitalizationVariable element) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.updateHospitalizationVariable(element);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> deleteHospitalizationVariableById(String id) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.deleteHospitalizationVariableById(id);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  //! HospitalizationComplication
  Future<CustomHttpStatusResponse> createHospitalizationComplication(
      HospitalizationComplication element, int patientDataId) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.createHospitalizationComplication(element, patientDataId);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> updateHospitalizationComplication(HospitalizationComplication element) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.updateHospitalizationComplication(element);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> deleteHospitalizationComplicationById(String id) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.deleteHospitalizationComplicationById(id);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  //! TraumaRegisterIcd10
  Future<CustomHttpStatusResponse> createTraumaRegisterIcd10(
      TraumaRegisterIcd10 element, int patientDataId) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.createTraumaRegisterIcd10(element, patientDataId);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> updateTraumaRegisterIcd10(TraumaRegisterIcd10 element) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.updateTraumaRegisterIcd10(element);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> deleteTraumaRegisterIcd10ById(String id) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.deleteTraumaRegisterIcd10ById(id);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  //! IntensiveCareUnit
  Future<CustomHttpStatusResponse> createIntensiveCareUnit(
      IntensiveCareUnit element, int patientDataId) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.createIntensiveCareUnit(element, patientDataId);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> updateIntensiveCareUnit(IntensiveCareUnit element) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.updateIntensiveCareUnit(element);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> deleteIntensiveCareUnitById(String id) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.deleteIntensiveCareUnitById(id);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  //! Imaging
  Future<CustomHttpStatusResponse> createImaging(
      Imaging element, int patientDataId) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.createImaging(element, patientDataId);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> updateImaging(Imaging element) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.updateImaging(element);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> deleteImagingById(String id) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.deleteImagingById(id);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  //! ApparentIntentInjury
  Future<CustomHttpStatusResponse> createApparentIntentInjury(
      ApparentIntentInjury element, int patientDataId) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.createApparentIntentInjury(element, patientDataId);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> updateApparentIntentInjury(ApparentIntentInjury element) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.updateApparentIntentInjury(element);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> deleteApparentIntentInjuryById(String id) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.deleteApparentIntentInjuryById(id);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  //! BurnInjury
  Future<CustomHttpStatusResponse> createBurnInjury(
      BurnInjury element, int patientDataId) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.createBurnInjury(element, patientDataId);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> updateBurnInjury(BurnInjury element) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.updateBurnInjury(element);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> deleteBurnInjuryById(String id) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.deleteBurnInjuryById(id);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  //! FirearmInjury
  Future<CustomHttpStatusResponse> createFirearmInjury(
      FirearmInjury element, int patientDataId) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.createFirearmInjury(element, patientDataId);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> updateFirearmInjury(FirearmInjury element) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.updateFirearmInjury(element);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> deleteFirearmInjuryById(String id) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.deleteFirearmInjuryById(id);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  //! PenetratingInjury
  Future<CustomHttpStatusResponse> createPenetratingInjury(
      PenetratingInjury element, int patientDataId) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.createPenetratingInjury(element, patientDataId);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> updatePenetratingInjury(PenetratingInjury element) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.updatePenetratingInjury(element);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> deletePenetratingInjuryById(String id) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.deletePenetratingInjuryById(id);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  //! PoisoningInjury
  Future<CustomHttpStatusResponse> createPoisoningInjury(
      PoisoningInjury element, int patientDataId) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.createPoisoningInjury(element, patientDataId);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> updatePoisoningInjury(PoisoningInjury element) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.updatePoisoningInjury(element);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> deletePoisoningInjuryById(String id) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.deletePoisoningInjuryById(id);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  //! ViolenceInjury
  Future<CustomHttpStatusResponse> createViolenceInjury(
      ViolenceInjury element, int patientDataId) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.createViolenceInjury(element, patientDataId);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> updateViolenceInjury(ViolenceInjury element) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.updateViolenceInjury(element);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> deleteViolenceInjuryById(String id) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.deleteViolenceInjuryById(id);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  //! Device
  Future<CustomHttpStatusResponse> createDevice(
      Device element, int patientDataId) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.createDevice(element, patientDataId);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> updateDevice(Device element) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.updateDevice(element);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> deleteDeviceById(String id) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.deleteDeviceById(id);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  //! Laboratory
  Future<CustomHttpStatusResponse> createLaboratory(
      Laboratory element, int patientDataId) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.createLaboratory(element, patientDataId);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> updateLaboratory(Laboratory element) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.updateLaboratory(element);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> deleteLaboratoryById(String id) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.deleteLaboratoryById(id);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  //! PhysicalExamBodyPartInjury
  Future<CustomHttpStatusResponse> createPhysicalExamBodyPartInjury(
      PhysicalExamBodyPartInjury element, int patientDataId) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.createPhysicalExamBodyPartInjury(element, patientDataId);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> updatePhysicalExamBodyPartInjury(PhysicalExamBodyPartInjury element) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.updatePhysicalExamBodyPartInjury(element);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> deletePhysicalExamBodyPartInjuryById(String id) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.deletePhysicalExamBodyPartInjuryById(id);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  //! Procedure
  Future<CustomHttpStatusResponse> createProcedure(
      Procedure element, int patientDataId) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.createProcedure(element, patientDataId);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> updateProcedure(Procedure element) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.updateProcedure(element);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> deleteProcedureById(String id) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.deleteProcedureById(id);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  //! PrehospitalProcedure
  Future<CustomHttpStatusResponse> createPrehospitalProcedure(
      PrehospitalProcedure element, int patientDataId) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.createPrehospitalProcedure(element, patientDataId);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> updatePrehospitalProcedure(PrehospitalProcedure element) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.updatePrehospitalProcedure(element);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> deletePrehospitalProcedureById(String id) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.deletePrehospitalProcedureById(id);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  //! TransportationMode
  Future<CustomHttpStatusResponse> createTransportationMode(
      TransportationMode element, int patientDataId) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.createTransportationMode(element, patientDataId);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> updateTransportationMode(TransportationMode element) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.updateTransportationMode(element);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> deleteTransportationModeById(String id) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.deleteTransportationModeById(id);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  //! VitalSign
  Future<CustomHttpStatusResponse> createVitalSign(
      VitalSign element, int patientDataId) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.createVitalSign(element, patientDataId);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> updateVitalSign(VitalSign element) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.updateVitalSign(element);
      return result;
    } catch (e, s) {
      PrintError.makePrint(
          e: e, ubication: 'trauma_data_provider.dart', stack: s);
      rethrow;
    }
  }

  Future<CustomHttpStatusResponse> deleteVitalSignById(String id) async {
    try {
      final traumaDataService = TraumaDataService();
      final CustomHttpStatusResponse result =
          await traumaDataService.deleteVitalSignById(id);
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
