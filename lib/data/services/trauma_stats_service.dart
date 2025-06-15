import 'package:intl/intl.dart';
import 'package:trauma_register_frontend/core/helpers/endpoint_helper.dart';
import 'package:trauma_register_frontend/core/helpers/local_storage.dart';
import 'package:trauma_register_frontend/core/helpers/print_error.dart';
import 'package:trauma_register_frontend/data/models/stats/categorical_stats.dart';
import 'package:trauma_register_frontend/data/models/stats/single_value_stats.dart';

class TraumaStatsService {
  Future<SingleValueStats?> getAmountOfPatients({
    required DateTime? startDate,
    required DateTime? endDate,
  }) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/data_analysis/amount-of-patient-data-stats/0/",
        token: token,
        data: {
          if (startDate != null) 'start_date': DateFormat('yyyy-MM-dd').format(startDate),
          if (endDate != null) 'end_date': DateFormat('yyyy-MM-dd').format(endDate),
        },
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

  Future<CategoricalStats?> getGenders({
    required DateTime? startDate,
    required DateTime? endDate,
  }) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/data_analysis/gender-stats/0/",
        token: token,
        data: {
          if (startDate != null) 'start_date': DateFormat('yyyy-MM-dd').format(startDate),
          if (endDate != null) 'end_date': DateFormat('yyyy-MM-dd').format(endDate),
        },
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

  Future<CategoricalStats?> getPatientsAges({
    required DateTime? startDate,
    required DateTime? endDate,
  }) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/data_analysis/patient-age-stats/0/",
        token: token,
        data: {
          if (startDate != null) 'start_date': DateFormat('yyyy-MM-dd').format(startDate),
          if (endDate != null) 'end_date': DateFormat('yyyy-MM-dd').format(endDate),
        },
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

  Future<CategoricalStats?> getPatientsWithRelations({
    required DateTime? startDate,
    required DateTime? endDate,
  }) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/data_analysis/patient-with-relations-stats/0/",
        token: token,
        data: {
          if (startDate != null) 'start_date': DateFormat('yyyy-MM-dd').format(startDate),
          if (endDate != null) 'end_date': DateFormat('yyyy-MM-dd').format(endDate),
        },
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

  Future<CategoricalStats?> getInsuredPatients({
    required DateTime? startDate,
    required DateTime? endDate,
  }) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/data_analysis/obtain-insured-patients-stats/0/",
        token: token,
        data: {
          if (startDate != null) 'start_date': DateFormat('yyyy-MM-dd').format(startDate),
          if (endDate != null) 'end_date': DateFormat('yyyy-MM-dd').format(endDate),
        },
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

  Future<CategoricalStats?> getTypeOfPatientsAdmission({
    required DateTime? startDate,
    required DateTime? endDate,
  }) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/data_analysis/type-of-patient-admission-stats/0/",
        token: token,
        data: {
          if (startDate != null) 'start_date': DateFormat('yyyy-MM-dd').format(startDate),
          if (endDate != null) 'end_date': DateFormat('yyyy-MM-dd').format(endDate),
        },
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
