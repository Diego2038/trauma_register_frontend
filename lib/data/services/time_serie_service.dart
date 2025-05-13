import 'package:trauma_register_frontend/core/helpers/endpoint_helper.dart';
import 'package:trauma_register_frontend/core/helpers/local_storage.dart';
import 'package:trauma_register_frontend/core/helpers/print_error.dart';
import 'package:trauma_register_frontend/data/models/stats/time_serie.dart';

class TimeSeriesService {
  Future<TimeSeries?> getTraumaCountByDate() async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.getRequest(
        path: "/data_analysis/trauma-count-by-date-stats/",
        token: token,
      );
      if (response.statusCode == 404) return null;
      final data = response.data as Map<String, dynamic>;
      return TimeSeries.fromJson(data);
    } catch (e, s) {
      PrintError.makePrint(
        e: e,
        ubication: 'time_series_service.dart',
        stack: s,
      );
      return null;
    }
  }
}
