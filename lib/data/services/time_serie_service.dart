import 'package:intl/intl.dart';
import 'package:trauma_register_frontend/core/helpers/endpoint_helper.dart';
import 'package:trauma_register_frontend/core/helpers/local_storage.dart';
import 'package:trauma_register_frontend/core/helpers/print_error.dart';
import 'package:trauma_register_frontend/data/models/stats/time_serie.dart';

class TimeSeriesService {
  Future<TimeSeries?> getTraumaCountByDate({
    required DateTime? startDate,
    required DateTime? endDate,
  }) async {
    try {
      final String? token = LocalStorage.prefs.getString('token');
      final response = await EndpointHelper.putRequest(
        path: "/data_analysis/trauma-count-by-date-stats/0/",
        token: token,
        data: {
          if (startDate != null) 'start_date': DateFormat('yyyy-MM-dd').format(startDate),
          if (endDate != null) 'end_date': DateFormat('yyyy-MM-dd').format(endDate),
        },
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
