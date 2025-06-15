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

  void updateGlobalStartDate(DateTime? date) {
    globalStartDate = date;
    notifyListeners();
  }

  void updateGlobalEndDate(DateTime? date) {
    globalEndDate = date;
    notifyListeners();
  }

  void clearGlobalDates() {
    globalStartDate = null;
    globalEndDate = null;
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
