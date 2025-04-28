import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/helpers/print_error.dart';
import 'package:trauma_register_frontend/data/models/stats/categorical_stats.dart';
import 'package:trauma_register_frontend/data/models/stats/single_value_stats.dart';
import 'package:trauma_register_frontend/data/services/trauma_stats_service.dart';

class TraumaStatsProvider extends ChangeNotifier {
  
  Future<SingleValueStats?> getAmountOfPatients() async {
    try {
      final traumaStatsService = TraumaStatsService();
      return await traumaStatsService.getAmountOfPatients();
    } catch (e, s) {
      PrintError.makePrint(
        e: e,
        ubication: 'trauma_stats_provider.dart',
        stack: s,
      );
      return null;
    }
  }

  Future<CategoricalStats?> getGenders() async {
    try {
      final traumaStatsService = TraumaStatsService();
      return await traumaStatsService.getGenders();
    } catch (e, s) {
      PrintError.makePrint(
        e: e,
        ubication: 'trauma_stats_provider.dart',
        stack: s,
      );
      return null;
    }
  }

  Future<CategoricalStats?> getPatientsAges() async {
    try {
      final traumaStatsService = TraumaStatsService();
      return await traumaStatsService.getPatientsAges();
    } catch (e, s) {
      PrintError.makePrint(
        e: e,
        ubication: 'trauma_stats_provider.dart',
        stack: s,
      );
      return null;
    }
  }

  Future<CategoricalStats?> getPatientsWithRelations() async {
    try {
      final traumaStatsService = TraumaStatsService();
      return await traumaStatsService.getPatientsWithRelations();
    } catch (e, s) {
      PrintError.makePrint(
        e: e,
        ubication: 'trauma_stats_provider.dart',
        stack: s,
      );
      return null;
    }
  }

  Future<CategoricalStats?> getInsuredPatients() async {
    try {
      final traumaStatsService = TraumaStatsService();
      return await traumaStatsService.getInsuredPatients();
    } catch (e, s) {
      PrintError.makePrint(
        e: e,
        ubication: 'trauma_stats_provider.dart',
        stack: s,
      );
      return null;
    }
  }

  Future<CategoricalStats?> getTypeOfPatientsAdmission() async {
    try {
      final traumaStatsService = TraumaStatsService();
      return await traumaStatsService.getTypeOfPatientsAdmission();
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