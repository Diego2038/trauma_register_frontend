import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/helpers/print_error.dart';
import 'package:trauma_register_frontend/data/models/stats/categorical_stats.dart';
import 'package:trauma_register_frontend/data/models/stats/single_value_stats.dart';
import 'package:trauma_register_frontend/data/models/stats/time_serie.dart';
import 'package:trauma_register_frontend/data/services/time_serie_service.dart';
import 'package:trauma_register_frontend/data/services/trauma_stats_service.dart';

class TraumaStatsProvider extends ChangeNotifier {
  DateTime? globalStartDate;
  DateTime? globalEndDate;

  DateTime? gendersStartDate;
  DateTime? gendersEndDate;

  DateTime? amountOfPatientsStartDate;
  DateTime? amountOfPatientsEndDate;

  DateTime? patientsAgesStartDate;
  DateTime? patientsAgesEndDate;

  DateTime? patientsWithRelationsStartDate;
  DateTime? patientsWithRelationsEndDate;

  DateTime? insuredPatientsStartDate;
  DateTime? insuredPatientsEndDate;

  DateTime? typeOfPatientsAdmissionStartDate;
  DateTime? typeOfPatientsAdmissionEndDate;

  DateTime? traumaCountByDateStartDate;
  DateTime? traumaCountByDateEndDate;

  void updateGlobalStartDate(DateTime? date) {
    globalStartDate = date;
    gendersStartDate = null;
    amountOfPatientsStartDate = null;
    patientsAgesStartDate = null;
    patientsWithRelationsStartDate = null;
    insuredPatientsStartDate = null;
    typeOfPatientsAdmissionStartDate = null;
    traumaCountByDateStartDate = null;
    notifyListeners();
  }

  void updateGlobalEndDate(DateTime? date) {
    globalEndDate = date;
    gendersEndDate = null;
    amountOfPatientsEndDate = null;
    patientsAgesEndDate = null;
    patientsWithRelationsEndDate = null;
    insuredPatientsEndDate = null;
    typeOfPatientsAdmissionEndDate = null;
    traumaCountByDateEndDate = null;
    notifyListeners();
  }

  void clearGlobalDates() {
    globalStartDate = null;
    gendersStartDate = null;
    amountOfPatientsStartDate = null;
    patientsAgesStartDate = null;
    patientsWithRelationsStartDate = null;
    insuredPatientsStartDate = null;
    typeOfPatientsAdmissionStartDate = null;
    traumaCountByDateStartDate = null;
    globalEndDate = null;
    gendersEndDate = null;
    amountOfPatientsEndDate = null;
    patientsAgesEndDate = null;
    patientsWithRelationsEndDate = null;
    insuredPatientsEndDate = null;
    typeOfPatientsAdmissionEndDate = null;
    traumaCountByDateEndDate = null;
    notifyListeners();
  }

  void updateGendersStartDate(DateTime? date) {
    gendersStartDate = date;
    notifyListeners();
  }

  void updateGendersEndDate(DateTime? date) {
    gendersEndDate = date;
    notifyListeners();
  }

  void clearGendersDates() {
    gendersStartDate = null;
    gendersEndDate = null;
    notifyListeners();
  }

  void updateAmountOfPatientsStartDate(DateTime? date) {
    amountOfPatientsStartDate = date;
    notifyListeners();
  }

  void updateAmountOfPatientsEndDate(DateTime? date) {
    amountOfPatientsEndDate = date;
    notifyListeners();
  }

  void clearAmountOfPatientsDates() {
    amountOfPatientsStartDate = null;
    amountOfPatientsEndDate = null;
    notifyListeners();
  }

  void updatePatientsAgesStartDate(DateTime? date) {
    patientsAgesStartDate = date;
    notifyListeners();
  }

  void updatePatientsAgesEndDate(DateTime? date) {
    patientsAgesEndDate = date;
    notifyListeners();
  }

  void clearPatientsAgesDates() {
    patientsAgesStartDate = null;
    patientsAgesEndDate = null;
    notifyListeners();
  }

  void updatePatientsWithRelationsStartDate(DateTime? date) {
    patientsWithRelationsStartDate = date;
    notifyListeners();
  }

  void updatePatientsWithRelationsEndDate(DateTime? date) {
    patientsWithRelationsEndDate = date;
    notifyListeners();
  }

  void clearPatientsWithRelationsDates() {
    patientsWithRelationsStartDate = null;
    patientsWithRelationsEndDate = null;
    notifyListeners();
  }

