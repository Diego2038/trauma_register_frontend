import 'package:trauma_register_frontend/core/helpers/endpoint_helper.dart';
import 'package:trauma_register_frontend/core/helpers/local_storage.dart';
import 'package:trauma_register_frontend/core/helpers/print_error.dart';
import 'package:trauma_register_frontend/data/models/stats/categorical_stats.dart';
import 'package:trauma_register_frontend/data/models/stats/single_value_stats.dart';

class TraumaStatsService {
  Future<SingleValueStats?> getAmountOfPatients() async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.getRequest(
        path: "/data_analysis/amount-of-patient-data-stats/",
        token: token,
      );
      if (response.statusCode == 404) return null;
      final data = response.data as Map<String, dynamic>;
      return SingleValueStats.fromJson(data);
    } catch (e, s) {
      PrintError.makePrint(
        e: e,
        ubication: 'trauma_stats_service.dart',
        stack: s,
      );
      return null;
    }
  }

  Future<CategoricalStats?> getGenders() async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.getRequest(
        path: "/data_analysis/gender-stats/",
        token: token,
      );
      if (response.statusCode == 404) return null;
      final data = response.data as Map<String, dynamic>;
      return CategoricalStats.fromJson(data);
    } catch (e, s) {
      PrintError.makePrint(
        e: e,
        ubication: 'trauma_stats_service.dart',
        stack: s,
      );
      return null;
    }
  }

  Future<CategoricalStats?> getPatientsAges() async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.getRequest(
        path: "/data_analysis/patient-age-stats/",
        token: token,
      );
      if (response.statusCode == 404) return null;
      final data = response.data as Map<String, dynamic>;
      return CategoricalStats.fromJson(data);
    } catch (e, s) {
      PrintError.makePrint(
        e: e,
        ubication: 'trauma_stats_service.dart',
        stack: s,
      );
      return null;
    }
  }

  Future<CategoricalStats?> getPatientsWithRelations() async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.getRequest(
        path: "/data_analysis/patient-with-relations-stats/",
        token: token,
      );
      if (response.statusCode == 404) return null;
      final data = response.data as Map<String, dynamic>;
      return CategoricalStats.fromJson(data);
    } catch (e, s) {
      PrintError.makePrint(
        e: e,
        ubication: 'trauma_stats_service.dart',
        stack: s,
      );
      return null;
    }
  }

  Future<CategoricalStats?> getInsuredPatients() async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.getRequest(
        path: "/data_analysis/obtain-insured-patients-stats/",
        token: token,
      );
      if (response.statusCode == 404) return null;
      final data = response.data as Map<String, dynamic>;
      return CategoricalStats.fromJson(data);
    } catch (e, s) {
      PrintError.makePrint(
        e: e,
        ubication: 'trauma_stats_service.dart',
        stack: s,
      );
      return null;
    }
  }

  Future<CategoricalStats?> getTypeOfPatientsAdmission() async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.getRequest(
        path: "/data_analysis/type-of-patient-admission-stats/",
        token: token,
      );
      if (response.statusCode == 404) return null;
      final data = response.data as Map<String, dynamic>;
      return CategoricalStats.fromJson(data);
    } catch (e, s) {
      PrintError.makePrint(
        e: e,
        ubication: 'trauma_stats_service.dart',
        stack: s,
      );
      return null;
    }
  }
}
