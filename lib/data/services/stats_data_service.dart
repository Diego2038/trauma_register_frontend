

import 'package:trauma_register_frontend/core/helpers/endpoint_helper.dart';
import 'package:trauma_register_frontend/core/helpers/local_storage.dart';
import 'package:trauma_register_frontend/core/helpers/print_error.dart';

class StatsDataService {

  Future<List<Map<String,dynamic>>?> getStatsPatientsGenders() async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.getRequest(path: "/data_analysis/gender-stats/", token: token);
      if (response.statusCode == 404) return null;
      print(response.data);
      // final data = response.data["data"] as List<Map<String,dynamic>>;
      final List<dynamic> rawData = response.data["data"];
      final List<Map<String, dynamic>> data = rawData.map((e) => Map<String, dynamic>.from(e)).toList();
      return data;
    } catch(e, s) {
      PrintError.makePrint(e: e, ubication: 'stats_data_service.dart', stack: s);
      return null;
    }
  }

  Future<List<Map<String,int>>?> getStatsPatientsAges() async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.getRequest(path: "/data_analysis/patient-age-stats/", token: token);
      if (response.statusCode == 404) return null;
      // final data = response.data["data"] as List<Map<String,int>>;
      final List<dynamic> rawData = response.data["data"];
      final List<Map<String, int>> data = rawData.map((e) => Map<String, int>.from(e)).toList();
      return data;
    } catch(e, s) {
      PrintError.makePrint(e: e, ubication: 'stats_data_service.dart', stack: s);
      return null;
    }
  }

  Future<Map<String,int>?> getStatsPatientsWithRelations() async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.getRequest(path: "/data_analysis/patient-with-relations-stats/", token: token);
      if (response.statusCode == 404) return null;
      // final data = response.data["data"] as Map<String,int>;
      final Map<String, dynamic> rawData = response.data["data"];
      final Map<String, int> data = rawData.map((key, value) => MapEntry(key, (value as num).toInt()));

      return data;
    } catch(e, s) {
      PrintError.makePrint(e: e, ubication: 'stats_data_service.dart', stack: s);
      return null;
    }
  }

}