  void updateInsuredPatientsStartDate(DateTime? date) {
    insuredPatientsStartDate = date;
    notifyListeners();
  }

  void updateInsuredPatientsEndDate(DateTime? date) {
    insuredPatientsEndDate = date;
    notifyListeners();
  }

  void clearInsuredPatientsDates() {
    insuredPatientsStartDate = null;
    insuredPatientsEndDate = null;
    notifyListeners();
  }

  void updateTypeOfPatientsAdmissionStartDate(DateTime? date) {
    typeOfPatientsAdmissionStartDate = date;
    notifyListeners();
  }

  void updateTypeOfPatientsAdmissionEndDate(DateTime? date) {
    typeOfPatientsAdmissionEndDate = date;
    notifyListeners();
  }

  void clearTypeOfPatientsAdmissionDates() {
    typeOfPatientsAdmissionStartDate = null;
    typeOfPatientsAdmissionEndDate = null;
    notifyListeners();
  }

  void updateTraumaCountByDateStartDate(DateTime? date) {
    traumaCountByDateStartDate = date;
    notifyListeners();
  }

  void updateTraumaCountByDateEndDate(DateTime? date) {
    traumaCountByDateEndDate = date;
    notifyListeners();
  }

  void clearTraumaCountByDateDates() {
    traumaCountByDateStartDate = null;
    traumaCountByDateEndDate = null;
    notifyListeners();
  }

  Future<SingleValueStats?> getAmountOfPatients({
    required DateTime? startDate,
    required DateTime? endDate,
  }) async {
    try {
      final traumaStatsService = TraumaStatsService();
      return await traumaStatsService.getAmountOfPatients(
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e, s) {
      PrintError.makePrint(
        e: e,
        ubication: 'trauma_stats_provider.dart',
        stack: s,
      );
      return null;
    }
  }

  Future<CategoricalStats?> getGenders({
    required DateTime? startDate,
    required DateTime? endDate,
  }) async {
    try {
      final traumaStatsService = TraumaStatsService();
      return await traumaStatsService.getGenders(
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e, s) {
      PrintError.makePrint(
        e: e,
        ubication: 'trauma_stats_provider.dart',
        stack: s,
      );
      return null;
    }
  }

  Future<CategoricalStats?> getPatientsAges({
    required DateTime? startDate,
    required DateTime? endDate,
  }) async {
    try {
      final traumaStatsService = TraumaStatsService();
      return await traumaStatsService.getPatientsAges(
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e, s) {
      PrintError.makePrint(
        e: e,
        ubication: 'trauma_stats_provider.dart',
        stack: s,
      );
      return null;
    }
  }

  Future<CategoricalStats?> getPatientsWithRelations({
    required DateTime? startDate,
    required DateTime? endDate,
  }) async {
    try {
      final traumaStatsService = TraumaStatsService();
      return await traumaStatsService.getPatientsWithRelations(
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e, s) {
      PrintError.makePrint(
        e: e,
        ubication: 'trauma_stats_provider.dart',
        stack: s,
      );
      return null;
    }
  }

  Future<CategoricalStats?> getInsuredPatients({
    required DateTime? startDate,
    required DateTime? endDate,
  }) async {
    try {
      final traumaStatsService = TraumaStatsService();
      return await traumaStatsService.getInsuredPatients(
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e, s) {
      PrintError.makePrint(
        e: e,
        ubication: 'trauma_stats_provider.dart',
        stack: s,
      );
      return null;
    }
  }

  Future<CategoricalStats?> getTypeOfPatientsAdmission({
    required DateTime? startDate,
    required DateTime? endDate,
  }) async {
    try {
      final traumaStatsService = TraumaStatsService();
      return await traumaStatsService.getTypeOfPatientsAdmission(
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e, s) {
      PrintError.makePrint(
        e: e,
        ubication: 'trauma_stats_provider.dart',
        stack: s,
      );
      return null;
    }
  }

  Future<TimeSeries?> getTraumaCountByDate({
    required DateTime? startDate,
    required DateTime? endDate,
  }) async {
    try {
      final timeSeriesService = TimeSeriesService();
      return timeSeriesService.getTraumaCountByDate(
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e, s) {
      PrintError.makePrint(
        e: e,
        ubication: 'trauma_stats_provider.dart',
        stack: s,
      );
      return null;
    }
  }
}
