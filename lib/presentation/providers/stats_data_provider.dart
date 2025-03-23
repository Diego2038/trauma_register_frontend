import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/helpers/print_error.dart';
import 'package:trauma_register_frontend/data/services/stats_data_service.dart';



class StatsDataProvider extends ChangeNotifier {
  
  Future<List<Map<String,dynamic>>?> getStatsPatientsGenders() async {
    try {
      final statsDataService = StatsDataService();
      return statsDataService.getStatsPatientsGenders();
    } catch(e, s) {
      PrintError.makePrint(e: e, ubication: 'stats_data_provider.dart', stack: s);
      return null;
    }
  }

  Future<List<Map<String,int>>?> getStatsPatientsAges() async {
    try {
      final statsDataService = StatsDataService();
      return statsDataService.getStatsPatientsAges();
    } catch(e, s) {
      PrintError.makePrint(e: e, ubication: 'stats_data_provider.dart', stack: s);
      return null;
    }
  }

  Future<Map<String,int>?> getStatsPatientsWithRelations() async {
    try {
      final statsDataService = StatsDataService();
      return statsDataService.getStatsPatientsWithRelations();
    } catch(e, s) {
      PrintError.makePrint(e: e, ubication: 'stats_data_provider.dart', stack: s);
      return null;
    }
  }

}
